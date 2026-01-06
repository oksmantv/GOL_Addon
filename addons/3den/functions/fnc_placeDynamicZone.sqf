#include "script_component.hpp"
/*
	Places an OKS Dynamic Zone trigger + helper Location logics in 3DEN.

	- Creates an EmptyDetector trigger (default 500m ellipse)
	- Places helper Location logics in a straight N-S line 25m east of the trigger
	- Places real 3DEN Comment entities next to each helper
	- Copies a paste-ready OKS_fnc_CreateZone call to clipboard and appends to OKS 3DEN clipboard cache

	Called from GW 3DEN context menu (Spawn Lists) and supports OKS_fnc_EdenRepeatLastAction by accepting menuData as param 0.
*/

if (!is3DEN) exitWith { false };

disableSerialization;

private _menuData = _this param [0, [], [[]]];

private _pos = [];

// Prefer passed menuData click position (when available)
if (_menuData isEqualType []) then {
	private _md0 = _menuData param [0, []];
	if (_md0 isEqualType [] && { (count _md0) >= 2 }) then {
		_pos = [_md0 select 0, _md0 select 1, 0];
	} else {
		if ((count _menuData) >= 2 && { (_menuData select 0) isEqualType 0 }) then {
			_pos = [_menuData select 0, _menuData select 1, 0];
		};
	};
};

// Prefer Eden map cursor position when a map control is shown.
if (_pos isEqualTo []) then {
	private _disp3DEN = findDisplay 313;
	if (!isNull _disp3DEN) then {
		private _mapCtrls = (allControls _disp3DEN) select { (ctrlType _x) == 101 && { ctrlShown _x } };
		private _mapCtrl = _mapCtrls param [0, controlNull];
		if (!isNull _mapCtrl) then {
			private _mapPos2D = _mapCtrl ctrlMapScreenToWorld getMousePosition;
			if (_mapPos2D isEqualType [] && { (count _mapPos2D) >= 2 }) then {
				_pos = [_mapPos2D select 0, _mapPos2D select 1, 0];
			};
		};
	};
};

// Fallback: screen-to-world under cursor.
if (_pos isEqualTo []) then {
	private _stw = screenToWorld getMousePosition;
	if (_stw isEqualType [] && { (count _stw) >= 2 }) then {
		_pos = [_stw select 0, _stw select 1, 0];
	};
};

if (_pos isEqualTo []) exitWith {
	["Spawn Lists: Invalid position", 1, 6, true] call BIS_fnc_3DENNotification;
	false
};

_pos set [2, 0];

private _layerName = "Dynamic Zones";
private _layer = nil;
if (!isNil "OKS_fnc_EdenGetOrCreateLayer") then {
	_layer = [_layerName] call OKS_fnc_EdenGetOrCreateLayer;
};

private _canSetLayer = false;
if (!isNil "OKS_fnc_EdenSetLayerSafe" && {!isNil "_layer"}) then {
	switch (typeName _layer) do {
		case "SCALAR": { _canSetLayer = _layer >= 0; };
		case "OBJECT": { _canSetLayer = !isNull _layer; };
		default { _canSetLayer = false; };
	};
};

// Only set attributes that exist on the entity type (prevents noisy RPT errors).
private _setAttrIfExists = {
	params ["_entity", "_key", "_value"];
	private _a = _entity get3DENAttribute _key;
	if (_a isEqualType [] && {(count _a) > 0}) exitWith {
		_entity set3DENAttribute [_key, _value];
		true
	};
	false
};

private _trigger = objNull;
private _triggerName = "";

private _createdHelpers = [];
private _createdComments = [];

