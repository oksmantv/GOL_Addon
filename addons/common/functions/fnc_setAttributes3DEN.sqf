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

private _hasACE = isClass (configFile >> "CfgPatches" >> "ace_main");

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
			if (_value isEqualType true) then {
				// Legacy map compatibility (old selector 13)
				_object set3DENAttribute ["GW_DisableHC", _value];
			} else {
				_object set3DENAttribute ["Health", _value];
			};
		};
		case 14: {
			if (_value isEqualType true) then {
				// Legacy map compatibility (old selector 14)
				_object set3DENAttribute ["GW_DisableGearInit", _value];
				_object setVariable ["GW_Gear_BlackList", _value, false];
			} else {
				_object set3DENAttribute ["fuel", _value];
			};
		};
		case 15: {
			if (_value isEqualType "") then {
				// Legacy map compatibility (old selector 15)
				_object set3DENAttribute ["GW_LoadoutSelector", _value];
				_object setVariable ["GW_Gear_Loadout", _value, false];
			} else {
				_object set3DENAttribute ["ammo", _value];
			};
		};
		case 16: {
			_object set3DENAttribute ["Presence", _value];
		};
		case 17: {
			_object set3DENAttribute ["PresenceCondition", _value];
		};
		case 18: {
			_object set3DENAttribute ["DoorStates", _value];
		};
		case 19: {
			_object set3DENAttribute ["objectIsSimple", _value];
		};
		case 201: {
			_object set3DENAttribute ["GW_DisableHC", _value];
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
			_object set3DENAttribute ["GW_DisableGearInit", _disableGear];
			_object setVariable ["GW_DisableGearInit", _disableGear, false];
			_object setVariable ["GW_Gear_BlackList", _disableGear, false];
		};
		case 203: {
			_object set3DENAttribute ["GW_LoadoutSelector", _value];
			_object setVariable ["GW_Gear_Loadout", _value, false];
		};
		case 204: {
			if ((_object isKindOf "CAManBase") && (_value isEqualType [])) then {
				_object setVariable ["GW_Gear_BlackList", true, false];
				_object setUnitLoadout _value;
			};
		};
		case 301: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isMedic", _value];
			};
		};
		case 302: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isEngineer", _value];
			};
		};
		case 303: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_advanced_fatigue_performanceFactor", _value];
			};
		};
		case 304: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isHandcuffed", _value];
			};
		};
		case 305: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isSurrendered", _value];
			};
		};
		case 320: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_cookoff_enableAmmoCookoff", _value];
			};
		};
		case 321: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_cargo_size", _value];
			};
		};
		case 322: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_cargo_space", _value];
			};
		};
		case 323: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isMedicalFacility", _value];
			};
		};
		case 324: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isRepairFacility", _value];
			};
		};
		case 325: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_repair_editorLoadedWheels", _value];
			};
		};
		case 326: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_repair_editorLoadedTracks", _value];
			};
		};
		case 327: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_rearm_rearmCargo", _value];
			};
		};
		case 328: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_refuel_fuelCargo", _value];
			};
		};
		case 329: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_refuel_hooks", _value];
			};
		};
		case 350: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_cookoff_enable", _value];
			};
		};
		case 351: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isMedicalVehicle", _value];
			};
		};
		case 352: {
			if (_hasACE) then {
				_object set3DENAttribute ["ace_isRepairVehicle", _value];
			};
		};
		case 401: {	// Enhanced Eden: Make Hostage
			_object set3DENAttribute ["ENH_makeHostage", _value];
		};
		case 402: {	// Enhanced Eden: Ambient Animations, value [animSet, anims, canExit, attach]
			// Eden silently ignores script-written arrays with 4+ elements for ENH_AmbientAnimations (tested), so it cannot be written
			// directly. Store the value in a GW string attribute that re-applies the Enhanced expression at mission start.
			if (_value isEqualType [] && {count _value >= 4}) then {
				_object set3DENAttribute ["GW_AmbientAnimations", str (_value select [0, 4])];
			};

			// Enhanced only plays the editor preview animation on mission load / attribute dialog save, so do it here as well.
			if (_value isEqualType [] && {count _value >= 2} && {(_value select 1) isEqualType []} && {!((_value select 1) isEqualTo [])}) then {
				private _anim = selectRandom (_value select 1);
				_object switchMove _anim;
				// Re-apply once shortly after, in case the freshly created unit resets its pose.
				[_object, _anim] spawn {
					params ["_unit", "_anim"];
					uiSleep 0.5;
					if (!isNull _unit) then {
						_unit switchMove _anim;
					};
				};
			};
		};
		};
	};
} forEach _specials;
