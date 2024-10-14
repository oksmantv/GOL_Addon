#include "script_component.hpp"
#include "CfgEventHandlers.hpp"

class CfgPatches {
	class ADDON {
		name = "GW - Core Component";
		author = "GuzzenVonlidl";
		url = "https://github.com/GuzzenVonLidl/";
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