#include "script_component.hpp"

LOG("postInit started");
diag_log format ["[GW][Core] postInit entered isServer=%1 hasInterface=%2", isServer, hasInterface];

if (isServer) then {
	LOG("Loading Server Variables");
	GVARMAIN(MACHINE) = "SERVER";
	diag_log format ["[GW][Core] server postInit switchableUnits count=%1 devBuild=%2", count switchableUnits, (call EFUNC(Common,isDevBuild))];

	if (call EFUNC(Common,isDevBuild)) then {
		LOG("devBuild started");
		{
			diag_log format ["[GW][Core] devBuild deleting switchable unit=%1", _x];
			deleteVehicle _x;
		} forEach switchableUnits;
	} else {
		{
			diag_log format ["[GW][Core] disabling AI on switchable unit=%1", _x];
			_x disableAI "All";
		} forEach (switchableUnits - [player]);;
	};

	// Local/hosted runs can hit postInit before switchableUnits is fully ready.
	[{
		private _isDev = call EFUNC(Common,isDevBuild);
		diag_log format ["[GW][Core] delayed switchable pass count=%1 devBuild=%2", count switchableUnits, _isDev];
		if (_isDev) then {
			{
				diag_log format ["[GW][Core] delayed devBuild deleting switchable unit=%1", _x];
				deleteVehicle _x;
			} forEach switchableUnits;
		} else {
			{
				diag_log format ["[GW][Core] delayed disabling AI on switchable unit=%1", _x];
				_x disableAI "All";
			} forEach (switchableUnits - [player]);;
		};
	}, [], 2] call CBA_fnc_waitAndExecute;
};

if (hasInterface) then {
	diag_log "[GW][Core] hasInterface branch entered";
	player setVariable [QGVARMAIN(isPlayer), true, true];
	player setVariable [QGVARMAIN(spawnLocation), (getPosASL player)];
	GVARMAIN(MACHINE) = str(player);
};

if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {
	#include "XEH_postInitEvents.sqf"
	false
};

if (hasInterface) then {
	LOG("Loading Player Variables");
	0 fadeRadio 0;
//	disableRemoteSensors true;	// PVP missions only
//	enableEngineArtillery false;
	enableEnvironment [false, true];
	enableRadio false;
	enableSentences false;
	enableStressDamage false;
	enableTeamSwitch false;
	player addRating 100000;
	player disableConversation true;
	player enableWeaponDisassembly false;
	player setVariable ["BIS_enableRandomization", false, true];
	player setVariable ["BIS_noCoreConversations", true, true];
	player triggerDynamicSimulation true;

	if ((getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "legacyRespawn")) isEqualTo 0) then {
		player addMPEventHandler ["MPRespawn", {
			params ["_unit", "_corpse"];
			[_unit] call EFUNC(Common,getRespawn);
		}];
	};

	setCompassOscillation [(rad 5), 0.1, 1];
	setCurrentChannel 1;
	useAISteeringComponent true;

	if (isNull(objectParent player)) then {
		player switchMove "AmovPknlMstpSlowWrflDnon";
	};

	["CBA_loadingScreenDone", {
		[] spawn {
			if (isMultiplayer && !(call EFUNC(Common,isDevBuild))) then {
				startLoadingScreen ["", "GW_loadingScreen"];

				_progress = 0;
				for "_i" from 1 to 1000 step 1 do {
					_progress = _progress + 0.001;
					progressLoadingScreen _progress;
					uisleep 0.005;
				};

				endLoadingScreen;
				cutText ["","BLACK IN",10];
			};
			[QGVARMAIN(loadingScreenDone), []] call CBA_fnc_localEvent;
		};
	}] call CBA_fnc_addEventHandler;
};

if (isServer) then {
	{
		_x call GW_Common_Fnc_loadSettingsFile;
	} forEach GVARMAIN(settingsLoad);
};

{
	// Support both legacy 2-element [name, file] and new 3-element [name, file, moduleRoot] entries.
	private _moduleRoot = if ((count _x) >= 3) then { _x select 2 } else { format ["Modules\%1\", _x select 0] };
	diag_log format ["[GW][Modules] PostInit executing: %1 -> %2%3", (_x select 0), _moduleRoot, (_x select 1)];
	
	[] call compile preprocessFileLineNumbers (_moduleRoot + (_x select 1));
	diag_log format ["[GW][Modules] PostInit complete: %1", (_x select 0)];
} forEach GVARMAIN(postLoad);
diag_log format ["[GW][Modules] PostInit count: %1", (count GVARMAIN(postLoad))];
GVARMAIN(postLoad) = nil;

#include "XEH_postInitEvents.sqf"


LOG("postInit finished");
