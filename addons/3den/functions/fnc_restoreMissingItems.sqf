#include "script_component.hpp"
/*
	Restore missing framework items (3DEN helper).

	This version intentionally does NOT use collect3DENHistory (undo).
	It prioritizes robustness: it creates all missing items in one run.
*/

private _menuData = uiNamespace getVariable ["BIS_fnc_3DENEntityMenu_data", []];

private _fnc_posFromMenuData = {
	params ["_md"]; 
	private _p0 = [];

	if (_md isEqualType []) then {
		if ((count _md) >= 2 && {(_md select 0) isEqualType 0}) then {
			_p0 = +_md;
		} else {
			private _md0 = _md param [0, []];
			if (_md0 isEqualType objNull) then {
				if (!isNull _md0) then { _p0 = getPosATL _md0; };
			} else {
				if (_md0 isEqualType [] && {(count _md0) >= 2}) then { _p0 = +_md0; };
			};
		};
	};

	if (_p0 isEqualTo []) then {
		private _stw = screenToWorld getMousePosition;
		if (_stw isEqualType [] && {(count _stw) >= 2}) then { _p0 = +_stw; };
	};

	if ((count _p0) < 2) exitWith { [] };
	if ((count _p0) < 3) then { _p0 pushBack 0; };
	_p0 set [2, 0];
	_p0
};

private _p0 = [_menuData] call _fnc_posFromMenuData;
if !(
	_p0 isEqualType []
	&& { (count _p0) >= 2 }
	&& { (_p0 select 0) isEqualType 0 }
	&& { (_p0 select 1) isEqualType 0 }
) exitWith {
	["Restore Missing Items: invalid click position", 1, 6, true] call BIS_fnc_3DENNotification;
	false
};

// Cache as scalars to avoid any runtime weirdness with `select` on invalid/EMPTY values.
private _p0x = _p0 select 0;
private _p0y = _p0 select 1;

private _fnc_hasNamedObject = {
	params ["_objects", "_wantedNameLower"];
	({ toLower(((_x get3DENAttribute "name") select 0)) isEqualTo _wantedNameLower } count _objects) > 0
};

private _fnc_getNamedEntity = {
	params ["_entities", "_wantedNameLower"];
	private _found = objNull;
	{
		private _n = toLower(((_x get3DENAttribute "name") select 0));
		if (_n isEqualTo _wantedNameLower) exitWith { _found = _x; };
	} forEach _entities;
	_found
};

private _fnc_getEntityPos = {
	params ["_e"];
	private _p = [];
	if (_e isEqualType objNull && {!isNull _e}) then {
		_p = ((_e get3DENAttribute "position") param [0, []]);
		if (!(_p isEqualType []) || {(count _p) < 2}) then { _p = getPosATL _e; };
	};
	if (_p isEqualType [] && {(count _p) >= 2}) then {
		if ((count _p) < 3) then { _p pushBack 0; };
		_p set [2, 0];
		_p
	} else {
		[]
	}
};

private _fnc_setEntityAttrs = {
	params ["_e", "_attrs"]; // object or logic
	{ _x params ["_key", "_val"]; _e set3DENAttribute [_key, _val]; } forEach _attrs;
};

private _fnc_getFirstByType = {
	params ["_objects", "_className"];
	private _found = objNull;
	{
		if ((typeOf _x) isEqualTo _className) exitWith { _found = _x; };
	} forEach _objects;
	_found
};

private _fnc_findRespawnLogicForSide = {
	params ["_sideLower", "_logics"];
	private _respawns = _logics select { (typeOf _x) isEqualTo "LocationRespawnPoint_F" };
	private _found = objNull;
	{
		private _init = toLower(((_x get3DENAttribute "init") select 0));
		if ((_init find "gw_isrespawnpos" > -1) && { _init find _sideLower > -1 }) exitWith { _found = _x; };
	} forEach _respawns;
	_found
};

private _fnc_anyNamePrefix = {
	params ["_objects", "_prefixLower"];
	({
		private _n = toLower(((_x get3DENAttribute "name") select 0));
		(_n find _prefixLower) isEqualTo 0
	} count _objects) > 0
};

