#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Calculates if its day or night

	Usage:
	[] call GW_Common_Fnc_isNight;

	Arguments:

	Return Value: BOOL

	Public: NO
*/

private _sunAngle = (call FUNC(getSunAngle));
private _night = false;

If (_sunAngle < -7) then {
	_night = true;
};

_night
