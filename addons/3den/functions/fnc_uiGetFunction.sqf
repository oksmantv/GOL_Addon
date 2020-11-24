#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_uiGetFunction

	Parameters: None

	Return Value: No

	Public: NO
*/

private _params = (uiNamespace getVariable [QGVAR(FunctionParams), ""]);
private _function = (uiNamespace getVariable [QGVAR(FunctionName), ""]);

[_params, _function]
