#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author[] = {"GuzzenVonLidl"};
		name = "GW - Main Component";
		authorUrl = "https://github.com/GuzzenVonLidl/";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"A3_Functions_F",
			"CBA_Main"
		};
		versionDesc = "GW Mod Collection";
		VERSION_CONFIG;
		authors[] = {"GuzzenVonLidl"};
	};
};

class CfgAddons {
	class PreloadAddons {
		class ADDON {
			list[] = {ADDON};
		};
	};
};

rptFileLimit = 3;
#include "CfgDifficultyPresets.hpp"
//#include "CfgDLCNotifications.hpp"
//	#include "CfgMissions.hpp"
#include "CfgMods.hpp"

class GW_Modules_Base {
	name = "GW Modules Base";
	Authors[] = {};
	version = 1;
	description = "Dummy for each module";
	preInit = "preInit.sqf";
	postInit = "postInit.sqf";
	requiredModules[] = {};
	requiredAddons[] = {};
};
