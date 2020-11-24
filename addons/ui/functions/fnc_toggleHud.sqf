#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[true] call GW_UI_fnc_toggleHud;

	Arguments:
	0: <BOOL> - Enable

	Return Value:
	<Bool> - Current Status

	Public:
*/

params ["_enable"];

if (_enable) then {
	_mode = player getVariable [QGVAR(STHUD_Mode), 1];
	if (EGVAR(menu,STHud_Enabled)) then {
		STHUD_UIMode = _mode;
	} else {
		_mode call fn_sthud_usermenu_changeMode;
	};
} else {
	if (EGVAR(menu,STHud_Enabled)) then {
		player setVariable [QGVAR(STHUD_Mode), STHUD_UIMode];
		STHUD_UIMode = 0;
	} else {
		player setVariable [QGVAR(STHUD_Mode), sthud_usermenu_uitypeInd];
		0 call fn_sthud_usermenu_changeMode;
	};
};

STHUD_UIMode
