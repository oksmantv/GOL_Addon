#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_Cartridge_fnc_fired

	Parameters: None

	Return Value: None

	Public: NO
*/

params ["_unit","_muzzle","_weapon","_type","_ammo"];

if (count GVAR(Array) > 1000) exitWith {
	[] call FUNC(handler);
	false
};

private _cartridge = (getText (configFile >> "CfgAmmo" >> _ammo >> "cartridge"));
private _cartridgeModel = (getText (configFile >> "CfgVehicles" >> _cartridge >> "model"));
private _position = (_unit getRelPos [(1.2 + (random 3)), (80 + (random 50))]);
_position set [2, (((getPosATL _unit) select 2))];


if (_cartridge isEqualTo "") then {
//	_cartridge = "FxCartridge_556";
};

if !(_cartridge isEqualTo "") then {
	_c = createSimpleObject [_cartridge, [0,0,0]];
	_c setDir (random 360);
	_c setPosATL _position;
	_c setVectorUp [0,0,1];
	GVAR(Array) pushBack _c;
	_c setVariable [QGVAR(RemovalTimer), 10];
};
