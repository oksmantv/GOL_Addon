/*
*	Author: GuzzenVonLidl
*	Outputs server info for admins to debug
*
*	Usage:
*	[] call GW_MonitorServer_Fnc_Toggle;
*	Arguments: NO
*
*	Return Value: NO
*
*	Public: NO
*
*/
#include "script_component.hpp"

if (GVAR(doRecive)) then {	// If enabled, Remove it
	[QGVAR(removeServerRequest), player] call CBA_fnc_serverEvent;
	GVAR(doRecive) = false;
	[{
		hintSilent "";
	}, [], 3] call CBA_fnc_waitAndExecute;
} else {
	[QGVAR(addServerRequest), player] call CBA_fnc_serverEvent;
	GVAR(doRecive) = true;
};

GVAR(doRecive)