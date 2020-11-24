#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Resets Settings Menu

	Usage:
	[] call GW_Common_Fnc_setFramework;

	Arguments: NO

	Return Value: NO

	Public: NO

*/

collect3DENHistory {
	if !("GW_MissionPreferences" get3DENMissionAttribute "GW_isConfigured") then {
		if (isClass(missionConfigFile >> "GW_FRAMEWORK")) then {
			set3DENMissionAttributes [
				["Scenario", "Author", getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Author")],
				["Scenario", "IntelBriefingName", getText(missionConfigFile >> "briefingName")],
				["Scenario", "OnLoadMission", ""],
				["Scenario", "LoadScreen", ""]
			];

			if ((getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "isPVPMode")) isEqualTo 0) then {
				"Multiplayer" set3DENMissionAttribute ["GameType", "COOP"];
			} else {
	//			"Multiplayer" set3DENMissionAttribute ["GameType", "Unknown"];
				"Multiplayer" set3DENMissionAttribute ["GameType", "Sandbox"];
			};
		};

		_allPlayers = {((_x get3DENAttribute "ControlMP") select 0) || ((_x get3DENAttribute "ControlSP") select 0)} count ((all3DENEntities select 0) + (all3DENEntities select 3));

		set3DENMissionAttributes [
			["GarbageCollection", "DynSimEnabled", false],
			["General", "SaveBinarized", false],
			["Multiplayer", "AIKills", false],
			["Multiplayer", "DisabledAI", true],
			["Multiplayer", "EnableTeamSwitch", false],
			["Multiplayer", "JoinUnassigned", true],
//			["Multiplayer", "MaxPlayers", 129],	// Framework count including headless + spectator
			["Multiplayer", "MaxPlayers", _allPlayers],
			["Multiplayer", "MinPlayers", 1],
			["Multiplayer", "Respawn", 3],
			["Multiplayer", "RespawnDelay", 120],
			["Multiplayer", "RespawnDialog", false],
			["Multiplayer", "RespawnTemplates", ["Counter","Wave"]],
			["Scenario", "Saving", false]
		];

		LOG("Settings Configured");

		"GW_MissionPreferences" set3DENMissionAttribute ["GW_isConfigured", true];
		LOG("fnc_addEH_onMessage: GW_isConfigured");
	};

	if (GVARMAIN(mod_ACE3) && !("GW_MissionPreferences" get3DENMissionAttribute "GW_isConfigured_ACE")) then {
		disableUserInput true;
		[] spawn {
			((findDisplay 313) call CBA_settings_fnc_openSettingsMenu);
			[(preprocessFile "x\gw\addons\ACE_Settings\Settings\cba_settings.sqf"), "mission"] call CBA_settings_fnc_import;
			[(preprocessFile "x\gw\addons\ACE_Settings\Settings\medical_Legacy.sqf"), "mission"] call CBA_settings_fnc_import;
			if (EGVAR(settings_ACE,medical_level) isEqualTo 2) then {
				[(preprocessFile "x\gw\addons\ACE_Settings\Settings\medical_Legacy_adv.sqf"), "mission"] call CBA_settings_fnc_import;
			};
			[] call CBA_settings_fnc_gui_saveTempData;
			(uiNamespace getVariable "RscDisplayGameOptions") closeDisplay 1;
			"GW_MissionPreferences" set3DENMissionAttribute ["GW_isConfigured_ACE", true];
			uisleep 0.5;
			disableUserInput false;
			uisleep 1;
			if (userInputDisabled) then {
				disableUserInput false;
			};
		};
	};

	if (isclass (configfile >> "CfgPatches" >> "3denEnhanced")) then {
		set3DENMissionAttributes[["Multiplayer", "Enh_DynamicGroups", false]];
		set3DENMissionAttributes[["Multiplayer", "Enh_SaveLoadout", false]];
	};
};

	/*
		if !(([getText(configFile >> "CfgPatches" >> "ACE_main" >> "version"), 0, 3] call BIS_fnc_trimString) isEqualTo "3.11") then {	// No CBA Settings
			[] call GW_ACE_Settings_fnc_setConfigs;
		};
	*/
