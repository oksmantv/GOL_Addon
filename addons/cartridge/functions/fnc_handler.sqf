#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_Cartridge_fnc_handler

	Parameters: None

	Return Value: None

	Public: NO
*/

if (GVAR(Enabled)) then {
	{
		_x params ["_cartridge"];
		if !(isNull _cartridge) then {
			private _timer = (_cartridge getVariable [QGVAR(RemovalTimer), 0]);
			private _distance = ({(_x distance _cartridge) < 15} count allPlayers);

			_cartridge setVariable [QGVAR(RemovalTimer), _timer - 1];

			if ((_distance isEqualTo 0) && _timer isEqualTo 0) then {
				deleteVehicle _cartridge;
			};
		};
	} foreach GVAR(Array);

	GVAR(Array) = GVAR(Array) - (GVAR(Array) select {isNull _x})
};
