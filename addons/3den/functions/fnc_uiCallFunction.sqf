#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_uiCallFunction

	Parameters: None

	Return Value: No

	Public: NO
*/

private _params = (uiNamespace getVariable [QGVAR(FunctionParams), ""]);
private _function = (uiNamespace getVariable [QGVAR(FunctionName), ""]);

if (_function isEqualTo "") then {
	false;
} else {
	_compile = (compile (format ["%1", (toString(toArray(format ["%1 call %2", _params, _function])))]));

	systemChat (str _compile);
	call _compile;
	true;
};
