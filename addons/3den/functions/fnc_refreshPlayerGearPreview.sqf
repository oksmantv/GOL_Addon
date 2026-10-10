/*
	Applies the active faction kit to every 3DEN unit so the editor
	visually matches the loadouts the mission will use at runtime.

	Roles honour the GW Loadout Selector attribute when set; otherwise they are
	inferred from the unit classname/display name.

	Usage:
	[true] call GW_3den_fnc_refreshPlayerGearPreview; // force every editor unit
*/
#include "..\script_component.hpp"

params [
	["_force", false, [false]]
];

private _getSetting = {
	params ["_setting", "_default"];
	private _value = missionNamespace getVariable [_setting, _default];
	private _cbaGetterName = "CBA" + "_settings_fnc_get";
	private _cbaGet = missionNamespace getVariable [_cbaGetterName, objNull];
	if (_cbaGet isEqualType {}) then {
		private _cbaValue = [_setting] call _cbaGet;
		if (_cbaValue isEqualType _default) then {
			_value = _cbaValue;
		};
	};
	_value
};

// A mission can be saved before Gear's conditional preInit has compiled its
// functions. Compile the minimum preview dependencies here as a safe fallback,
// so the first save behaves exactly like subsequent saves.
private _ensureGearFunction = {
	params ["_name", "_path"];

	if (isNil _name && {(_path find "addons") >= 0 || {fileExists _path}}) then {
		missionNamespace setVariable [_name, compile preprocessFileLineNumbers _path];
		diag_log format ["[GW][3DEN][GearPreview] fallback compiled %1 from %2", _name, _path];
	};

	!(isNil _name)
};

private _useLocalDefault = ["GW_Gear_UseLocalDefault", false] call _getSetting;
private _useLocalDefaultAI = ["GW_Gear_UseLocalDefaultAI", false] call _getSetting;
private _useLocalHandler = ["GW_Gear_UseLocalHandler", false] call _getSetting;

["GW_Gear_fnc_validateDlcCandidates", "\x\gw\addons\gear\functions\fnc_validateDlcCandidates.sqf"] call _ensureGearFunction;
["GW_Gear_fnc_validateFactionDlc", "\x\gw\addons\gear\functions\fnc_validateFactionDlc.sqf"] call _ensureGearFunction;
["GW_Gear_fnc_DefaultCode", if (_useLocalDefault && {fileExists "Gear\Functions\fnc_DefaultCode_Local.sqf"}) then {"Gear\Functions\fnc_DefaultCode_Local.sqf"} else {"\x\gw\addons\gear\functions\fnc_DefaultCode.sqf"}] call _ensureGearFunction;
["GW_Gear_fnc_DefaultAICode", if (_useLocalDefaultAI && {fileExists "Gear\Functions\fnc_DefaultAICode_Local.sqf"}) then {"Gear\Functions\fnc_DefaultAICode_Local.sqf"} else {"\x\gw\addons\gear\functions\fnc_DefaultAICode.sqf"}] call _ensureGearFunction;
["GW_Gear_fnc_Handler", if (_useLocalHandler && {fileExists "Gear\Functions\fnc_Handler.sqf"}) then {"Gear\Functions\fnc_Handler.sqf"} else {"\x\gw\addons\gear\functions\fnc_Handler.sqf"}] call _ensureGearFunction;

private _sourceRevision = missionNamespace getVariable ["GW_3DEN_GearPreviewSourceRevision", 0];
if ((["GW_Gear_UseLocalDefault", false] call _getSetting) && {fileExists "Gear\Functions\fnc_DefaultCode_Local.sqf"}) then {
	private _source = preprocessFileLineNumbers "Gear\Functions\fnc_DefaultCode_Local.sqf";
	if !(_source isEqualTo (missionNamespace getVariable ["GW_3DEN_GearPreviewDefaultSource", ""])) then {
		missionNamespace setVariable ["GW_3DEN_GearPreviewDefaultSource", _source];
		GW_Gear_fnc_DefaultCode = compile _source;
		_sourceRevision = _sourceRevision + 1;
	};
};
if ((["GW_Gear_UseLocalHandler", false] call _getSetting) && {fileExists "Gear\Functions\fnc_Handler.sqf"}) then {
	private _source = preprocessFileLineNumbers "Gear\Functions\fnc_Handler.sqf";
	if !(_source isEqualTo (missionNamespace getVariable ["GW_3DEN_GearPreviewHandlerSource", ""])) then {
		missionNamespace setVariable ["GW_3DEN_GearPreviewHandlerSource", _source];
		GW_Gear_fnc_Handler = compile _source;
		_sourceRevision = _sourceRevision + 1;
	};
};
missionNamespace setVariable ["GW_3DEN_GearPreviewSourceRevision", _sourceRevision];

