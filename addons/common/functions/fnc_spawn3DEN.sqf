/*
	AUTHOR: GuzzenVonLidl
	Collects all positions and selects a random one to place a unit in

	Usage:
	[] call GW_Common_Fnc_spawn3DEN;

	Parameters:
	#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
	#1	NUMBER:	Radius of area	(Optional: Default: 50)
	#2	NUMBER:	Amount of ai spawn

	Return Value: <GROUP>
	Group that spawned

	Public: NO
*/
#include "script_Component.hpp"

params [
	["_units", []],
	["_vehicles", []],
	["_waypoints", []],
	["_side", nil]
];

collect3DENHistory {
	// Resolve side: if nil or string, fall back to mission Faction setting (default EAST)
	if (isNil "_side") then {
		_side = GVAR(Faction);
	};

	if (_side isEqualType "") then {
		switch (toLower _side) do {
			case "west":          { _side = west; };
			case "east":          { _side = east; };
			case "independent":   { _side = independent; };
			case "civilian":      { _side = civilian; };
			default               { _side = east; };
		};
	};

	if (_side isEqualType sideUnknown) then {
		// GVAR(Faction) is stored as a string from CBA settings, convert it
		switch (toLower str _side) do {
			case "west":          { _side = west; };
			case "east":          { _side = east; };
			case "independent":   { _side = independent; };
			case "civilian":      { _side = civilian; };
			default               { _side = east; };
		};
	};
	([_side] call FUNC(getGroupType)) params ["_side", "_leader","_unitList"];
	{
		([_x, "Auto", ""] call FUNC(normalizeSpawnUnitRow)) params ["_pos", "_dir", "_unitPos", "_specials", "_role"];

		private _unitClass = "";
		if !(_forEachIndex isEqualTo 0) then {
			_unitClass = (selectRandom _unitList);
		} else {
			_unitClass = (selectRandom _leader);
		};
		if !(_role isEqualTo "") then {
			_unitClass = [_role, _side] call GW_Common_Fnc_getClassnameByRole;
		};

		// Declared here so it stays visible after the if/else below (assigning first inside a nested scope would make it local to that scope).
		private _unit = objNull;
		if (isNil QGVAR(spawn)) then {
			_unit = create3DENEntity ["Object", _unitClass, [0,0,0]];
			_unit set3DENAttribute ["position", _pos];
			_unit set3DENAttribute ["rotation", [0,0,_dir]];
			GVAR(spawn) = _unit;
		} else {
			_unit = (group GVAR(spawn)) create3DENEntity ["Object", _unitClass, [0,0,0]];
			_unit set3DENAttribute ["position", _pos];
			_unit set3DENAttribute ["rotation", [0,0,_dir]];
		};
		if (_unitPos isEqualType "") then {
			private _unitPosIndex = ["Up", "Middle", "Down", "Auto"] find _unitPos;
			if (_unitPosIndex < 0) then {
				_unitPosIndex = 3;
			};
			_unit set3DENAttribute ["UnitPos", _unitPosIndex];
		};

		// Hard-apply GW gear related editor state so preview behavior is deterministic.
		private _disableGear = false;
		private _forcedRole = "";
		private _copiedLoadout = [];
		{
			if !(_x isEqualType [] && {count _x >= 2}) then { continue };
			_x params ["_selector", "_value"];
			switch (_selector) do {
				case 14;
				case 202: {
					if (_value isEqualType true) then {
						_disableGear = _value;
					};
				};
				case 15;
				case 203: {
					if (_value isEqualType "") then {
						_forcedRole = _value;
					};
				};
				case 204: {
					if (_value isEqualType []) then {
						_copiedLoadout = _value;
					};
				};
			};
		} forEach _specials;

		if (_disableGear) then {
			_unit set3DENAttribute ["GW_DisableGearInit", true];
			_unit setVariable ["GW_DisableGearInit", true, false];
			_unit setVariable ["GW_Gear_BlackList", true, false];
		};

		if !(_forcedRole isEqualTo "") then {
			_unit set3DENAttribute ["GW_LoadoutSelector", _forcedRole];
			_unit setVariable ["GW_Gear_Loadout", _forcedRole, false];
		};

		if (_disableGear && {_copiedLoadout isEqualType []}) then {
			_unit setUnitLoadout _copiedLoadout;
		};

		[_unit, _specials] call FUNC(setAttributes3DEN);

		diag_log format ["[GW][spawn3DEN] unit=%1 role=%2 disableGear=%3 loadoutRows=%4 attr=%5 var=%6", _unit, _forcedRole, _disableGear, count _copiedLoadout, _unit get3DENAttribute "GW_DisableGearInit", _unit getVariable ["GW_Gear_BlackList", "nil"]];
	} forEach _units;

	{
		_x params ["_class","_pos","_dir","_crew","_specials", "_veh"];
		if (isNil QGVAR(spawn)) then {
			_veh = create3DENEntity ["Object", _class, [0,0,0],true];
			_veh set3DENAttribute ["position", _pos];
			_veh set3DENAttribute ["rotation", [0,0,_dir]];
			GVAR(spawn) = _veh;
		} else {
			_veh = create3DENEntity ["Object", _class, [0,0,0],true];
			_veh set3DENAttribute ["position", _pos];
			_veh set3DENAttribute ["rotation", [0,0,_dir]];
		};

		{
			_x params ["_vehPos","_turretPos"];
			_unitClass = (selectRandom _unitList);
			private ["_unit"];
			// Create crew unit in the same group
			if (isNil QGVAR(spawn)) then {
				_unit = create3DENEntity ["Object", _unitClass, _pos];
				GVAR(spawn) = _unit;
			} else {
				_unit = (group GVAR(spawn)) create3DENEntity ["Object", _unitClass, _pos];
			};
			
			// Add crew connection to vehicle
			_unit moveInTurret [0,_turretPos];
			_unit moveInTurret [1,_turretPos];
		} forEach _crew;

		[_veh, _specials] call FUNC(setAttributes3DEN);
	} forEach _vehicles;

	{
		_waypointType = "Move";
		_x params ["_pos","_waypointConfigs"];
		{
			_x params ["_type","_setting"];
			switch (_type) do {
				case 0: {
					_waypointType = _setting;
				};
			};
		} forEach _waypointConfigs;

		_wp = (group GVAR(spawn)) create3DENEntity ["Waypoint", _waypointType, _pos];

		{
			_x params ["_type","_setting"];
			switch (_type) do {
				case 1: {
					_wp set3DENAttribute ["behaviour", _setting];
				};
				case 2: {
					_wp set3DENAttribute ["combatMode", _setting];
				};
				case 3: {
					_wp set3DENAttribute ["completionRadius", _setting];
				};
				case 4: {
					_setting = ["NO CHANGE","WEDGE","VEE","LINE","COLUMN","FILE","STAG COLUMN","ECH LEFT","ECH RIGHT","DIAMOND"] find _setting;
					_wp set3DENAttribute ["formation", _setting];
				};
				case 5: {
					_setting = ["UNCHANGED","LIMITED","NORMAL","FULL"] find _setting;
					_wp set3DENAttribute ["speedMode", _setting];
				};
				case 6: {
					_wp set3DENAttribute ["timeout", _setting];
				};
				case 7: {
					_wp set3DENAttribute ["condition", _setting select 0];
					_wp set3DENAttribute ["onActivation", _setting select 1];
				};
			};
		} forEach _waypointConfigs;
	} forEach _waypoints;
};

GVAR(spawn) = nil;

