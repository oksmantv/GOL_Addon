#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	A performance handler that removes dead bodies, weaponholders and vehicles after some time

	Usage:
	[] call GW_Performance_Fnc_HandlerCleanUp;

	Arguments: NO

	Return Value: NO

	Public: NO
*/

{
	private _type = 1;
	if (_x isKindOf "CAManBase") then {
		_type = 0;
	};
	[_type, _x] call FUNC(HandlerCleanUpCounter);
} forEach (allDead - GVAR(ignoreDead));
/*
{
	[3, _x] call FUNC(HandlerCleanUpCounter);
} forEach (allMissionObjects "Ruins");
*/
[{
	{
		TRACE_1("Deleting group", _x);
		[QGVAR(removeGroup), _x] call CBA_fnc_GlobalEvent;
	} forEach (allGroups select {(count (units _x) isEqualTo 0)});
}, [], 1] call CBA_fnc_waitAndExecute;

[{
	{
		[2, _x] call FUNC(HandlerCleanUpCounter);
	} forEach (allMissionObjects "WeaponHolder");
}, [], 2] call CBA_fnc_waitAndExecute;

[{
	{
		[2, _x] call FUNC(HandlerCleanUpCounter);
	} forEach (allMissionObjects "GroundWeaponHoder");
}, [], 3] call CBA_fnc_waitAndExecute;

[{
	{
		[2, _x] call FUNC(HandlerCleanUpCounter);
	} forEach (allMissionObjects "WeaponHolderSimulated");
}, [], 4] call CBA_fnc_waitAndExecute;

/*
{
	if (( _x distance [0,0,0]) isEqualTo 0) then {
		TRACE_1("Deleting Trigger", _x);
		deleteVehicle _x;
	};
} forEach allMissionObjects "EmptyDetector";
*/
