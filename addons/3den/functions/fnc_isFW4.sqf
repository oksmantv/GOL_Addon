#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Checks if the mission open in 3DEN uses Framework 4 or newer.
	Framework 3.x missions (Core\version.hpp, Modules\Gear) keep their legacy behaviour,
	so addon owned automation must not touch them.

	Usage:
	[] call GW_3DEN_fnc_isFW4;

	Arguments: NO

	Return Value:
	<BOOL> - True for Framework 4+, false for 3.x or when no GW_FRAMEWORK class exists

	Public: NO

*/

if !(isClass (missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};

// Version string is "<major>.<minor>.<patch>.<build>"
private _version = getText (missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version");

(parseNumber ((_version splitString ".") param [0, "0"])) >= 4
