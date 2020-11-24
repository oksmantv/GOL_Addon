#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	When a unit dies it deletes all magazines & items for the unit
	So that players cant loot

	Is only active if set to true at time of calling function
		GW_Performance_Unitenabled = true;

	Usage:
	[this] call GW_Performance_Fnc_HandlerKilled;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: NO
*/

params ["_unit"];

[{
	params ["_unit"];
	_unit enableSimulationGlobal false;
}, _unit, 5] call CBA_fnc_waitAndExecute;

if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};
if (!(GVAR(UnitEnabled)) || ((isPlayer _unit) || (_unit getVariable [QGVARMAIN(isPlayer), false]))) exitWith {false};

{
	_unit removeItem _x;
} forEach (itemsWithMagazines _unit);

{
	_unit unlinkItem _x;
} forEach (assignedItems _unit);

{
	_unit removeItem _x;
} forEach (magazines _unit);

_unit
