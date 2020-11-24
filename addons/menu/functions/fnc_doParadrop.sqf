#include "script_component.hpp"

params ["_unit"];
cutText ["", "BLACK FADED",999];
private _vehicle = (vehicle _unit);
private _height = round((getPosASL _unit) select 2);
private _velocity = [-((velocity _vehicle) select 0),-((velocity _vehicle) select 1), (((velocity _vehicle) select 2) -10)];
private _backpack = (unitBackpack _unit);
(boundingBoxReal _vehicle) params ["_p1","_p2"];
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
_unit action ["Eject", _vehicle];
moveOut _unit;
_pos = (_vehicle getRelPos [_maxLength + 2, 180]);
_pos set [2, (getPos _vehicle) select 2];
_unit setDir (getDir _vehicle);
_unit setPosATL _pos;
_unit setVelocity _velocity;
_unit setVariable [QGVAR(getUnitLoadout), ((getUnitLoadout _unit) select 5)];
removeBackPack _unit;

[{
	cutText ["", "BLACK IN", 5];
}, [], 0.5] call CBA_fnc_waitAndExecute;

if (GVAR(ParadropHalo)) then {
	_unit addBackpack "B_Parachute";
} else {
	[{(((getPosATL player) select 2) <= GVAR(ParadropStaticHeight))}, {
		params ["_unit"];
		private _pos = (getPos _unit);
		private _chute = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "NONE"];
		_chute setDir (getDir _unit);
		_chute setPos _pos;
		_unit moveInDriver _chute;
	}, [_unit]] call CBA_fnc_waitUntilAndExecute;
};

[{((((getPos player) select 2) < 1) && (alive player)) || !(alive player)}, {
	params ["_unit"];
	if (alive player) then {
		_loadout = (_unit getVariable [QGVAR(getUnitLoadout), nil]);
		if !((_loadout select 0) isEqualTo "") then {
			_currentLoadout = (getUnitLoadout _unit);
			_currentLoadout set [5, (_unit getVariable QGVAR(getUnitLoadout))];
			_unit setUnitLoadout _currentLoadout;
			_unit setVariable [QGVAR(getUnitLoadout), nil];
		};
	} else {
		[{(alive player)}, {
			[{
				params ["_unit"];
				_unit setVariable [QGVAR(getUnitLoadout), nil];
			}, _this, 1] call CBA_fnc_waitAndExecute;
		}, _this] call CBA_fnc_waitUntilAndExecute;
	};
}, [_unit]] call CBA_fnc_waitUntilAndExecute;

/*
[{(isTouchingGround player) || (((getPos player) select 2) < 1) && (alive player)}, {
	params ["_unit"];
	_loadout = (_unit getVariable [QGVAR(getUnitLoadout), nil]);
	if !((_loadout select 0) isEqualTo "") then {
		_currentLoadout = (getUnitLoadout _unit);
		_currentLoadout set [5, (_unit getVariable QGVAR(getUnitLoadout))];
		_unit setUnitLoadout _currentLoadout;
	};
}, [_unit]] call CBA_fnc_waitUntilAndExecute;
/*