if (isNil "GW_Gear_fnc_Handler" || {isNil "GW_Gear_fnc_DefaultCode"} || {isNil "GW_Gear_fnc_DefaultAICode"}) exitWith {
	["Gear preview is unavailable because its GW Gear functions are not loaded.", 1, 6, true] call BIS_fnc_3DENNotification;
	[0, 0]
};

private _getFactionForSide = {
	params ["_side"];
	private _setting = switch (_side) do {
		case west: {"GW_Gear_Blufor"};
		case east: {"GW_Gear_Opfor"};
		case independent: {"GW_Gear_Independent"};
		case civilian: {"GW_Gear_Civilian"};
		default {""};
	};
	if (_setting isEqualTo "") exitWith {""};
	[_setting, ""] call _getSetting
};

private _mapUnits = (all3DENEntities select 0) select {
	_x isKindOf "CAManBase"
};

if (_mapUnits isEqualTo []) exitWith {
	["Gear preview: no units found.", 1, 5, true] call BIS_fnc_3DENNotification;
	[0, 0]
};

private _customFactionSources = [];
{
	private _faction = [side _x] call _getFactionForSide;
	if ((_faction find "CUSTOM-") isEqualTo 0) then {
		private _path = format ["CustomGear\%1.sqf", _faction];
		private _source = if (fileExists _path) then {preprocessFileLineNumbers _path} else {""};
		_customFactionSources pushBackUnique [_faction, _source];
	};
} forEach _mapUnits;
if !(_customFactionSources isEqualTo (missionNamespace getVariable ["GW_3DEN_GearPreviewCustomFactionSources", []])) then {
	missionNamespace setVariable ["GW_3DEN_GearPreviewCustomFactionSources", _customFactionSources];
	_sourceRevision = _sourceRevision + 1;
	missionNamespace setVariable ["GW_3DEN_GearPreviewSourceRevision", _sourceRevision];
};

private _previewed = 0;
private _skipped = 0;
private _unchanged = 0;
private _suppressionKey = "GW_Gear_DlcValidationInProgress";
private _previousSuppression = missionNamespace getVariable [_suppressionKey, false];
private _previewKey = "GW_Gear_PreviewInProgress";
private _previousPreviewState = missionNamespace getVariable [_previewKey, false];
missionNamespace setVariable [_suppressionKey, true];
missionNamespace setVariable [_previewKey, true];

collect3DENHistory {
	{
		private _unit = _x;
		private _isBlacklisted = _unit getVariable ["GW_Gear_BlackList", false];
		if (!_isBlacklisted) then {
			_isBlacklisted = (_unit get3DENAttribute "GW_DisableGearInit") param [0, false];
		};

		private _faction = [side _unit] call _getFactionForSide;
		if (_isBlacklisted || {_faction isEqualTo ""}) then {
			_skipped = _skipped + 1;
		} else {
			private _role = _unit getVariable ["GW_Gear_Loadout", ""];
			if (_role isEqualTo "") then {
				_role = (_unit get3DENAttribute "GW_LoadoutSelector") param [0, ""];
			};
			// Before the first save 3DEN can expose an unset combo attribute as
			// Boolean false. The gear handler accepts roles only as strings/arrays.
			if !(_role isEqualType "" || {_role isEqualType []}) then {
				diag_log format ["[GW][3DEN][GearPreview] invalid role attribute for %1 (%2); inferring role", _unit, typeName _role];
				_role = "";
			};
			if (_role isEqualTo "") then {
				_role = [_unit] call FUNC(getLoadoutClass);
			};
			if !(_role isEqualType "") then {
				diag_log format ["[GW][3DEN][GearPreview] role inference returned %1 for %2; using rifleman", typeName _role, _unit];
				_role = "r";
			};
			if !(_faction isEqualType "") then {
				diag_log format ["[GW][3DEN][GearPreview] invalid faction setting for %1 (%2); skipping", _unit, typeName _faction];
				_skipped = _skipped + 1;
				continue;
			};

			private _signature = [_faction, _role, _sourceRevision];
			if (!_force && {_signature isEqualTo (_unit getVariable ["GW_3DEN_GearPreviewSignature", []])}) then {
				_unchanged = _unchanged + 1;
			} else {
				[_unit, _role, _faction] call GW_Gear_fnc_Handler;
				_unit setVariable ["GW_3DEN_GearPreviewSignature", _signature];
				_previewed = _previewed + 1;
			};
		};
	} forEach _mapUnits;
};

missionNamespace setVariable [_suppressionKey, _previousSuppression];
missionNamespace setVariable [_previewKey, _previousPreviewState];
[format ["Gear preview refreshed for %1 map unit(s)%2%3.", _previewed, if (_unchanged > 0) then {format ["; %1 unchanged", _unchanged]} else {""}, if (_skipped > 0) then {format ["; skipped %1", _skipped]} else {""}], 0, 5, true] call BIS_fnc_3DENNotification;

[_previewed, _unchanged, _skipped]