#include "script_Component.hpp"
/*
	Author: Unknown
	Dummy function for now

	Usage:
	[] call GW_Common_Fnc_setTimeBySunAngle;

	Arguments:
	#1:	BOOL - True Return only if its night time, False Returns if its dawn, dusk or night

	Return Value: BOOL

	Public: NO
*/

params [["_timeToSkipTo", 12]];

//skipTime = (_timeToSkipTo - daytime + 24 ) % 24;
