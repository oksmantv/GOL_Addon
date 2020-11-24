#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	returns all groups waiting to be transfered

	Usage:
	[] call GW_HeadlessController_fnc_getPending

	Arguments: NO

	Return Value: YES <ARRAY>

	Public: NO
*/

allGroups select {_x getVariable [QGVAR(pending), false]}
