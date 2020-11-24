#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Calculates if its day or night

	Usage:
	[] call GW_Common_Fnc_getVersionFramework;

	Arguments:
	0: <BOOL> - Option to return either number (true), or text (false: Default)

	Return Value: BOOL

	Public: NO
*/

params [["_return", false, [true]]];

if (_return) then {
	getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version")
} else {
	getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version")
};

