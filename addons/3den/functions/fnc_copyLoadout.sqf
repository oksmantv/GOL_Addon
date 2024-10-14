#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Copy units, vehicles and waypoints

	Usage:
	[] call GW_3den_fnc_copyLoadout;

	Arguments: NO

	Return Value: YES <ARRAY>

	Public: NO
*/
#define	GETATTRIBUTE(Var1) ((_x get3DENAttribute Var1) select 0)
#define	GETMAGAZINE(Var1) (getArray(configfile >> "CfgWeapons" >> Var1 >> "magazines"))

private _arr = [player];
private _lineBreak = (toString [10]);
private _tab = toString [9];

if (is3DEN) then {
	_arr = (get3DENSelected "object");
};

if !(isNull(missionnamespace getvariable ["BIS_fnc_arsenal_center", objNull])) then {
	_arr = [(missionnamespace getvariable ["BIS_fnc_arsenal_center", objNull])];
};

if !(isNil "ACE_Arsenal_center") then {
	_arr = [ACE_Arsenal_center];
};

/*
private _return = _return + toArray(format ["[ %1 %2", _lineBreak, _tab]);
{
	_return = _return + toArray(format ["%1, // Primary %2 %3", ([primaryWeapon _x] + [(primaryWeaponItems _x)] + [GETMAGAZINE(primaryWeapon _x)]), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1, // Secondary %2 %3", ([secondaryWeapon _x] + [(secondaryWeaponItems _x)] + [GETMAGAZINE(secondaryWeapon _x)]), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1, // Handgun %2 %3", ([handgunWeapon _x] + [(handgunItems _x)] + [GETMAGAZINE(handgunWeapon _x)]), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1, // Cloths %2 %3", ([(goggles _x),(headgear _x),(uniform _x),(vest _x),(backpack _x)]), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1, // Items Uniform %2 %3", (uniformItems _x), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1, // Items Vest %2 %3", (vestItems _x), _lineBreak, _tab]);
	_return = _return + toArray(format ["%1 // Items Backpack %2", (backpackItems _x), _lineBreak]);
} forEach _arr;
_return = _return + toArray(format ["]; %1", _lineBreak]);
*/

private _return = [];
{

	_primaryTracer = "";
	_secondaryTracer = "";
	{
		if (getNumber(configfile >> "CfgMagazines" >> _x >> "tracersEvery") isEqualTo 1) exitWith {
			_primaryTracer = _x;
		};
	} forEach GETMAGAZINE(primaryWeapon _x);

	{
		if (getNumber(configfile >> "CfgMagazines" >> _x >> "tracersEvery") isEqualTo 1) exitWith {
			_primaryTracer = _x;
		};
	} forEach GETMAGAZINE(secondaryWeapon _x);

	_return = _return + toArray(format ["%3// %1 - %2", (typeOf _x), _x, endl]);
	_return = _return + toArray(format ["%1// Equipment %1", endl]);
	_return = _return + toArray(format ["_insignia = %1; %2", str([_x] call BIS_fnc_getUnitInsignia), endl]);
	_return = _return + toArray(format ["_goggles = %1; %2", str(goggles _x), endl]);
	_return = _return + toArray(format ["_helmet = %1; %2", str(headgear _x), endl]);
	_return = _return + toArray(format ["_uniform = %1; %2", str(uniform _x), endl]);
	_return = _return + toArray(format ["_vest = %1; %2", str(vest _x), endl]);
	_return = _return + toArray(format ["_backpack = %1; %2", str(backpack _x), endl]);

	_return = _return + toArray(format ["// Primary %1", endl]);
	_return = _return + toArray(format ["_silencer = %1; %5_pointer = %2; %5_sight = %3; %5_bipod = %4; %5", str((primaryWeaponItems _x)#0),str((primaryWeaponItems _x)#1),str((primaryWeaponItems _x)#2),str((primaryWeaponItems _x)#3), endl]);
	_return = _return + toArray(format ["_rifle = %1; %2", str(primaryWeapon _x), endl]);
	_return = _return + toArray(format ["_rifle_mag = %1; %2", str(GETMAGAZINE(primaryWeapon _x)#0), endl]);
	_return = _return + toArray(format ["_rifle_mag_tr = %1; %2", str _primaryTracer, endl]);

	_return = _return + toArray(format ["%1// Secondary %1", endl]);
	_return = _return + toArray(format ["_silencer = %1; %5_pointer = %2; %5_sight = %3; %5_bipod = %4; %5", str((secondaryWeaponItems _x)#0),str((secondaryWeaponItems _x)#1),str((secondaryWeaponItems _x)#2),str((secondaryWeaponItems _x)#3), endl]);
	_return = _return + toArray(format ["_LAT = %1; %2", str(secondaryWeapon _x), endl]);
	_return = _return + toArray(format ["_LAT_mag = %1; %2", str(GETMAGAZINE(secondaryWeapon _x)#0), endl]);

	_return = _return + toArray(format ["%1// Handgun %1", endl]);
	_return = _return + toArray(format ["_silencer = %1; %5_pointer = %2; %5_sight = %3; %5_bipod = %4; %5", str((handgunItems _x)#0),str((handgunItems _x)#1),str((handgunItems _x)#2),str((handgunItems _x)#3), endl]);
	_return = _return + toArray(format ["_pistol = %1; %2", str(handgunWeapon _x), endl]);
	_return = _return + toArray(format ["_pistolMag = %1; %2%2%2", str(GETMAGAZINE(handgunWeapon _x)#0), endl]);
} forEach _arr;

if (is3DEN) then {
	if ("Preferences" get3DENMissionAttribute "GW_CopyToClipboard") then {
		copyToClipboard (toString(_return));
	};

	if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleLog") then {
		"debug_console" callExtension (_return + "#1111");
	};

	if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleFile") then {
		"debug_console" callExtension (_return + "~0001");
	};
} else {
	copyToClipboard (toString(_return));
};
