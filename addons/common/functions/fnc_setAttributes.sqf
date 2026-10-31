#include "script_Component.hpp"

if !(_this isEqualType []) exitWith {
	WARNING(FORMAT_1("setAttributes: expected parameter array, received %1; attributes skipped", typeName _this));
	false
};

params [
	["_object", objNull],
	["_specials", []]
];

if !(_object isEqualType objNull) exitWith {
	WARNING(FORMAT_1("setAttributes: expected OBJECT, received %1; attributes skipped", typeName _object));
	false
};

if !(_specials isEqualType []) exitWith {
	WARNING(FORMAT_1("setAttributes: expected _specials to be an ARRAY of [selector, value] pairs, received %1; attributes skipped", typeName _specials));
	false
};

// Eden attribute expressions only run for sqm-placed units, so for runtime-spawned units we run the
// Enhanced Eden mod's own expression (looked up from Cfg3DEN). Expression sees _this = object and _value.
private _runEnhAttribute = {
	params ["_target", "_class", "_attrValue"];
	[_target, _class, _attrValue] call FUNC(applyEnhAttribute);
};

{
	if !(_x isEqualType [] && {count _x >= 2}) then {
		WARNING(FORMAT_2("setAttributes: special at index %1 must be a [selector, value] pair, received %2; entry skipped", _forEachIndex, typeName _x));
	} else {
		_x params ["_switch", "_value"];
		switch (_switch) do {
		case 0: {
			[] call (compile (format ["%1", (toString(toArray(format ["%1", [_value, "this", "_object"] call CBA_fnc_replace])))]));
		};
		case 1: {
			_object allowDamage _value;
		};
		case 2: {
			if (_object isKindOf "CAManBase") then {
				[_object,_value] spawn {
					(_this select 0) enableSimulationGlobal (_this select 1);
				};
			} else {
				_object enableSimulationGlobal _value;
			};
		};
		case 3: {
			_object lock _value;
		};
		case 4: {	// addToDynSimGrid
			_object triggerDynamicSimulation _value;
		};
		case 5: {	// dynamicSimulation
			_object enableDynamicSimulation _value;
		};
		case 6: {	// Vehicle Texture
			[_object, _value, nil] call bis_fnc_initVehicle;
		};
		case 7: {	// Vehicle Animation
			[_object, nil, _value] call bis_fnc_initVehicle;
		};
		case 8: {	// Pylons
			if !(_value isEqualType []) then {
				WARNING(FORMAT_1("setAttributes: pylon loadout must be an ARRAY, received %1; entry skipped", typeName _value));
			} else {
				private _getPylons = [_object] call EFUNC(Common,getPylonsAvailable);
				{
					if (_forEachIndex < count _getPylons) then {
						_object setPylonLoadOut [_getPylons select _forEachIndex, _x];
					} else {
						WARNING(FORMAT_1("setAttributes: pylon loadout contains more entries than the object has pylons; extra entry at index %1 skipped", _forEachIndex));
					};
				} forEach _value;
			};
		};
		case 9: {
			_object setVehicleReportRemoteTargets _value;
		};
		case 10: {
			_object setVehicleReceiveRemoteTargets  _value;
		};
		case 11: {
			_object setVehicleReportOwnPosition _value;
		};
		case 12: {
			_object setVehicleRadar _value;
		};
		case 13: {
			if (_value isEqualType true) then {
				// Legacy map compatibility (old selector 13)
				(group _object) setVariable ["GW_DisableHC", _value, true];
			} else {
				_object setDamage (1 - (_value max 0 min 1));
			};
		};
		case 14: {
			if (_value isEqualType true) then {
				// Legacy map compatibility (old selector 14)
				_object setVariable ["GW_DisableGearInit", _value, true];
				_object setVariable ["GW_Gear_BlackList", _value, true];
			} else {
				_object setFuel (_value max 0 min 1);
			};
		};
		case 15: {
			if (_value isEqualType "") then {
				// Legacy map compatibility (old selector 15)
				_object setVariable ["GW_LoadoutSelector", _value, true];
				_object setVariable ["GW_Gear_Loadout", _value, true];
			} else {
				_object setVehicleAmmo (_value max 0 min 1);
			};
		};
		case 16: {
			// Presence is editor-time spawn probability; not applied at runtime.
		};
		case 17: {
			// PresenceCondition is editor-time logic; not applied at runtime.
		};
		case 18: {
			// DoorStates has no generic runtime setter across object types.
		};
		case 19: {
			// objectIsSimple is editor-only and cannot be toggled post-spawn.
		};
		case 201: {
			(group _object) setVariable ["GW_DisableHC", _value, true];
		};
		case 202: {
			private _disableGear = false;
			if (_value isEqualType true) then {
				_disableGear = _value;
			} else {
				if (_value isEqualType 0) then {
					_disableGear = (_value > 0);
				};
			};
			_object setVariable ["GW_DisableGearInit", _disableGear, true];
			_object setVariable ["GW_Gear_BlackList", _disableGear, true];
		};
		case 203: {
			_object setVariable ["GW_LoadoutSelector", _value, true];
			_object setVariable ["GW_Gear_Loadout", _value, true];
		};
		case 204: {
			if ((_object isKindOf "CAManBase") && (_value isEqualType [])) then {
				_object setVariable ["GW_Gear_BlackList", true, true];
				_object setUnitLoadout _value;
			};
		};
		case 301: {
			_object setVariable ["ace_isMedic", _value, true];
		};
		case 302: {
			_object setVariable ["ace_isEngineer", _value, true];
		};
		case 303: {
			_object setVariable ["ace_advanced_fatigue_performanceFactor", _value, true];
		};
		case 304: {
			_object setVariable ["ace_isHandcuffed", _value, true];
		};
		case 305: {
			_object setVariable ["ace_isSurrendered", _value, true];
		};
		case 320: {
			_object setVariable ["ace_cookoff_enableAmmoCookoff", _value, true];
		};
		case 321: {
			_object setVariable ["ace_cargo_size", _value, true];
		};
		case 322: {
			_object setVariable ["ace_cargo_space", _value, true];
		};
		case 323: {
			_object setVariable ["ace_isMedicalFacility", _value, true];
		};
		case 324: {
			_object setVariable ["ace_isRepairFacility", _value, true];
		};
		case 325: {
			_object setVariable ["ace_repair_editorLoadedWheels", _value, true];
		};
		case 326: {
			_object setVariable ["ace_repair_editorLoadedTracks", _value, true];
		};
		case 327: {
			_object setVariable ["ace_rearm_rearmCargo", _value, true];
		};
		case 328: {
			_object setVariable ["ace_refuel_fuelCargo", _value, true];
		};
		case 329: {
			_object setVariable ["ace_refuel_hooks", _value, true];
		};
		case 350: {
			_object setVariable ["ace_cookoff_enable", _value, true];
		};
		case 351: {
			_object setVariable ["ace_isMedicalVehicle", _value, true];
		};
		case 352: {
			_object setVariable ["ace_isRepairVehicle", _value, true];
		};
		case 401: {	// Enhanced Eden: Make Hostage (class ENH_MakeHostage, property ENH_makeHostage)
			[_object, "ENH_MakeHostage", _value] call _runEnhAttribute;
		};
		case 402: {	// Enhanced Eden: Ambient Animations, value [animSet, anims, canExit, attach]
			if (_value isEqualType [] && {count _value >= 4}) then {
				[_object, "ENH_AmbientAnimations", _value] call _runEnhAttribute;
			};
		};
		};
	};
} forEach _specials;
