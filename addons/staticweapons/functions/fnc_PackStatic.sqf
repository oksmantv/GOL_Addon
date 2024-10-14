/*
#include "script_component.hpp"

if (primaryWeapon player != "") then {
	player playMoveNow "AmovPknlMstpSlowWrflDnon";
};

["SCAPS - (Super Complex Advanced Packing of Static weapon)", 4, {true}, {
	(_this select 0) params ["_unit","_veh"];

	private _item = "GW_Item_StaticDummy";
	_unit setVariable [QGVAR(type), (typeOf _veh)];
	if (_unit canAdd _item) then {
		_unit additem _item;
	} else {
		private _pos = (getPosATL _veh);
		private _weaponHolder = "WeaponHolderSimulated" createVehicle _pos;
		_weaponHolder setPosATL _pos;
		_weaponHolder addItemCargoGlobal [_item, 1];
	};
	deleteVehicle _veh;

	true
}, {
	["Aborted", 3] call GW_Common_Fnc_Hint;
	false
}, _this] call CBA_fnc_progressBar;

true
*/