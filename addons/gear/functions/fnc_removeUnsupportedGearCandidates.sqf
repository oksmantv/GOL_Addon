/*
	Author: GOL
	Removes classnames from a gear choice that belong to removed mods.

	Arguments:
	0: Candidate classname or array of alternative classnames <STRING | ARRAY>

	Return Value:
	Sanitized classname or candidate array <STRING | ARRAY>
*/
#include "..\script_component.hpp"

params [
	["_candidates", "", ["", []]]
];

private _blockedPrefixes = (missionNamespace getVariable [QGVAR(DlcValidationBlockedPrefixes), "HLC_,LOP_"]) splitString ",;";
_blockedPrefixes = _blockedPrefixes apply {toLower _x};

private _isBlocked = {
	params ["_className"];
	_className isEqualType "" && {
		_blockedPrefixes findIf {_x != "" && {(toLower _className) find _x isEqualTo 0}} > -1
	}
};

if (_candidates isEqualType "") exitWith {
	if ([_candidates] call _isBlocked) then {""} else {_candidates}
};

_candidates select {!([_x] call _isBlocked)}