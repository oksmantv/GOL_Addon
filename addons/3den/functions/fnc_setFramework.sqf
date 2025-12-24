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
		// Get Framework version and update overviewText
		_frameworkVersion = getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version");
		_overviewText = format["Framework Version %1", _frameworkVersion];
			
		// Extract mission name from briefingName (removes "COOP@36 " prefix)
		_fullName = getText(missionConfigFile >> "briefingName");
		_nameParts = _fullName splitString " ";
		_nameParts deleteAt 0; // Remove "COOP@36" part
		_missionName = _nameParts joinString " ";
		
		set3DENMissionAttributes [
				["Scenario", "Author", getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Author")],
				["Scenario", "IntelBriefingName", _missionName],
				["Scenario", "OverviewText", _overviewText],
				["Scenario", "OverviewPicture", "\OKS_GOL_Misc\data\images\loadImage.jpg"],
				["Scenario", "OverviewPictureLocked", "\OKS_GOL_Misc\data\images\loadImage.jpg"],
				["Scenario", "OnLoadMission", ""],
				["Scenario", "LoadScreen", "\OKS_GOL_Misc\data\images\loadImage.jpg"],
				["Multiplayer", "IntelOverviewText", _overviewText]
			];

			if ((getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "isPVPMode")) isEqualTo 0) then {
				"Multiplayer" set3DENMissionAttribute ["GameType", "COOP"];
			} else {
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
		
		// Import CBA settings automatically
		[] spawn GW_3DEN_fnc_importCBASettings;
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
