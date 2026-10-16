/*
	Author: GOL
	Checks one gear choice group for an approved fallback.

	Arguments:
	0: Candidate classname or array of alternative classnames <STRING | ARRAY>
	1: Human-readable loadout slot <STRING>

	Return Value:
	Warnings in the format [[slot, [[classname, dlcLabel], ...]]] <ARRAY>
*/
#include "..\script_component.hpp"

params [
	["_candidates", "", ["", []]],
	["_slot", "", [""]]
];

if !(missionNamespace getVariable [QGVAR(DlcValidation), true]) exitWith {[]};

if (_candidates isEqualType "") then {
	_candidates = [_candidates];
};

private _classNames = _candidates select {
	_x isEqualType "" && {!(_x isEqualTo "")}
};
if (_classNames isEqualTo []) exitWith {[]};

private _blockedLabels = (missionNamespace getVariable [QGVAR(DlcValidationBlocked), "Contact,Enoch,GM,SOGPF,CSLA,WS,Spearhead1944,ExpeditionaryForces"]) splitString ",;";
_blockedLabels = _blockedLabels apply {toLower _x};
private _blockedPrefixes = (missionNamespace getVariable [QGVAR(DlcValidationBlockedPrefixes), "HLC_,LOP_"]) splitString ",;";
_blockedPrefixes = _blockedPrefixes apply {toLower _x};

private _hasApprovedFallback = false;
private _unsupportedItems = [];

{
	private _className = _x;
	private _itemConfig = configNull;
	{
		private _candidateConfig = configFile >> _x >> _className;
		if (isClass _candidateConfig) exitWith {
			_itemConfig = _candidateConfig;
		};
	} forEach ["CfgWeapons", "CfgMagazines", "CfgGlasses", "CfgVehicles"];

	private _dlcLabel = if (isNull _itemConfig) then {""} else {getText (_itemConfig >> "dlc")};
	private _blockedPrefix = _blockedPrefixes findIf {_x != "" && {(toLower _className) find _x isEqualTo 0}};
	private _reason = "";
	if ((toLower _dlcLabel) in _blockedLabels) then {
		_reason = _dlcLabel;
	};
	if (_blockedPrefix > -1) then {
		_reason = format ["prefix %1", _blockedPrefixes select _blockedPrefix];
	};

	if !(_reason isEqualTo "") then {
		_unsupportedItems pushBack [_className, _reason];
	} else {
		_hasApprovedFallback = true;
	};
} forEach _classNames;

if (_hasApprovedFallback || {_unsupportedItems isEqualTo []}) exitWith {[]};

[[ _slot, _unsupportedItems ]]