private _fnc_hasRespawnForSide = {
	params ["_sideLower", "_logics"];
	private _respawns = _logics select { (typeOf _x) isEqualTo "LocationRespawnPoint_F" };
	({
		private _init = toLower(((_x get3DENAttribute "init") select 0));
		(_init find "gw_isrespawnpos" > -1) && { _init find _sideLower > -1 }
	} count _respawns) > 0
};

private _fnc_getPlayableSides = {
	private _allObjects = all3DENEntities select 0;
	private _allPlayable = _allObjects select {((_x get3DENAttribute "ControlMP") select 0) || ((_x get3DENAttribute "ControlSP") select 0)};
	private _sides = [];
	{
		private _s = side _x;
		if (_s in [west,east,independent] && {!(_s in _sides)}) then { _sides pushBack _s; };
	} forEach _allPlayable;
	if (_sides isEqualTo []) then { _sides pushBack west; };
	_sides
};

private _fnc_applyMarkerAttrs = {
	params ["_markerName", "_attrs"]; // _markerName is the 3DEN marker entity (string)
	{
		_x params ["_key", "_val"]; 
		_markerName set3DENAttribute [_key, _val];
	} forEach _attrs;
};

private _fnc_pos = {
	params ["_x", "_y", ["_z", 0]];
	[_x, _y, _z]
};

private _fnc_markerPosOnGround = {
	// Markers in 3DEN can end up below ground when using z=0 on maps with terrain above sea level.
	// Force marker Z to terrain height (ASL) at the given X/Y.
	params ["_p"]; // expects [x,y] or [x,y,z]
	if (!(_p isEqualType []) || {(count _p) < 2}) exitWith { _p };
	private _x = _p select 0;
	private _y = _p select 1;
	[_x, _y, getTerrainHeightASL [_x, _y]]
};

private _fnc_deleteCrewUnitsAssignedToVehicleVar = {
	params ["_vehicleVarNameLower", "_objects", ["_vehicleObj", objNull]];
	private _toDelete = [];
	private _vehPos = [];
	if (!isNull _vehicleObj) then {
		_vehPos = ((_vehicleObj get3DENAttribute "position") param [0, []]);
		if (!(_vehPos isEqualType []) || {(count _vehPos) < 2}) then { _vehPos = getPosATL _vehicleObj; };
	};
	{
		if (!(_x isEqualType objNull) || {isNull _x}) then { continue; };
		if !(_x isKindOf "Man") then { continue; };
		private _veh = toLower(((_x get3DENAttribute "vehicle") param [0, ""]));
		private _isPlayable = ((_x get3DENAttribute "ControlMP") param [0, false]) || ((_x get3DENAttribute "ControlSP") param [0, false]);
		// If the unit is explicitly assigned into our vehicle, delete it even if it's marked playable.
		if (_isPlayable && {!(_veh isEqualTo _vehicleVarNameLower)}) then { continue; };
		private _special = toLower(((_x get3DENAttribute "special") param [0, ""]));
		private _isInVehicleRole = (_special find "in") isEqualTo 0;
		private _nearVeh = false;
		if (_vehPos isEqualType [] && {(count _vehPos) >= 2}) then {
			_nearVeh = ((_x distance2D _vehPos) < 8);
		};

		// Primary: explicit vehicle assignment to mhq_1
		// Fallback: if it's in a vehicle role and sitting on top of the vehicle position, delete it.
		if ((_veh isEqualTo _vehicleVarNameLower) || { _nearVeh && _isInVehicleRole }) then {
			_toDelete pushBack _x;
		};
	} forEach _objects;
	if !(_toDelete isEqualTo []) then { delete3DENEntities _toDelete; };
};

private _spacing = 6;
private _maxPasses = 2;
private _createdTotal = 0;
private _failedTotal = 0;
private _pass = 0;

