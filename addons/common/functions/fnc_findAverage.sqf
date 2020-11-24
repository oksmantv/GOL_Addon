#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	get average number from array

	Usage:
	[5,3,1] call GW_Common_Fnc_findAverage;

	Arguments:
	0: Find average <ARRAY>

	Return Value: YES <NUMBER>

	Public: NO
*/

private ["_total"];

if ((count _this) isEqualTo 0) exitWith {0};
_total = 0;

{
	_total = _total + _x;
} forEach _this;

(_total / (count _this))
