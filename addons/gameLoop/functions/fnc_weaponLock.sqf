#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Toggle removal of all damage for player and bullets fired

	Usage:
	true call GW_GameLoop_Fnc_WeaponLock;

	Arguments:
	0: Enable weaponlock <BOOL>

	Return Value: NO

	Public: No
*/
#define CURRENT_WEAPONS player, currentWeapon player, currentMuzzle player

params [
	"_toggle",
	["_displayText", true]
];

if (_toggle) then {
	player setCaptive true;
	player allowDamage false;
	player setVariable [QGVAR(weaponLock), true];
	if (GVARMAIN(mod_ACE3)) then {
		player setVariable ["ACE_Medical_AllowDamage", false];
		if ((currentWeapon player) in (player getVariable ["ACE_SafeMode_safedWeapons", []])) then {
			[CURRENT_WEAPONS] call ACE_SafeMode_fnc_lockSafety;
		};
	};

	if (isNil QGVAR(BlockFire)) then {
		GVAR(BlockFire) = player addEventHandler ["FiredMan", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
			if (GVARMAIN(mod_ACE3)) then {
				[_this select 6] call ACE_FRAG_Fnc_addBlackList;
			};
			deleteVehicle (_this select 6);
			["You cant fire your weapon while safeMode is active", 5] call GW_Common_Fnc_Hint;
		}];
	};
	if (isNil QGVAR(BlockVehicle)) then {
		GVAR(BlockVehicle) = player addEventHandler ["GetInMan", {
			if (GVAR(SafeMode_blockVeh)) then {
				params ["_unit", "_role", "_vehicle", "_turret"];
				_unit action ["Eject", _vehicle];
				moveOut _unit;
				["You cant get in to vehicles while safeMode is active", 5] call GW_Common_Fnc_Hint;
			};
		}];
	};
	if (time > 2 && _displayText) then {
		systemChat "[SafeMode]: Enabled";
	};
} else {
	player setCaptive false;
	player allowDamage true;
	player setVariable [QGVAR(weaponLock), false];

	if (GVARMAIN(mod_ACE3)) then {
		player setVariable ["ACE_Medical_AllowDamage", true];
	};

	if (isNull (objectParent player)) then {
		player playActionNow (getText (configfile >> "CfgWeapons" >> (currentWeapon player) >> "reloadAction"));
	};
	[{
		if (GVARMAIN(mod_ACE3)) then {
			if ((currentWeapon player) in (player getVariable ["ACE_SafeMode_safedWeapons", []])) then {
				[CURRENT_WEAPONS] call ACE_SafeMode_fnc_unlockSafety;
			};
		};
	}, [], (random 5)] call CBA_fnc_waitAndExecute;

	if !(isNil QGVAR(BlockFire)) then {
		player removeEventHandler ["FiredMan", GVAR(BlockFire)];
		GVAR(BlockFire) = nil;
	};
	if !(isNil QGVAR(BlockVehicle)) then {
		player removeEventHandler ["GetInMan", GVAR(BlockVehicle)];
		GVAR(BlockVehicle) = nil;
	};
	if (time > 2 && _displayText) then {
		systemChat "[SafeMode]: Disabled";
	};
};

/*
	{
		player removePrimaryWeaponItem _x;
	} forEach (primaryWeaponMagazine player);
	{
		player removeSecondaryWeaponItem _x;
	} forEach (secondaryWeaponMagazine player);
	{
		player removeHandgunItem _x;
	} forEach (handgunMagazine player);
*/
