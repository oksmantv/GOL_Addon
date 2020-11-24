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

params ["_objectType","_object"];

private _timer = 20;
private _distance = 50;

if (isNil {_object getVariable QGVAR(ObjectRemovalTimer)}) then {
	switch (_objectType) do {
		case 1: { // Vehicle
			_timer = 45;
		};
		case 2: { // WeaponHolder
			_timer = 5;
		};
		case 3: { // Ruins
			_timer = 25;
		};
	};
	_object setVariable [QGVAR(ObjectRemovalTimer), _timer];
};

if (isNil {_object getVariable QGVAR(ObjectDistance)}) then {
	switch (_objectType) do {
		case 1: { // Vehicle
			_distance = 300;
		};
		case 2: { // WeaponHolder
			_distance = 25;
		};
		case 3: { // Ruins
			_distance = 500;
		};
	};
	_object setVariable [QGVAR(ObjectDistance), _distance];
};

private _getTime = (_object getVariable QGVAR(ObjectRemovalTimer));
if (_getTime isEqualTo 0) then {
	if (({(_x distance2D _object) < (_object getVariable QGVAR(ObjectDistance))} count allPlayers) isEqualTo 0) then {
		TRACE_1("Deleting", _object);
		deleteVehicle _object;
	};
} else {
	TRACE_1("Removal Timer", _getTime);
	_object setVariable [QGVAR(ObjectRemovalTimer), _getTime - 1];
};
