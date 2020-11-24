#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Returns all groups that has been transfered

	Usage:
	[] call GW_HeadlessController_fnc_getTransfered

	Arguments: NO

	Return Value: YES <ARRAY>

	Public: NO
*/

allGroups select {_x getVariable [QGVAR(Transfered), false]}
