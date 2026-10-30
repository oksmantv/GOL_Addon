#include "script_component.hpp"

diag_log "[GW][SetDifficulty] XEH_postInit started";

// Cache the optional lobby parameter. -1 preserves the configured CBA settings.
GVAR(missionSkillOverride) = -1;
{
	if (configName _x isEqualTo "GOL_AISkillOverride") exitWith {
		GVAR(missionSkillOverride) = paramsArray select _forEachIndex;
	};
} forEach (configProperties [missionConfigFile >> "Params", "isClass _x", true]);

[QGVARMAIN(serverReady), {
	["CAManBase", "init", {
		_this call FUNC(init);
	}, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(playerReady), {
	_this call FUNC(setDetectionCoef);

	["CAManBase", "Respawn", {
		[{
			_this call FUNC(setDetectionCoef);
		}, _this, 0.5] call CBA_fnc_waitAndExecute;
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	ace_medical_playerDamageThreshold = 1;
	if (true) then {
		GVAR(damageResistanceDefault) = ace_medical_playerDamageThreshold;
		if (GVAR(damageResistance)) then {
			["CAManBase", "GetInMan", {
				params ["_unit","_seatType","_veh","_index"];

				if (isPlayer _unit) then {
					ace_medical_playerDamageThreshold = (ace_medical_playerDamageThreshold * 1.5);
				};
			}, true, [], true] call CBA_fnc_addClassEventHandler;

			["CAManBase", "GetOutMan", {
				params ["_unit","_seatType","_veh","_index"];

				if (isPlayer _unit) then {
					ace_medical_playerDamageThreshold = GVAR(damageResistanceDefault);
				};
			}, true, [], true] call CBA_fnc_addClassEventHandler;
		};
	};
}] call CBA_fnc_addEventHandler;

diag_log "[GW][SetDifficulty] XEH_postInit finished";
