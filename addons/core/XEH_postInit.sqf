#include "script_component.hpp"

LOG("postInit started");

if (isServer) then {
	LOG("Loading Server Variables");
	GVARMAIN(MACHINE) = "SERVER";

	if (call EFUNC(Common,isDevBuild)) then {
		LOG("devBuild started");
		{
			deleteVehicle _x;
		} forEach switchableUnits;
	} else {
		{
			_x disableAI "All";
		} forEach switchableUnits;
	};
};

if (hasInterface) then {
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

if (VERSION >= 0.8) then {
	{
		[] call compile preprocessFileLineNumbers ("Modules\" + (_x select 0) +"\" + (_x select 1));
		LOG(FORMAT_1("Module postInit: %1", (_x select 0)));
	} forEach GVARMAIN(postLoad);
	LOG(FORMAT_1("Modules: %1", (count GVARMAIN(postLoad))));
	GVARMAIN(postLoad) = nil;

	#include "XEH_postInitEvents.sqf"
};


LOG("postInit finished");
