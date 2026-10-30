/*
	Author: GuzzenVonLidl
	Applies the long-range optic skill penalty after a unit's base skill tree is set.

	A non-magnified optic normally uses an optic FOV of 0.75. An optic with at
	least one mode below that FOV gives AI access to a magnified, long-range view.
	To compensate, reduce its weapon-handling skills by 20%.

	Arguments:
	0: Unit <OBJECT>

	Return Value:
	Whether a long-range optic penalty was applied <BOOL>
*/
#include "script_component.hpp"

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || {!alive _unit}) exitWith {false};
if (_unit getVariable [QGVAR(hasLongRangeOpticPenalty), false]) exitWith {true};

private _optic = (primaryWeaponItems _unit) param [2, "", [""]];
private _hasLongRangeOptic = false;

if (_optic != "") then {
	private _opticModes = configProperties [
		configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes",
		"isClass _x",
		true
	];

	{
		private _opticZoomMin = getNumber (_x >> "opticsZoomMin");
		if (_opticZoomMin > 0 && {_opticZoomMin < 0.75}) exitWith {
			_hasLongRangeOptic = true;
		};
	} forEach _opticModes;
};

if (_hasLongRangeOptic) then {
	{
		_unit setSkill [_x, ((_unit skill _x) * 0.8)];
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed"];
	_unit setVariable [QGVAR(hasLongRangeOpticPenalty), true, false];
};

_hasLongRangeOptic