private _helperDefs = [
	["LocationArea_F",         "DZ_Area",     "Strongpoints: preferred area/city anchor (OKS_Locations)",          "Use for strongpoint building clusters (Area/City/Evac/Resupply)."],
	["LocationOutpost_F",      "DZ_Outpost",  "Compounds: compound garrison anchor (OKS_Compounds)",               "Use to force compound-style garrisons (Outpost)."],
	["LocationBase_F",         "DZ_Base",     "Strongholds: stronghold/neutralize anchor (OKS_Strongholds)",       "Use for stronghold / neutralize building objectives (Base)."],
	["LocationCamp_F",         "DZ_Camp",     "Objectives: objective anchor (OKS_Objectives)",                     "Use for random objective compositions/targets (Camp)."],
	["LocationFOB_F",          "DZ_FOB",      "Roadblocks: roadblock anchor + direction (OKS_RoadBlocks)",          "Use to force roadblock position; rotate to set roadblock direction (FOB)."],
	["LocationRespawnPoint_F", "DZ_Respawn",  "Hunt Bases: reinforcement anchor + direction (OKS_HuntLocations)",   "Use for hunt base spawns; rotate to set spawn direction (Respawn Point)."],
	["LocationVillage_F",      "DZ_Village",  "Civilians: village center for civilian triggers (OKS_Villages)",     "Use to define village areas for dynamic civilians (Village)."]
];

private _helperSpacing = 25;
private _helperCount = count _helperDefs;
private _halfSpan = (_helperCount - 1) / 2;

collect3DENHistory {
	_trigger = create3DENEntity ["Trigger", "EmptyDetector", _pos];
	if (isNull _trigger) exitWith {};

	_triggerName = if (!isNil "OKS_fnc_next3DENName") then {
		["DynamicZone"] call OKS_fnc_next3DENName
	} else {
		format ["DynamicZone_%1", floor (random 9999)]
	};

	_trigger set3DENAttribute ["name", _triggerName];
	_trigger set3DENAttribute ["text", format ["Dynamic Zone: %1", _triggerName]];
	_trigger set3DENAttribute ["description", "OKS Dynamic Zone (OKS_fnc_CreateZone)"];

	// Default: ellipse 500m radius; user can resize.
	_trigger set3DENAttribute ["size3", [500, 500, 0]];
	_trigger set3DENAttribute ["IsRectangle", false];

	// Not required by OKS_fnc_CreateZone; keeps it consistent with other zone triggers.
	_trigger set3DENAttribute ["activationBy", "ANYPLAYER"];
	_trigger set3DENAttribute ["repeatable", true];

	if (_canSetLayer) then {
		[_trigger, _layer] call OKS_fnc_EdenSetLayerSafe;
	};

	private _helperAnchorPos = [
		(_pos select 0) + 25,
		(_pos select 1),
		0
	];

	for "_i" from 0 to (_helperCount - 1) do {
		(_helperDefs select _i) params ["_class", "_namePrefix", "_label", "_desc"]; 

		private _northOffset = (_halfSpan - _i) * _helperSpacing;
		private _hp = [(_helperAnchorPos select 0), (_helperAnchorPos select 1) + _northOffset, 0];

		private _helper = create3DENEntity ["Logic", _class, _hp];
		if (isNull _helper) then { continue; };
		if (_canSetLayer) then {
			[_helper, _layer] call OKS_fnc_EdenSetLayerSafe;
		};

		private _helperName = if (!isNil "OKS_fnc_next3DENName") then {
			[_namePrefix] call OKS_fnc_next3DENName
		} else {
			format ["%1_%2", _namePrefix, floor (random 9999)]
		};

		_helper set3DENAttribute ["name", _helperName];
		_helper set3DENAttribute ["text", _label];
		_helper set3DENAttribute ["description", _desc];
		_createdHelpers pushBack _helper;

		// 3DEN Comment entity placed just east of the helper.
		private _cp = [(_hp select 0) + 5, (_hp select 1), 0];
		private _comment = create3DENEntity ["Comment", "", _cp];
		private _commentOk = false;
		switch (typeName _comment) do {
			case "OBJECT": { _commentOk = !isNull _comment; };
			case "SCALAR": { _commentOk = _comment >= 0; };
			case "STRING": { _commentOk = _comment isNotEqualTo ""; };
			default { _commentOk = false; };
		};

		// Fallback attempt for some modsets/engine versions.
		if (!_commentOk) then {
			_comment = create3DENEntity ["Comment", "Comment_F", _cp];
			switch (typeName _comment) do {
				case "OBJECT": { _commentOk = !isNull _comment; };
				case "SCALAR": { _commentOk = _comment >= 0; };
				case "STRING": { _commentOk = _comment isNotEqualTo ""; };
				default { _commentOk = false; };
			};
		};

		// Last resort: keep functionality (visible label) even if Comments are unavailable.
		if (!_commentOk) then {
			_comment = create3DENEntity ["Logic", "Logic", _cp];
			_commentOk = !(isNull _comment);
		};

		if (!_commentOk) then { continue; };
		if (_canSetLayer) then {
			[_comment, _layer] call OKS_fnc_EdenSetLayerSafe;
		};

		// Fill title/body/tooltip for real 3DEN comments.
		// Different engine versions/modsets expose slightly different attribute keys.
		private _title = _label;
		private _body = _desc;
		private _fallbackText = format ["%1\n%2", _label, _desc];

		[_comment, "title", _title] call _setAttrIfExists;
		[_comment, "name", _title] call _setAttrIfExists;
		[_comment, "tooltip", _body] call _setAttrIfExists;
		[_comment, "description", _body] call _setAttrIfExists;
		[_comment, "comment", _body] call _setAttrIfExists;
		[_comment, "text", _fallbackText] call _setAttrIfExists;
		_createdComments pushBack _comment;
	};
};

