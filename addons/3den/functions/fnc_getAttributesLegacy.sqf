#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_getAttribute

	Parameters:

	Return Value: None

	Public: NO
*/
#define	GETATTRIBUTE(Var) ((_object get3DENAttribute Var) select 0)
#define	GETATTRIBUTEGROUP(Var) (((group _object) get3DENAttribute Var) select 0)

params ["_object", ["_isGroupType", false]];
private _array = [];

if !(GETATTRIBUTE("init") isEqualTo "") then {
	_array pushBack [0, GETATTRIBUTE("init")];
};
if !(GETATTRIBUTE("allowDamage")) then {
	_array pushBack [1, GETATTRIBUTE("allowDamage")];
};
if !(GETATTRIBUTE("enableSimulation")) then {
	_array pushBack [2, GETATTRIBUTE("enableSimulation")];
};
if !(GETATTRIBUTE("lock") isEqualTo 1) then {
	_array pushBack [3, GETATTRIBUTE("lock")];
};
if !(GETATTRIBUTE("addToDynSimGrid")) then {
	_array pushBack [4, GETATTRIBUTE("addToDynSimGrid")];
};
if (GETATTRIBUTE("dynamicSimulation")) then {
	_array pushBack [5, GETATTRIBUTE("dynamicSimulation")];
};

if ((_object isKindOf "AllVehicles") && !(_object isKindOf "CAManBase")) then {	// Vehicles only
	([_object] call bis_fnc_getVehicleCustomization) params ["_texture","_animations"];
	if !((_texture isEqualTo "") || (_texture isEqualTo [])) then {
		_array pushBack [6, _texture];
	};
	if !(_animations isEqualTo []) then {
		_array pushBack [7, _animations];
	};
	if !(GETATTRIBUTE("pylons") isEqualTo "") then {
		_loadout = ([GETATTRIBUTE("pylons"), ";", true] call BIS_fnc_splitString);
		_array pushBack [8, _loadout];
	};
	if ((count (listVehicleSensors _object)) isEqualTo 0) then {
		if (GETATTRIBUTE("reportRemoteTargets") isEqualTo 0) then {
			_array pushBack [9, GETATTRIBUTE("reportRemoteTargets")];
		};
		if (GETATTRIBUTE("receiveRemoteTargets") isEqualTo 0) then {
			_array pushBack [10, GETATTRIBUTE("receiveRemoteTargets")];
		};
		if (GETATTRIBUTE("reportOwnPosition") isEqualTo 0) then {
			_array pushBack [11, GETATTRIBUTE("reportOwnPosition")];
		};
		if !(GETATTRIBUTE("RadarUsageAI") isEqualTo 0) then {
			_array pushBack [12, GETATTRIBUTE("RadarUsageAI")];
		};
	};
};

if (GETATTRIBUTEGROUP("GW_DisableHC")) then {
	_array pushBack [13, GETATTRIBUTEGROUP("GW_DisableHC")];
};
if (GETATTRIBUTEGROUP("GW_DisableGearInit")) then {
	_array pushBack [14, GETATTRIBUTEGROUP("GW_DisableGearInit")];
};
if !(GETATTRIBUTEGROUP("GW_LoadoutSelector") isEqualTo "") then {
	_array pushBack [15, GETATTRIBUTEGROUP("GW_LoadoutSelector")];
};

if !(GETATTRIBUTE("Health") isEqualTo 1) then {
	_array pushBack [16, GETATTRIBUTE("Health")];
};
if !(GETATTRIBUTE("fuel") isEqualTo 1) then {
	_array pushBack [17, GETATTRIBUTE("fuel")];
};
if !(GETATTRIBUTE("ammo") isEqualTo 1) then {
	_array pushBack [18, GETATTRIBUTE("ammo")];
};

/*
if (_isGroupType) then {
	if !(GETATTRIBUTEGROUP("speedMode") isEqualTo 1) then {
		_array pushBack [16, (["LIMITED","NORMAL","FULL"] select GETATTRIBUTEGROUP("speedMode"))];
	};
};

*/

_array
