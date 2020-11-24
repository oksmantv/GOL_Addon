#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Counts current groups local to a headless client

	Usage:
	[] call GW_HeadlessController_fnc_countBalance

	Arguments: NO

	Return Value: <ARRAY>
	0: Groups local
	1: Headless

	Public: NO
*/

private _groupCount = [];
{
	_x params ["_headless"];
	_groupCount pushBack [({(groupOwner _x) isEqualTo (owner _headless)} count allGroups), _headless];
} forEach (call FUNC(getList));
_groupCount sort true;
_groupCount
