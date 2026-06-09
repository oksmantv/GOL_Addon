#include "script_component.hpp"

diag_log "[GW_Gear] XEH_postInit started";

// Legacy missions handle their own postInit — stand down.
if !(isClass (missionConfigFile >> "gw_Modules" >> "Gear")) exitWith {
	diag_log "[GW_Gear] Legacy mission detected: skipping Gear postInit";
};

diag_log "[GW_Gear] New-style mission detected: registering vehicle/unit handlers";

// AllVehicles init — assign gear when spawned
["AllVehicles", "init", {
	params ["_unit"];
	if ((_unit isKindOf "CAManBase") && !(isPlayer _unit)) then {
		if (isNil {((group _unit) getVariable QGVAR(Loadout_Type))}) then {
			(group _unit) setVariable [QGVAR(Loadout_Type), false, true];
		};
	};
	_this call FUNC(Init);
}, true, [], true] call CBA_fnc_addClassEventHandler;

// Stamina event — apply load coefficient when fired
[QGVAR(setPlayerStamina), {
	if (GVAR(Stamina)) then {
		player setUnitTrait ["loadCoef", GVAR(StaminaCoef)];
		player setFatigue 0;
	};
}] call CBA_fnc_addEventHandler;

diag_log "[GW_Gear] XEH_postInit finished";

// Player ready — wire up stamina, respawn persistence
[QGVARMAIN(playerReady), {
	[QGVAR(setPlayerStamina), []] call CBA_fnc_localEvent;

	["CAManBase", "Killed", {
		params [["_unit", objNull, [objNull]]];
		if (isPlayer _unit) then {
			_unit setVariable [QGVAR(unitGear), (getUnitLoadout _unit)];
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	["CAManBase", "Respawn", {
		params [["_unit", objNull, [objNull]]];
		[{
			params [["_unit", objNull, [objNull]]];
			if !(local _unit) exitWith {false};

			_currentLoadout = (_unit getVariable QGVAR(unitGear));
			if !((_unit getVariable [QEGVAR(Menu,getUnitLoadout), nil]) isEqualTo nil) then {
				_currentLoadout set [5, (_unit getVariable QEGVAR(Menu,getUnitLoadout))];
				_unit setVariable [QEGVAR(Menu,getUnitLoadout), nil];
			};

			_unit setUnitLoadout (_unit getVariable QGVAR(unitGear));
			_unit selectWeapon (primaryWeapon _unit);
			[_unit, true] call ace_hearing_fnc_putInEarplugs;

			[QGVAR(setPlayerStamina), []] call CBA_fnc_localEvent;
		}, _this, 0.1] call CBA_fnc_waitAndExecute;
	}, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

// Config summary — fires after all CBA settings are finalised
["CBA_settingsInitialized", {
	diag_log "[GW_Gear] ── Configuration ───────────────────────────────────";
	diag_log format ["[GW_Gear]  Handler  : %1", ["ADDON (standard)", "LOCAL (mission)"] select GVAR(UseLocalHandler)];
	diag_log format ["[GW_Gear]  Default  : %1", ["ADDON",            "LOCAL (mission)"] select GVAR(UseLocalDefault)];
	diag_log format ["[GW_Gear]  DefaultAI: %1", ["ADDON",            "LOCAL (mission)"] select GVAR(UseLocalDefaultAI)];
	diag_log format ["[GW_Gear]  BLUFOR   : %1", GVAR(Blufor)];
	diag_log format ["[GW_Gear]  OPFOR    : %1", GVAR(Opfor)];
	diag_log format ["[GW_Gear]  INDEP    : %1", GVAR(Independent)];
	diag_log format ["[GW_Gear]  CIV      : %1", GVAR(Civilian)];
	diag_log format ["[GW_Gear]  AutoAssign: %1 | randomGear: %2 | extraGear: %3 | removeCargo: %4",
		GVAR(Auto_Assign), GVAR(randomGear), GVAR(extraGear), GVAR(autoRemoveCargo)];
	diag_log format ["[GW_Gear]  Stamina  : %1 (coef: %2)", GVAR(Stamina), GVAR(StaminaCoef)];
	diag_log "[GW_Gear] ────────────────────────────────────────────────────";
}] call CBA_fnc_addEventHandler;