while { _pass < _maxPasses } do {
	private _allObjects = all3DENEntities select 0;
	private _allLogics = all3DENEntities select 3;
	private _allMarkers = all3DENEntities select 5;
	private _markerNamesLower = _allMarkers apply { toLower _x };

	private _missing = [];
	private _sidesPresent = call _fnc_getPlayableSides;

	// Prefer stable ordering so WEST is the primary anchor when present.
	private _sidesPresentRaw = call _fnc_getPlayableSides;
	private _sidesPresent = [];
	{ if (_x in _sidesPresentRaw) then { _sidesPresent pushBack _x; }; } forEach [west, east, independent];
	if (_sidesPresent isEqualTo []) then { _sidesPresent = _sidesPresentRaw; };

	private _primaryStagingPos = _stagingPos0;
	private _primaryFarpPos = _farpPos0;

	{
		private _sideIndex = _forEachIndex;
		private _defaultStagingPos = [_p0x + (_sideIndex * 60), _p0y, 0] call _fnc_pos;
		private _defaultFarpPos = [_p0x + (_sideIndex * 60), _p0y + 40, 0] call _fnc_pos;
		private _suffix = switch (_x) do {
			case west: { "WEST" };
			case east: { "EAST" };
			case independent: { "GUER" };
			default { "WEST" };
		};
		private _sideLower = toLower str _x;
		if (_x isEqualTo west) then { _sideLower = "west"; };
		if (_x isEqualTo east) then { _sideLower = "east"; };
		if (_x isEqualTo independent) then { _sideLower = "independent"; };
		private _markerColor = switch (_x) do {
			case west: { "ColorWEST" };
			case east: { "ColorEAST" };
			case independent: { "ColorGUER" };
			default { "ColorWEST" };
		};

		private _gearClass = format ["GOL_GearBox_%1", _suffix];
		private _resupplyClass = format ["GOL_ResupplyStation_%1_Small", _suffix];
		private _supportClass = format ["GOL_SupportBox_%1", _suffix];

		private _flag1 = format ["flag_%1_1", _sideLower];
		private _flag2 = format ["flag_%1_2", _sideLower];
		private _flag1Obj = [_allObjects, toLower _flag1] call _fnc_getNamedEntity;
		private _stagingAnchorPos = if (!isNull _flag1Obj) then {
			private _p = [_flag1Obj] call _fnc_getEntityPos;
			if (_p isEqualTo []) then { _defaultStagingPos } else { _p }
		} else {
			_defaultStagingPos
		};

		if (_forEachIndex == 0) then { _primaryStagingPos = _stagingAnchorPos; };

		// Ensure staging flag exists (anchor). If it already exists, treat its position as authoritative.
		if (isNull _flag1Obj) then {
			_missing pushBack ["Object", "FlagPole_F", _stagingAnchorPos, [["name", _flag1], ["description", format ["Framework: Staging flag (%1). Visual anchor for player staging and framework grouping.", _sideLower]]]];
		} else {
			[_flag1Obj, [["description", format ["Framework: Staging flag (%1). Visual anchor for player staging and framework grouping.", _sideLower]]]] call _fnc_setEntityAttrs;
		};

		private _flag2Obj = [_allObjects, toLower _flag2] call _fnc_getNamedEntity;
		// FARP anchor: fixed position relative to staging (avoid reliance on any existing objects).
		// Moved further north to reduce clipping.
		private _farpAnchorPos = [_stagingAnchorPos select 0, (_stagingAnchorPos select 1) + 70, 0] call _fnc_pos;

		if (_forEachIndex == 0) then { _primaryFarpPos = _farpAnchorPos; };

		if (isNull _flag2Obj) then {
			_missing pushBack ["Object", "FlagPole_F", _farpAnchorPos, [["name", _flag2], ["description", format ["Framework: FARP flag (%1). Keep with FARP marker + helipad + resupply station.", _sideLower]]]];
		} else {
			[_flag2Obj, [["description", format ["Framework: FARP flag (%1). Keep with FARP marker + helipad + resupply station.", _sideLower]]]] call _fnc_setEntityAttrs;
		};

		// Requested offsets (all relative to the flags)
		private _gearPos = [(_stagingAnchorPos select 0) + 3, _stagingAnchorPos select 1, 0] call _fnc_pos;
		private _supportPos = [(_stagingAnchorPos select 0) - 3, _stagingAnchorPos select 1, 0] call _fnc_pos;
		private _respawnLogicPos = [_stagingAnchorPos select 0, (_stagingAnchorPos select 1) - 5, 0] call _fnc_pos;
		private _resupplyPos = [_farpAnchorPos select 0, (_farpAnchorPos select 1) - 10, 0] call _fnc_pos;
		private _helipadPos = [_farpAnchorPos select 0, (_farpAnchorPos select 1) - 20, 0] call _fnc_pos;

		// Gear box
		private _gearObj = [_allObjects, _gearClass] call _fnc_getFirstByType;
		if (isNull _gearObj) then {
			_missing pushBack ["Object", _gearClass, _gearPos, [["description", format ["Framework: Gear box (%1). Place near the Staging Point. Used for player gear/loadout access and mission resupply.", _suffix]]]];
		} else {
			[_gearObj, [["description", format ["Framework: Gear box (%1). Place near the Staging Point. Used for player gear/loadout access and mission resupply.", _suffix]]]] call _fnc_setEntityAttrs;
		};

		// Support box
		private _supportObj = [_allObjects, _supportClass] call _fnc_getFirstByType;
		if (isNull _supportObj) then {
			_missing pushBack ["Object", _supportClass, _supportPos, [["description", format ["Framework: Support box (%1). Place near the Staging Point. Used for support utilities/supplies depending on framework settings.", _suffix]]]];
		} else {
			[_supportObj, [["description", format ["Framework: Support box (%1). Place near the Staging Point. Used for support utilities/supplies depending on framework settings.", _suffix]]]] call _fnc_setEntityAttrs;
		};

		// Resupply station (FARP)
		private _resupplyObj = [_allObjects, _resupplyClass] call _fnc_getFirstByType;
		if (isNull _resupplyObj) then {
			_missing pushBack ["Object", _resupplyClass, _resupplyPos, [["description", format ["Framework: Resupply/Service station (%1). Keep with the FARP cluster (helipad + flag_%2_2 + FARP marker).", _suffix, _sideLower]]]];
		} else {
			[_resupplyObj, [["description", format ["Framework: Resupply/Service station (%1). Keep with the FARP cluster (helipad + flag_%2_2 + FARP marker).", _suffix, _sideLower]]]] call _fnc_setEntityAttrs;
		};

		// Helipad (per-side: if none exists near this FARP, create one)
		private _nearHelipads = _allObjects select { (typeOf _x) isEqualTo "GOL_Helipad" && { (_x distance2D _farpAnchorPos) < 100 } };
		if ((count _nearHelipads) == 0) then {
			_missing pushBack ["Object", "GOL_Helipad", _helipadPos, [["description", "Framework: GOL Helipad. Part of the FARP cluster; keep with FARP marker + flag_side_2 + resupply station."]]];
		} else {
			private _hp = _nearHelipads select 0;
			[_hp, [["description", "Framework: GOL Helipad. Part of the FARP cluster; keep with FARP marker + flag_side_2 + resupply station."]]] call _fnc_setEntityAttrs;
		};

		// Respawn logic
		private _respawnLogic = [_sideLower, _allLogics] call _fnc_findRespawnLogicForSide;
		if (isNull _respawnLogic) then {
			private _init = format ["this setVariable [""GW_isRespawnPos"", ""%1"", true];", _sideLower];
			_missing pushBack ["Logic", "LocationRespawnPoint_F", _respawnLogicPos, [["init", _init], ["description", format ["Framework: Respawn point (%1). Do not delete. Move together with respawn_%1 marker + flag_%1_1.", _sideLower]]]];
		} else {
			[_respawnLogic, [["description", format ["Framework: Respawn point (%1). Do not delete. Move together with respawn_%1 marker + flag_%1_1.", _sideLower]]]] call _fnc_setEntityAttrs;
		};

		// Staging/HQ marker (respawn markers are conventionally HQ markers)
		private _respawnMarkerName = switch (_x) do {
			case west: { "respawn_west" };
			case east: { "respawn_east" };
			case independent: { "respawn_guerrila" };
			default { "respawn_west" };
		};
		private _respawnMarkerType = switch (_x) do {
			case west: { "b_hq" };
			case east: { "o_hq" };
			case independent: { "n_hq" };
			default { "b_hq" };
		};
		private _respawnAttrs = [
			["markerName", _respawnMarkerName],
			["text", "Staging Point"],
			["type", _respawnMarkerType],
			["color", _markerColor],
			["baseColor", _markerColor],
			["alpha", 1],
			["size2", [0.7, 0.7]],
			["description", format ["Framework: Staging point marker (%1). Intended to be stacked with the respawn logic + flag_%1_1.", _sideLower]]
		];
		if (toLower _respawnMarkerName in _markerNamesLower) then {
			[_respawnMarkerName, _respawnAttrs] call _fnc_applyMarkerAttrs;
		} else {
			_missing pushBack ["Marker", _respawnMarkerType, ([_respawnLogicPos] call _fnc_markerPosOnGround), _respawnAttrs];
		};

		// FARP marker (side helicopter/air marker)
		private _farpMarkerName = format ["FARP_%1_1", _sideLower];
		private _farpMarkerType = switch (_x) do {
			case west: { "b_air" };
			case east: { "o_air" };
			case independent: { "n_air" };
			default { "b_air" };
		};
		private _farpAttrs = [
			["markerName", _farpMarkerName],
			["text", "FARP"],
			["type", _farpMarkerType],
			["color", _markerColor],
			["baseColor", _markerColor],
			["alpha", 1],
			["size2", [0.7, 0.7]],
			["description", format ["Framework: FARP marker (%1). Keep with helipad + resupply station + flag_%1_2.", _sideLower]]
		];
		if (toLower _farpMarkerName in _markerNamesLower) then {
			[_farpMarkerName, _farpAttrs] call _fnc_applyMarkerAttrs;
		} else {
			_missing pushBack ["Marker", _farpMarkerType, ([_farpAnchorPos] call _fnc_markerPosOnGround), _farpAttrs];
		};
	} forEach _sidesPresent;

	// Primary side marker color (matches the primary anchor side: WEST when present)
	private _primarySide = _sidesPresent param [0, west];
	private _primaryMarkerColor = switch (_primarySide) do {
		case west: { "ColorWEST" };
		case east: { "ColorEAST" };
		case independent: { "ColorGUER" };
		default { "ColorWEST" };
	};

	private _stagingPos0 = [_p0x, _p0y, 0] call _fnc_pos;
	private _farpPos0 = [_p0x, _p0y + 40, 0] call _fnc_pos;

	// Global items anchored off the primary staging flag (WEST if present)
	private _mobileHQPos = [_primaryStagingPos select 0, (_primaryStagingPos select 1) + 5, 0] call _fnc_pos;
	private _mobileHQObj = [_allObjects, "mobile_hq"] call _fnc_getNamedEntity;
	if (isNull _mobileHQObj) then {
		_missing pushBack ["Object", "RuggedTerminal_01_communications_F", _mobileHQPos, [["name", "Mobile_HQ"], ["description", "Framework: Mobile HQ terminal. Keep 5m north of the staging flag. Used as the mobile HQ/service point in templates."]]];
	} else {
		[_mobileHQObj, [["description", "Framework: Mobile HQ terminal. Keep 5m north of the staging flag. Used as the mobile HQ/service point in templates."]]] call _fnc_setEntityAttrs;
	};

	// MHQ vehicle (only create if none exist)
	if (!([_allObjects, "mhq_"] call _fnc_anyNamePrefix)) then {
		private _mhqVehPos = [(_primaryStagingPos select 0) + 20, _primaryStagingPos select 1, 0] call _fnc_pos;
		_missing pushBack ["Object", "B_MRAP_01_F", _mhqVehPos, [["name", "mhq_1"], ["side", "Empty"], ["description", "Framework: MHQ vehicle (mhq_1). Only created when no mhq_* exists. Default class: B_MRAP_01_F. Must be empty (no crew)."]]];
	};

	// vehicle_1 (template helper)
	private _veh1 = [_allObjects, "vehicle_1"] call _fnc_getNamedEntity;
	private _veh1Pos = [(_primaryStagingPos select 0) + 10, _primaryStagingPos select 1, 0] call _fnc_pos;
	if (isNull _veh1) then {
		_missing pushBack ["Object", "B_APC_Wheeled_01_cannon_F", _veh1Pos, [["name", "vehicle_1"], ["side", "Empty"], ["description", "Framework: Vehicle slot 1 (vehicle_1). Template convenience vehicle; keep near staging. Must be empty (no crew)."]]];
	} else {
		[_veh1, [["side", "Empty"], ["description", "Framework: Vehicle slot 1 (vehicle_1). Template convenience vehicle; keep near staging. Must be empty (no crew)."]]] call _fnc_setEntityAttrs;
	};

	// helicopter_1 (template helper) - placed on primary helipad
	private _heli1 = [_allObjects, "helicopter_1"] call _fnc_getNamedEntity;
	private _heli1Pos = [_primaryFarpPos select 0, (_primaryFarpPos select 1) - 20, 0] call _fnc_pos;
	if (isNull _heli1) then {
		// Template uses RHS_UH60M_ESSS_d; if RHS isn't loaded this will fail and be counted in failedTotal.
		_missing pushBack ["Object", "RHS_UH60M_ESSS_d", _heli1Pos, [["name", "helicopter_1"], ["side", "Empty"], ["description", "Framework: Helicopter slot 1 (helicopter_1). Template convenience helicopter; placed on the helipad. Must be empty (no crew)."]]];
	} else {
		[_heli1, [["side", "Empty"], ["description", "Framework: Helicopter slot 1 (helicopter_1). Template convenience helicopter; placed on the helipad. Must be empty (no crew)."]]] call _fnc_setEntityAttrs;
	};

	// ORBAT Viewer module (Strategic Map ORBAT)
	private _orbatPos = [_primaryStagingPos select 0, (_primaryStagingPos select 1) - 25, 0] call _fnc_pos;
	private _orbat = [_allLogics, "orbat_group"] call _fnc_getNamedEntity;
	if (isNull _orbat) then {
		_orbat = [_allLogics, "ModuleStrategicMapORBAT_F"] call _fnc_getFirstByType;
	};
	private _orbatAttrs = [
		["name", "ORBAT_GROUP"],
		["description", "Framework: ORBAT Viewer module (ORBAT_GROUP). Shows ORBAT info based on CfgORBAT. Place near staging but not directly on top of it."],
		["ModuleStrategicMapORBAT_F_Path", "Configfile >> ""CfgORBAT"" >> ""GuerrillasOfLiberation"""],
		["ModuleStrategicMapORBAT_F_Tags", ""],
		["ModuleStrategicMapORBAT_F_Parent", ""],
		["ModuleStrategicMapORBAT_F_Tiers", ""]
	];
	if (isNull _orbat) then {
		_missing pushBack ["Logic", "ModuleStrategicMapORBAT_F", _orbatPos, _orbatAttrs];
	} else {
		[_orbat, _orbatAttrs] call _fnc_setEntityAttrs;
	};

	// HC slots (west of the staging flag, in a line)
	private _hcPos = [(_primaryStagingPos select 0) - 20, _primaryStagingPos select 1, 0] call _fnc_pos;
	private _hc2Pos = [(_primaryStagingPos select 0) - 24, _primaryStagingPos select 1, 0] call _fnc_pos;
	private _hc3Pos = [(_primaryStagingPos select 0) - 28, _primaryStagingPos select 1, 0] call _fnc_pos;
	private _hc = [_allLogics, "hc"] call _fnc_getNamedEntity;
	private _hc2 = [_allLogics, "hc2"] call _fnc_getNamedEntity;
	private _hc3 = [_allLogics, "hc3"] call _fnc_getNamedEntity;
	if (!isNull _hc && {!(typeOf _hc isEqualTo "HeadlessClient_F")}) then { delete3DENEntities [_hc]; _hc = objNull; };
	if (!isNull _hc2 && {!(typeOf _hc2 isEqualTo "HeadlessClient_F")}) then { delete3DENEntities [_hc2]; _hc2 = objNull; };
	if (!isNull _hc3 && {!(typeOf _hc3 isEqualTo "HeadlessClient_F")}) then { delete3DENEntities [_hc3]; _hc3 = objNull; };

	if (isNull _hc) then {
		_missing pushBack ["Logic", "HeadlessClient_F", _hcPos, [["name", "HC"], ["description", "Headless Client 1"], ["isPlayable", 1], ["ControlMP", true]]];
	} else {
		[_hc, [["description", "Headless Client 1"], ["isPlayable", 1], ["ControlMP", true]]] call _fnc_setEntityAttrs;
	};
	if (isNull _hc2) then {
		_missing pushBack ["Logic", "HeadlessClient_F", _hc2Pos, [["name", "HC2"], ["description", "Headless Client 2"], ["isPlayable", 1], ["ControlMP", true]]];
	} else {
		[_hc2, [["description", "Headless Client 2"], ["isPlayable", 1], ["ControlMP", true]]] call _fnc_setEntityAttrs;
	};
	if (isNull _hc3) then {
		_missing pushBack ["Logic", "HeadlessClient_F", _hc3Pos, [["name", "HC3"], ["description", "Headless Client 3"], ["isPlayable", 1], ["ControlMP", true]]];
	} else {
		[_hc3, [["description", "Headless Client 3"], ["isPlayable", 1], ["ControlMP", true]]] call _fnc_setEntityAttrs;
	};
	// Helicopter spawn/despawn markers anchored off the primary FARP
	private _heliSpawnPos = [_primaryFarpPos select 0, (_primaryFarpPos select 1) + 20, 0] call _fnc_pos;
	// Despawn: 150m east of the primary staging flag (flag_<side>_1).
	private _heliDespawnPos = [(_primaryStagingPos select 0) + 150, _primaryStagingPos select 1, 0] call _fnc_pos;
	private _heliSpawnDesc = "AI Resupply: Helicopter Spawn point. Used as spawn position for resupply/pickup helicopters.";
	private _heliDespawnDesc = "AI Resupply: Helicopter Despawn point. Used as despawn position for resupply/pickup helicopters.";

	if (("helicopter_spawn" in _markerNamesLower)) then {
		["helicopter_spawn", [
			["markerName", "helicopter_spawn"],
			["text", ""],
			["size2", [0.5, 0.5]],
			["description", _heliSpawnDesc],
			["type", "mil_start"],
			["color", _primaryMarkerColor],
			["baseColor", _primaryMarkerColor],
			["alpha", 1]
		]] call _fnc_applyMarkerAttrs;
	} else {
		_missing pushBack ["Marker", "mil_start", ([_heliSpawnPos] call _fnc_markerPosOnGround), [
			["markerName", "helicopter_spawn"],
			["text", ""],
			["size2", [0.5, 0.5]],
			["description", _heliSpawnDesc],
			["type", "mil_start"],
			["color", _primaryMarkerColor],
			["baseColor", _primaryMarkerColor],
			["alpha", 1]
		]];
	};
	if (("helicopter_despawn" in _markerNamesLower)) then {
		["helicopter_despawn", [
			["markerName", "helicopter_despawn"],
			["text", ""],
			["size2", [0.5, 0.5]],
			["description", _heliDespawnDesc],
			["type", "mil_end"],
			["color", _primaryMarkerColor],
			["baseColor", _primaryMarkerColor],
			["alpha", 1]
		]] call _fnc_applyMarkerAttrs;
	} else {
		_missing pushBack ["Marker", "mil_end", ([_heliDespawnPos] call _fnc_markerPosOnGround), [
			["markerName", "helicopter_despawn"],
			["text", ""],
			["size2", [0.5, 0.5]],
			["description", _heliDespawnDesc],
			["type", "mil_end"],
			["color", _primaryMarkerColor],
			["baseColor", _primaryMarkerColor],
			["alpha", 1]
		]];
	};

	if (_missing isEqualTo []) exitWith {};

	private _createdThisPass = 0;
	for "_i" from 0 to ((count _missing) - 1) do {
		private _entry = _missing select _i;
		private _category = _entry param [0, "", [""]];
		private _class = _entry param [1, "", [""]];
		private _pos = _entry param [2, _stagingPos0, [[]]];
		private _attrs = _entry param [3, [], [[]]];

		// create3DENEntity supports a 4th parameter (isEmpty) for vehicles.
		// We pass it for Object category so any vehicles are created without crew.
		private _e = if (_category isEqualTo "Object") then {
			create3DENEntity [_category, _class, _pos, true]
		} else {
			create3DENEntity [_category, _class, _pos]
		};
		if (isNil "_e") then {
			_failedTotal = _failedTotal + 1;
		} else {
			private _isMarker = _e isEqualType "";
			if (_isMarker) then {
				// Marker rename safety: once you set ["markerName", ...], the marker entity is now the NEW name.
				private _desiredName = "";
				{
					_x params ["_key", "_val"];
					if (_key isEqualTo "markerName") exitWith { _desiredName = _val; };
				} forEach _attrs;
				if !(_desiredName isEqualTo "") then {
					_e set3DENAttribute ["markerName", _desiredName];
					_e = _desiredName;
				};
				private _posGround = [_pos] call _fnc_markerPosOnGround;
				_e set3DENAttribute ["position", _posGround];
				{
					_x params ["_key", "_val"];
					if !(_key isEqualTo "markerName") then { _e set3DENAttribute [_key, _val]; };
				} forEach _attrs;
				_createdTotal = _createdTotal + 1;
				_createdThisPass = _createdThisPass + 1;
			} else {
				if (_e isEqualType objNull && {!isNull _e}) then {
					private _hasInitOverride = ({ (_x select 0) isEqualTo "init" } count _attrs) > 0;
					if (!_hasInitOverride) then { _e set3DENAttribute ["init", ""]; };
					_e set3DENAttribute ["position", _pos];
					{ _x params ["_key", "_val"]; _e set3DENAttribute [_key, _val]; } forEach _attrs;
					_createdTotal = _createdTotal + 1;
					_createdThisPass = _createdThisPass + 1;
				} else {
					_failedTotal = _failedTotal + 1;
				};
			};
		};
	};

	// Ensure template vehicles are empty (Eden may spawn crew depending on context).
	private _objectsNow = all3DENEntities select 0;
	private _mhqVehObjNow = [_objectsNow, "mhq_1"] call _fnc_getNamedEntity;
	private _veh1ObjNow = [_objectsNow, "vehicle_1"] call _fnc_getNamedEntity;
	private _heli1ObjNow = [_objectsNow, "helicopter_1"] call _fnc_getNamedEntity;
	["mhq_1", _objectsNow, _mhqVehObjNow] call _fnc_deleteCrewUnitsAssignedToVehicleVar;
	["vehicle_1", _objectsNow, _veh1ObjNow] call _fnc_deleteCrewUnitsAssignedToVehicleVar;
	["helicopter_1", _objectsNow, _heli1ObjNow] call _fnc_deleteCrewUnitsAssignedToVehicleVar;

	if (_createdThisPass <= 0) exitWith {
		// Prevent infinite looping when classes are missing in loaded mods.
	};

	_pass = _pass + 1;
};

if ((_createdTotal == 0) && (_failedTotal == 0)) exitWith {
	["No missing items detected", 0, 5, true] call BIS_fnc_3DENNotification;
	[(str _this), QFUNC(restoreMissingItems)] call FUNC(uiSaveFunction);
	true
};

private _msg = format ["Restored %1 item(s)", _createdTotal];
if (_failedTotal > 0) then {
	_msg = _msg + format [" | %1 failed", _failedTotal];
};
[_msg, 0, 6, true, 0.5] call BIS_fnc_3DENNotification;

[(str _this), QFUNC(restoreMissingItems)] call FUNC(uiSaveFunction);
true