if (isNull _trigger || {_triggerName isEqualTo ""}) exitWith {
	["Spawn Lists: Failed to create Dynamic Zone", 1, 6, true] call BIS_fnc_3DENNotification;
	false
};

// Prefer side from current selection; otherwise fall back to per-session global side.
private _selectedSide = sideUnknown;
private _selected = get3DENSelected "object";
{
	if (_selectedSide isEqualTo sideUnknown) then {
		private _s = side _x;
		if (_s in [west, east, independent, civilian]) then {
			_selectedSide = _s;
		};
	};
} forEach _selected;

private _sideStr = "";
if (_selectedSide in [west, east, independent, civilian]) then {
	_sideStr = switch (_selectedSide) do {
		case west: { "west" };
		case east: { "east" };
		case independent: { "independent" };
		case civilian: { "civilian" };
		default { "east" };
	};
} else {
	private _s = toUpper (uiNamespace getVariable ["GW_FRAMEWORK_GLOBAL_SIDE", "EAST"]);
	_sideStr = switch (_s) do {
		case "WEST": { "west" };
		case "INDEPENDENT": { "independent" };
		case "GUER": { "independent" };
		case "CIVILIAN": { "civilian" };
		default { "east" };
	};
};

private _example = format [
	"[%1, false, [8,25,false,false], %2, 0, 0, 0, [0,true,false,0], [0,false], [0,false], [0,0,0,0,0], false] spawn OKS_fnc_CreateZone;",
	_triggerName,
	_sideStr
];

copyToClipboard _example;
if (!isNil "OKS_fnc_EdenClipboardCacheAdd") then {
	[_example] call OKS_fnc_EdenClipboardCacheAdd;
};

if (!isNil "OKS_fnc_EdenRememberLastAction") then {
	["GW_3DEN_fnc_placeDynamicZone", [], ([_trigger] + _createdHelpers + _createdComments)] call OKS_fnc_EdenRememberLastAction;
};

private _cacheCount = count (uiNamespace getVariable ["OKS_3DEN_CLIPBOARD_CACHE", []]);
[format ["Dynamic Zone copied to clipboard | Cache=%1", _cacheCount], 0, 8, true] call BIS_fnc_3DENNotification;

true
