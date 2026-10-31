#include "script_Component.hpp"
/*
	AUTHOR: GW Team
	Normalizes unit row formats used by spawn arrays into one stable shape.

	Input row formats accepted:
	- New:    [pos, dir, stanceOrUnitPos, specials, role]
	- Legacy: [pos, dir, specials, role]
	- Legacy: [pos, dir, specials]

	Defaults are caller-configurable:
	- _defaultUnitPos: e.g. "Auto" (stance) or [] (no stance override)
	- _defaultRole: e.g. "" (no role override) or "r" (force rifleman)

	What specials look like:
	- ARRAY of [selector, value] pairs consumed by setAttributes/setAttributes3DEN
	- Example: [[301, 1], [0, "this setDamage 0"]]
	  - 301 can represent ACE medic level from copied editor attributes
	  - 0 can represent init code

	Usage:
	[_row] call GW_Common_fnc_normalizeSpawnUnitRow;
	[_row, "Auto", ""] call GW_Common_fnc_normalizeSpawnUnitRow;
	[_row, [], ""] call GW_Common_fnc_normalizeSpawnUnitRow;

	Return:
	[pos, dir, unitPosOrStance, specials, role]
*/

params [
	["_row", [], [[]]],
	["_defaultUnitPos", "Auto", ["", []]],
	["_defaultRole", "", [""]]
];

private _pos = [0, 0, 0];
private _dir = 0;
private _unitPos = _defaultUnitPos;
private _specials = [];
private _role = _defaultRole;

if !(_row isEqualType [] && {count _row >= 2}) exitWith {
	[_pos, _dir, _unitPos, _specials, _role]
};

_pos = _row param [0, _pos, [[]]];
_dir = _row param [1, _dir, [0]];

private _p2 = _row param [2, nil];
private _p3 = _row param [3, nil];
private _p4 = _row param [4, nil];

if (_p2 isEqualType []) then {
	if (_p3 isEqualType "") then {
		// Legacy: [pos, dir, specials, role]
		_specials = _p2;
		_role = _p3;
	} else {
		if (_p3 isEqualType []) then {
			// New: [pos, dir, stanceOrUnitPos, specials, role]
			_unitPos = _p2;
			_specials = _p3;
		} else {
			// Legacy: [pos, dir, specials]
			_specials = _p2;
		};

		if (_p4 isEqualType "") then {
			_role = _p4;
		};
	};
} else {
	if (_p2 isEqualType "") then {
		_unitPos = _p2;
	};

	if (_p3 isEqualType []) then {
		_specials = _p3;
	};

	if (_p4 isEqualType "") then {
		_role = _p4;
	} else {
		if (_p3 isEqualType "") then {
			_role = _p3;
		};
	};
};

if !(_specials isEqualType []) then {
	_specials = [];
};

if !(_role isEqualType "") then {
	_role = _defaultRole;
};
if (_role isEqualTo "") then {
	_role = _defaultRole;
};

if (_unitPos isEqualType "") then {
	if (toLower _unitPos isEqualTo "auto") then {
		_unitPos = "Auto";
	};
};

[_pos, _dir, _unitPos, _specials, toLower _role]
