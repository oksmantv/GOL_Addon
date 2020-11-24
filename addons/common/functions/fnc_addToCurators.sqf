#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Synchronise unit, vehicles & objects with all curators in mission

	Usage:
	[this] call GW_Common_Fnc_addToCurators;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: NO
*/

params ["_unit"];
if (_unit isKindOf "HeadlessClient_F") exitWith {false};

{
	_x addCuratorEditableObjects [[_unit],true];
} foreach (allCurators);
