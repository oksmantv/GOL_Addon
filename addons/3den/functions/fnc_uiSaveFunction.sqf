#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_uiSaveFunction

	Parameters: None

	Return Value: No

	Public: NO
*/

params [["_params", ""],["_function", ""]];

if !(_function isEqualTo "") exitWith {
	(uiNamespace setVariable [QGVAR(FunctionParams), _params]);
	(uiNamespace setVariable [QGVAR(FunctionName), _function]);
	true
};

false
