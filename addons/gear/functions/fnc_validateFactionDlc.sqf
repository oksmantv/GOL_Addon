/*
	Validates DLC watermark risks for every selectable player role in one faction.
	Designed for the 3DEN export validator. It uses a temporary local unit so the
	actual faction and default-loadout scripts remain the single source of truth.

	Arguments:
	0: Faction identifier <STRING>
	1: Arma side represented by the faction <SIDE>

	Return Value:
	[[role, slot, [[classname, dlcLabel], ...]], ...] <ARRAY>
*/
#include "..\script_component.hpp"

params [
	["_faction", "", [""]],
	["_side", west, [west]]
];

if (_faction isEqualTo "") exitWith {[]};

private _unitClass = switch (_side) do {
	case east: {"O_Soldier_F"};
	case independent: {"I_Soldier_F"};
	case civilian: {"C_man_1"};
	default {"B_Soldier_F"};
};
private _roles = ["officer", "pl", "pm", "fac", "sl", "sm", "ftl", "r", "g", "ag", "ar", "ab", "atab", "lightdragon", "ammg", "mmg", "dragon", "aa", "amat", "mat", "drone", "engineer", "lr", "marksman", "crew", "diver", "p", "pj", "jetp"];
private _results = [];
private _captureKey = QGVAR(DlcValidationCapture);
private _suppressNotificationsKey = QGVAR(DlcValidationInProgress);
private _previousCapture = missionNamespace getVariable [_captureKey, nil];
private _previousEnabled = missionNamespace getVariable [QGVAR(DlcValidation), true];
private _previousNotificationSuppression = missionNamespace getVariable [_suppressNotificationsKey, false];

missionNamespace setVariable [QGVAR(DlcValidation), true];
missionNamespace setVariable [_captureKey, []];
missionNamespace setVariable [_suppressNotificationsKey, true];

{
	private _role = _x;
	private _unit = createVehicleLocal [_unitClass, [0, 0, 0], [], 0, "NONE"];
	_unit hideObject true;
	_unit enableSimulation false;
	addSwitchableUnit _unit;
	missionNamespace setVariable [_captureKey, []];
	[_unit, _role, _faction] call FUNC(Handler);
	{
		_x params ["_slot", "_items"];
		_results pushBack [_role, _slot, _items];
	} forEach (missionNamespace getVariable [_captureKey, []]);
	removeSwitchableUnit _unit;
	deleteVehicle _unit;
} forEach _roles;

missionNamespace setVariable [QGVAR(DlcValidation), _previousEnabled];
missionNamespace setVariable [_suppressNotificationsKey, _previousNotificationSuppression];
if (isNil "_previousCapture") then {
	missionNamespace setVariable [_captureKey, nil];
} else {
	missionNamespace setVariable [_captureKey, _previousCapture];
};

_results arrayIntersect _results