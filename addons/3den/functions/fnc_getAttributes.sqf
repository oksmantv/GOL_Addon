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

_isMan = (_object isKindOf "CAManBase");
_isVehicle = ((_object isKindOf "AllVehicles") && !_isMan);


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

if (_isVehicle) then {
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

if !(GETATTRIBUTE("Health") isEqualTo 1) then {
	_array pushBack [13, GETATTRIBUTE("Health")];
};
if !(GETATTRIBUTE("fuel") isEqualTo 1) then {
	_array pushBack [14, GETATTRIBUTE("fuel")];
};
if !(GETATTRIBUTE("ammo") isEqualTo 1) then {
	_array pushBack [15, GETATTRIBUTE("ammo")];
};

if !(GETATTRIBUTE("Presence") isEqualTo 1) then {
	_array pushBack [16, GETATTRIBUTE("Presence")];
};
if !(GETATTRIBUTE("PresenceCondition") isEqualTo "true") then {
	_array pushBack [17, GETATTRIBUTE("PresenceCondition")];
};

if !(GETATTRIBUTE("DoorStates") isEqualTo [0,0,0]) then {
	_array pushBack [18, GETATTRIBUTE("DoorStates")];
};
if !(GETATTRIBUTE("objectIsSimple") isEqualTo false) then {
	_array pushBack [19, GETATTRIBUTE("objectIsSimple")];
};

//	GW - Addons

if (GETATTRIBUTEGROUP("GW_DisableHC")) then {
	_array pushBack [201, GETATTRIBUTEGROUP("GW_DisableHC")];
};
if (GETATTRIBUTEGROUP("GW_DisableGearInit")) then {
	_array pushBack [202, GETATTRIBUTEGROUP("GW_DisableGearInit")];
};
if !(GETATTRIBUTEGROUP("GW_LoadoutSelector") isEqualTo "") then {
	_array pushBack [203, GETATTRIBUTEGROUP("GW_LoadoutSelector")];
};







//	ACE

if (_isMan) then {
	if !(GETATTRIBUTE("ace_isMedic") isEqualTo -1) then {
		_array pushBack [301, GETATTRIBUTE("ace_isMedic")];
	};
	if !(GETATTRIBUTE("ace_isEngineer") isEqualTo 0) then {
		_array pushBack [302, GETATTRIBUTE("ace_isEngineer")];
	};
	if !(GETATTRIBUTE("ace_advanced_fatigue_performanceFactor") isEqualTo 1) then {
		_array pushBack [303, GETATTRIBUTE("ace_advanced_fatigue_performanceFactor")];
	};
	if !(GETATTRIBUTE("ace_isHandcuffed") isEqualTo false) then {
		_array pushBack [304, GETATTRIBUTE("ace_isHandcuffed")];
	};
	if !(GETATTRIBUTE("ace_isSurrendered") isEqualTo false) then {
		_array pushBack [305, GETATTRIBUTE("ace_isSurrendered")];
	};
} else {	// Starts from 320
	if ((_object isKindOf "ReammoBox_F") && !(GETATTRIBUTE("ace_cookoff_enableAmmoCookoff") isEqualTo true)) then {
		_array pushBack [320, GETATTRIBUTE("ace_cookoff_enableAmmoCookoff")];
	};

	_size = (if (isNumber (configFile >> "CfgVehicles" >> (typeOf _object) >> "ace_cargo_size")) then {getNumber (configFile >> 'CfgVehicles' >> (typeOf _object) >> "ace_cargo_size")} else {-1});
	if !(GETATTRIBUTE("ace_cargo_size") isEqualTo _size) then {
		_array pushBack [321, GETATTRIBUTE("ace_cargo_size")];
	};

	_space = (if (isNumber (configFile >> "CfgVehicles" >> (typeOf _object) >> "ace_cargo_space")) then {getNumber (configFile >> 'CfgVehicles' >> (typeOf _object) >> "ace_cargo_space")} else {0});
	if !(GETATTRIBUTE("ace_cargo_space") isEqualTo _space) then {
		_array pushBack [322, GETATTRIBUTE("ace_cargo_space")];
	};

	if !(GETATTRIBUTE("ace_isMedicalFacility") isEqualTo false) then {
		_array pushBack [323, GETATTRIBUTE("ace_isMedicalFacility")];
	};
	_repair = (if (isNumber (configFile >> "CfgVehicles" >> (typeOf _object) >> "ace_repair_canRepair")) then {getNumber (configFile >> 'CfgVehicles' >> (typeOf _object) >> "ace_repair_canRepair")} else {0});
	if !(GETATTRIBUTE("ace_isRepairFacility") isEqualTo _repair) then {
		_array pushBack [324, GETATTRIBUTE("ace_isRepairFacility")];
	};

	if !(GETATTRIBUTE("ace_repair_editorLoadedWheels") isEqualTo ([0,1] select (_object isKindOf 'Car'))) then {
		_array pushBack [325, GETATTRIBUTE("ace_repair_editorLoadedWheels")];
	};

	if !(GETATTRIBUTE("ace_repair_editorLoadedTracks") isEqualTo ([0,1] select (_object isKindOf 'Tank'))) then {
		_array pushBack [326, GETATTRIBUTE("ace_repair_editorLoadedTracks")];
	};

	if !(GETATTRIBUTE("ace_rearm_rearmCargo") isEqualTo -1) then {
		_array pushBack [327, GETATTRIBUTE("ace_rearm_rearmCargo")];
	};

	if !(GETATTRIBUTE("ace_refuel_fuelCargo") isEqualTo -1) then {
		_array pushBack [328, GETATTRIBUTE("ace_refuel_fuelCargo")];
	};

	if !(GETATTRIBUTE("ace_refuel_hooks") isEqualTo [0,0,0]) then {
		_array pushBack [329, GETATTRIBUTE("ace_refuel_hooks")];
	};

	if (_isVehicle) then {	// Starts from 350
		if !(GETATTRIBUTE("ace_cookoff_enable") isEqualTo ace_cookoff_enable) then {
			_array pushBack [350, GETATTRIBUTE("ace_cookoff_enable")];
		};

		if !(GETATTRIBUTE("ace_isMedicalVehicle") isEqualTo 0) then {
			_array pushBack [351, GETATTRIBUTE("ace_isMedicalVehicle")];
		};
		if !(GETATTRIBUTE("ace_isRepairVehicle") isEqualTo 0) then {
			_array pushBack [352, GETATTRIBUTE("ace_isRepairVehicle")];
		};
	};
};


/*
if (_isGroupType) then {
	if !(GETATTRIBUTEGROUP("speedMode") isEqualTo 1) then {
		_array pushBack [16, (["LIMITED","NORMAL","FULL"] select GETATTRIBUTEGROUP("speedMode"))];
	};
};

*/

_array
