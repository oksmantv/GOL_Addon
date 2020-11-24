#include "script_Component.hpp"
/*
	Author: Unknown
	Gets sun angle based on time of day and latitude

	Usage:
	[] call GW_Common_Fnc_getSunAngle;

	Arguments: NO

	Return Value: BOOL

	Public: NO
*/

private ["_lat","_day","_hour","_sunangle"];

_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
_day = 360 * (dateToNumber date);
_hour = (daytime / 24) * 360;
_sunangle = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));

_sunangle
