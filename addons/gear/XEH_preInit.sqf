#include "script_component.hpp"

#include "initSettings.sqf"

diag_log "[GW_Gear] XEH_preInit started";

private _hasGWMain = isClass (configFile >> "CfgPatches" >> "GW_Main");
private _hasGWCore = isClass (configFile >> "CfgPatches" >> "GW_Core");
private _hasGWCommon = isClass (configFile >> "CfgPatches" >> "GW_Common");
diag_log format ["[GW_Gear] dependency check GW_Main=%1 GW_Core=%2 GW_Common=%3", _hasGWMain, _hasGWCore, _hasGWCommon];

// Only register addon functions for new-style missions.
// Legacy missions (faction files at the old root path) manage their own functions entirely.
if (isClass (missionConfigFile >> "gw_Modules" >> "Gear")) then {
	diag_log "[GW_Gear] New-style mission detected: running Gear\XEH_PREP.sqf";
	#include "XEH_PREP.sqf"

	private _useLocalDefault = missionNamespace getVariable ["GW_Gear_UseLocalDefault", false];
	private _useLocalDefaultAI = missionNamespace getVariable ["GW_Gear_UseLocalDefaultAI", false];

	if (isNil "GW_Gear_fnc_DefaultCode") then {
		private _defaultCodePath = if (_useLocalDefault && fileExists "Gear\Functions\fnc_DefaultCode_Local.sqf") then {
			"Gear\Functions\fnc_DefaultCode_Local.sqf"
		} else {
			"\x\gw\addons\gear\functions\fnc_DefaultCode.sqf"
		};

		diag_log format ["[GW_Gear] fallback compile DefaultCode from %1", _defaultCodePath];
		GW_Gear_fnc_DefaultCode = compile preProcessFileLineNumbers _defaultCodePath;
	};

	if (isNil "GW_Gear_fnc_DefaultAICode") then {
		private _defaultAICodePath = if (_useLocalDefaultAI && fileExists "Gear\Functions\fnc_DefaultAICode_Local.sqf") then {
			"Gear\Functions\fnc_DefaultAICode_Local.sqf"
		} else {
			"\x\gw\addons\gear\functions\fnc_DefaultAICode.sqf"
		};

		diag_log format ["[GW_Gear] fallback compile DefaultAICode from %1", _defaultAICodePath];
		GW_Gear_fnc_DefaultAICode = compile preProcessFileLineNumbers _defaultAICodePath;
	};
} else {
	diag_log "[GW_Gear] Legacy mission detected: skipping Gear\XEH_PREP.sqf";
};

