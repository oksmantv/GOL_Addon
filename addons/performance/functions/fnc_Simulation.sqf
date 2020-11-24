#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Makes it so that you can spawn in a group without any performance impacts for players
	Is only active if set to true at time of calling function

	Usage:
	[this] call GW_Performance_Fnc_Simulation;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: NO
*/

params ["_unit"];

if ((time < 5) || !((vehicleVarName _unit) isEqualType "") || !(alive _unit)) exitWith {false};

if ((isNull (objectParent _unit))) then { 	// isOnFoot
	_unit enableSimulationGlobal false;

	[{
		params ["_unit"];
		_unit enableSimulationGlobal true;
		if ((isNull (objectParent _unit))) then {	// isOnFoot
			_unit setPosATL (getPosATL _unit);
		};
	}, _unit, (2 + (random 3))] call CBA_fnc_waitAndExecute;
};
