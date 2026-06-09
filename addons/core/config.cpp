
class CfgPatches {
	class GW_Core {
		name = "GW - Core Component";
		author = "GuzzenVonlidl";
		url = "https://github.com/OksmanTV/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[]={
			"GW_Main",
			"A3_Functions_F",
			"A3_UI_F"
		};
		version=VERSION;
		authors[]={
			"GuzzenVonlidl",
			"Blu.",
			"OksmanTV"
		};
	};
};

#include "script_component.hpp"
#include "CfgEventHandlers.hpp"

// Functions that must be available before preInit (e.g. Description.ext param functions).
class CfgFunctions {
	class GW {
		class Core {
			class paramDaytime {
				file = QPATHTOF(functions\DOUBLES(fnc,paramDaytime).sqf);
			};
		};
	};
};
