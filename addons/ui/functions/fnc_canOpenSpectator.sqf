#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[player] call GW_UI_fnc_canOpenSpectator;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/

params ["_unit"];

_pos = [_unit] call GW_Common_fnc_getRespawn;
_area = [(ATLToASL _pos), 25, 25, 0, false, 25];
(_unit inArea _area)
