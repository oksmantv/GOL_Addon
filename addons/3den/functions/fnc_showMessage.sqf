#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[1, true] call GW_3DEN_fnc_showMessage;

	Parameters:
	#0	NUMBER:	Case in Swithc

	Return Value: <GROUP>
	Group that spawned

	Public: NO

*/

params [
	"_type",
	"_alternetive"
];

switch (_type) do {
	case 1: {
		["Collection of things that the editor does not support by default, More info on GW-Addons Wiki","Help - Actions"] call BIS_fnc_3DENShowMessage;
	};
	case 2: {
		["These are shortcuts for editing multiple objects at once, All this settings can also be changed by going in to each object seperatly, More info on GW-Addons Wiki","Help - setAttributes"] call BIS_fnc_3DENShowMessage;
	};
	case 3: {
		["Functions and Actions that are rearly used, More info on GW-Addons Wiki","Help - Misc"] call BIS_fnc_3DENShowMessage;
	};
	case 4: {
		[", More info on GW-Addons Wiki","Help - Framework"] call BIS_fnc_3DENShowMessage;
	};
};
