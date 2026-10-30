#include "script_Component.hpp"

if !(_this isEqualType []) exitWith {
	WARNING(FORMAT_1("setAttributes3DEN: expected parameter array, received %1; attributes skipped", typeName _this));
	false
};

params [
	["_object", objNull],
	["_specials", []]
];

if !(_object isEqualType objNull) exitWith {
	WARNING(FORMAT_1("setAttributes3DEN: expected OBJECT, received %1; attributes skipped", typeName _object));
	false
};

if !(_specials isEqualType []) exitWith {
	WARNING(FORMAT_1("setAttributes3DEN: expected _specials to be an ARRAY of [selector, value] pairs, received %1; attributes skipped", typeName _specials));
	false
};

{
	if !(_x isEqualType [] && {count _x >= 2}) then {
		WARNING(FORMAT_2("setAttributes3DEN: special at index %1 must be a [selector, value] pair, received %2; entry skipped", _forEachIndex, typeName _x));
	} else {
		_x params ["_switch", "_value"];
		switch (_switch) do {
		case 0: {
			_object set3DENAttribute ["init", _value];
		};
		case 1: {
			_object set3DENAttribute ["allowDamage", _value];
		};
		case 2: {
			_object set3DENAttribute ["enableSimulation", _value];
		};
		case 3: {
			_object set3DENAttribute ["lock", _value];
		};
		case 4: {	// addToDynSimGrid
			_object set3DENAttribute ["dynamicSimulation", _value];
		};
		case 5: {	// dynamicSimulation
		};
		case 6: {	// Vehicle Texture
			[_object, _value, nil] call bis_fnc_initVehicle;
		};
		case 7: {	// Vehicle Animation
			[_object, nil, _value] call bis_fnc_initVehicle;
		};
		case 8: {	// Pylons
			if !(_value isEqualType []) then {
				WARNING(FORMAT_1("setAttributes3DEN: pylon loadout must be an ARRAY, received %1; entry skipped", typeName _value));
			} else {
				private _getPylons = [_object] call EFUNC(Common,getPylonsAvailable);
				{
					if (_forEachIndex < count _getPylons) then {
						_object setPylonLoadOut [_getPylons select _forEachIndex, _x];
					} else {
						WARNING(FORMAT_1("setAttributes3DEN: pylon loadout contains more entries than the object has pylons; extra entry at index %1 skipped", _forEachIndex));
					};
				} forEach _value;
			};
		};
		case 9: {
			_object set3DENAttribute ["ReportRemoteTargets", _value];
		};
		case 10: {
			_object set3DENAttribute ["ReceiveRemoteTargets", _value];
		};
		case 11: {
			_object set3DENAttribute ["ReportOwnPosition", _value];
		};
		case 12: {
			_object set3DENAttribute ["RadarUsageAI", _value];
		};
		case 13: {
			_object set3DENAttribute ["GW_DisableHC", _value];
		};
		case 14: {
			_object set3DENAttribute ["GW_DisableGearInit", _value];
		};
		case 15: {
			_object set3DENAttribute ["GW_LoadoutSelector", _value];
		};
		};
	};
} forEach _specials;
