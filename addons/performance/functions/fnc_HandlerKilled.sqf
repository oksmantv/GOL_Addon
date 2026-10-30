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

if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};
if (!(GVAR(UnitEnabled)) || ((isPlayer _unit) || (_unit getVariable [QGVARMAIN(isPlayer), false]))) exitWith {false};

// Only disable simulation if the corpse is NOT inside a vehicle.
// Disabling simulation on a dead body that still occupies a vehicle seat locks
// that seat permanently — the body cannot be ejected or replaced while unsimulated.
[{
	params ["_unit"];
	if (vehicle _unit isEqualTo _unit) then {
		_unit enableSimulationGlobal false;
	};
}, _unit, 5] call CBA_fnc_waitAndExecute;

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
