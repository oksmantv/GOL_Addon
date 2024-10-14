/*
#include "script_component.hpp"

if (primaryWeapon player != "") then {
	player playMoveNow "AmovPknlMstpSlowWrflDnon";
};

["Deploying", 5, {true}, {
	(_this select 0) params ["_unit"];

	private _type = (_unit getVariable [QGVAR(type), ""]);
	private _objectRemoved = true;
	private _dir = (getDir _unit);
	private _pos = (player getRelPos [2, 0]);
	_pos set [2, ((getPosATL player) select 2)];


	{
		if !(_x isEqualTo "GW_Item_StaticDummy") exitWith {
			_unit removeItem "GW_Item_StaticDummy";
			_objectRemoved = true;
		};
	} count (itemsWithMagazines _unit);

	if (_objectRemoved && !(_type isEqualTo "")) then {
		private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
		_object setPosATL _pos;
		_object setDir _dir;
		_unit setVariable [QGVAR(type), ""];
	};

	true
}, {
	["Aborted", 3] call GW_Common_Fnc_Hint;
	false
}, _this] call CBA_fnc_progressBar;

true
*/