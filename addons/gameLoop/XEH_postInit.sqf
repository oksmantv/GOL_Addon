#include "script_Component.hpp"

private _safeModeUseType = missionNamespace getVariable [QGVAR(SafeMode_useType), -999];
private _safeModeTimer = missionNamespace getVariable [QGVAR(SafeMode_Timer), -999];
private _safeModeBlockVeh = missionNamespace getVariable [QGVAR(SafeMode_blockVeh), false];
diag_log format ["[GW][SafeMode] XEH_postInit loaded useType=%1 timer=%2 blockVeh=%3", _safeModeUseType, _safeModeTimer, _safeModeBlockVeh];

if (isServer) then {
	[QGVARMAIN(missionStarted), {
		GVAR(SafeMode_Enabled) = GVAR(SafeMode_useType) > 0;
		[QGVAR(setSafetyMode), [GVAR(SafeMode_Enabled), true]] call CBA_fnc_globalEvent;
		diag_log format ["[GW][SafeMode] missionStarted -> enabled=%1 useType=%2", GVAR(SafeMode_Enabled), GVAR(SafeMode_useType)];
	}] call CBA_fnc_addEventHandler;

	// Restore legacy Safe Start coverage for AI and vehicle weapons. Player weapons
	// are handled locally by WeaponLock; this server-side class handler suppresses
	// projectiles fired by server-owned AI, including Zeus-spawned artillery.
	["AllVehicles", "Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
		if !(GVAR(SafeMode_Enabled) && {!isNull _projectile}) exitWith {};
		// Player weapons are removed by their local WeaponLock handler.
		if (isPlayer _unit || {isPlayer (effectiveCommander _unit)}) exitWith {};
		if (GVARMAIN(mod_ACE3)) then {
			[_projectile] call ACE_FRAG_Fnc_addBlackList;
		};
		deleteVehicle _projectile;
	}, true, [], true] call CBA_fnc_addClassEventHandler;
};

