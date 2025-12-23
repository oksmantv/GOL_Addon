#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets Location in the area and then moves selected units to the valid house positions

	Usage:
	[] call GW_3DEN_fnc_SelectCopyFunction

	Parameters: None

	Return Value: None

	Public: NO
*/

params ["_copyGroup","_copyType"];

if ((get3DENSelected "object") isEqualTo []) exitWith {
	systemChat "Nothing to copy";
	false
};

if (_copyGroup) then {
	[_copyType] call FUNC(copyGroup);
} else {
	[_copyType] call FUNC(copyStatic);
};
