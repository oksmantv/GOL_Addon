#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl

	Usage:
	[] call GW_HeadlessController_Fnc_UpdateBalance

	Arguments: NO

	Return Value: YES <ARRAY>

	Public: NO
*/

[{
	{
		_x params ["_units","_headless"];
		_headless setVariable [QGVAR(currentUnits), _units, true];
	} forEach (call FUNC(countBalance));

	{	//	Subtract empty groups from QGVAR(currentUnits)
		if ((count (units _x)) isEqualTo 0) then {
			private _groupOwner = (_x getVariable [QGVAR(currentOwner), GVARMAIN(Gamelogic)]);
			if (_groupOwner isKindOf "HeadlessClient_F") then {
				_groupOwner setVariable [QGVAR(currentUnits), ((_groupOwner getVariable QGVAR(currentUnits)) - 1), true];
			};
		};
	} forEach (call FUNC(getTransfered));

	{
		LOG(FORMAT_2("Headless stats finished %1: %2", _x, (_x getVariable QGVAR(currentUnits))));
	} forEach (call FUNC(getList));
}, [], 1] call CBA_fnc_waitAndExecute;