[QGVARMAIN(serverReady), {
	diag_log format ["[GW][SafeMode] serverReady useType=%1 enabled=%2", GVAR(SafeMode_useType), GVAR(SafeMode_Enabled)];
	if (GVAR(SafeMode_useType) > 0) then {
		[] spawn {
			_count = -1;
			while {GVAR(SafeMode_Enabled)} do {
				_count = _count + 1;
				_time = _count;
				if (GVAR(SafeMode_useType) isEqualTo 1) then {
					_time = (GVAR(SafeMode_Timer) - _count);

					if (GVAR(SafeMode_Timer) <= _count) then {
						diag_log format ["[GW][SafeMode] countdown reached end at count=%1", _count];
						[QGVAR(setSafetyMode), [false, false]] call CBA_fnc_globalEvent;
					};
				};
				[QGVAR(SafeMode_CountDown), [([_time, (_time + 1)] select (GVAR(SafeMode_useType) isEqualTo 2))]] call CBA_fnc_globalEvent;

				sleep 60;
			};

			_count = 0;
			while {!GVAR(SafeMode_Enabled)} do {	// Game Timer - End on debriefing
				_count = (_count + 1);
				[QGVAR(MissionTime), [_count, ((GVAR(event) * 60) * _count)]] call CBA_fnc_serverEvent;
				sleep (60 * GVAR(event));
			};
		};
	};

	if (GVAR(civiKillTracker)) then {
		["CAManBase", "Killed", {
			params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
			if (getNumber(configfile >> "CfgVehicles" >> (typeOf _unit) >> "side") isEqualTo 3) then {
				GVAR(CiviKillCount) = GVAR(CiviKillCount) + 1;
				[QGVAR(CiviKillEvent), [GVAR(CiviKillCount), _killer], ([] call CBA_fnc_players)] call CBA_fnc_TargetEvent;
			};
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(loadingScreenDone), {
	GVAR(IntroLoadingScreenDone) = true;
	diag_log "[GW][Intro] loading-screen transition ready";
	[] call FUNC(startIntro);
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(playerReady), {
	diag_log format ["[GW][SafeMode] playerReady useType=%1 enabled=%2", GVAR(SafeMode_useType), GVAR(SafeMode_Enabled)];
	// The server owns SafeMode_Enabled. Request its current value so clients do not
	// unlock themselves when playerReady fires before publicVariable propagation.
	[QGVAR(requestSafetyMode), [player]] call CBA_fnc_serverEvent;

	private _showLocalIntro = getMissionConfigValue ["GW_ShowIntroInSingleplayer", false];
	if (isMultiplayer || _showLocalIntro) then {
		GVAR(IntroPlayerReady) = true;
		diag_log "[GW][Intro] player ready";
		[] call FUNC(startIntro);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(SafeMode_CountDown), {
	if (hasInterface) then {
		params["_number"];
		TRACE_1("QGVAR(SafeMode_CountDown)", _number);
		if (_number <= -1) then {
			systemChat "[SafeMode]: Weapons & Vehicles are now active";
		} else {
			if (GVAR(SafeMode_useType) isEqualTo 1) then {
				systemChat format ["[SafeMode]: Weapons are cold, Time Remaining until mission starts: %1 min", _number];
			} else {
				systemChat format ["[SafeMode]: Weapons are cold, Waiting for admin to start. (%1 minutes since map screen)", _number];
			};
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(requestSafetyMode), {
	params [["_unit", objNull, [objNull]]];
	if (isServer && {!isNull _unit}) then {
		[QGVAR(setSafetyMode), [GVAR(SafeMode_Enabled), GVAR(SafeMode_StartAreaExpiry)], _unit] call CBA_fnc_targetEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(cancelSafetyMode), {
	params [["_unit", objNull, [objNull]]];
	if (isServer && {GVAR(SafeMode_Enabled)} && {GVAR(SafeMode_StartAreaExpiry)} && {!isNull _unit}) then {
		diag_log format ["[GW][SafeMode] cancelled after %1 left the starting area", name _unit];
		[QGVAR(setSafetyMode), [false, false]] call CBA_fnc_globalEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(setSafetyMode), {
	params [["_enabled", false, [true]], ["_startAreaExpiry", false, [true]]];
	diag_log format ["[GW][SafeMode] setSafetyMode enabled=%1 startAreaExpiry=%2 isServer=%3 hasInterface=%4", _enabled, _startAreaExpiry, isServer, hasInterface];
	GVAR(SafeMode_Enabled) = _enabled;
	GVAR(SafeMode_StartAreaExpiry) = _startAreaExpiry;
	if (isServer) then {
		publicVariable QGVAR(SafeMode_Enabled);
		publicVariable QGVAR(SafeMode_StartAreaExpiry);
		// Framework 3+ Safe Start still owns its own projectile-deletion handler.
		// Release it when GW SafeMode releases so old mission templates unlock too.
		if (!_enabled) then {
			["StartUp_setSafetyMode", false] call CBA_fnc_globalEvent;
		};
	};
	if (hasInterface) then {
		TRACE_1("QGVAR(setSafetyMode)", _enabled);
		[] call GW_Common_fnc_protectionStatusHint;
		if (_enabled) then {
			[true, false] call FUNC(WeaponLock);

			if (_startAreaExpiry && {!GVAR(SafeMode_ReleaseMonitorActive)}) then {
				private _spawnPosition = getPosATL (vehicle player);
				private _releaseGeneration = GVAR(SafeMode_ReleaseGeneration);
				GVAR(SafeMode_ReleaseMonitorActive) = true;

				[_spawnPosition, _releaseGeneration] spawn {
					params ["_spawnPosition", "_releaseGeneration"];
					private _releaseDistance = 50;

					waitUntil {
						sleep 0.25;
						!(GVAR(SafeMode_Enabled))
						|| {GVAR(SafeMode_ReleaseGeneration) isNotEqualTo _releaseGeneration}
						|| {(vehicle player) distance2D _spawnPosition >= _releaseDistance}
					};

					if (
						GVAR(SafeMode_Enabled)
						&& {GVAR(SafeMode_ReleaseGeneration) isEqualTo _releaseGeneration}
						&& {(vehicle player) distance2D _spawnPosition >= _releaseDistance}
					) then {
						[QGVAR(cancelSafetyMode), [player]] call CBA_fnc_serverEvent;
					};

					if (GVAR(SafeMode_ReleaseGeneration) isEqualTo _releaseGeneration) then {
						GVAR(SafeMode_ReleaseMonitorActive) = false;
					};
				};
			};
		} else {
			GVAR(SafeMode_ReleaseGeneration) = GVAR(SafeMode_ReleaseGeneration) + 1;
			GVAR(SafeMode_ReleaseMonitorActive) = false;
			[false, false] call FUNC(WeaponLock);
		};

		if (!_enabled && (GVAR(SafeMode_useType) isEqualTo 2)) then {
			systemChat "[SafeMode]: Weapons & Vehicles are now active";
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(CiviKillEvent), {
	params ["_count","_killer"];
	systemChat format ["Civilian Killed by %1, Be Careful %2 Civi(s) has been killed in this mission", (name _killer), _count];
}] call CBA_fnc_addEventHandler;

#ifdef DEBUG_MODE_FULL
	[QEGVAR(gameLoop,MissionTime), {
		params ["_count","_time"];
		systemChat format ["MissionTime: %1", _this];
	}] call CBA_fnc_addEventHandler;
#endif
