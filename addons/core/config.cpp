

/*
class cfgPatches {
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
*/

class cfgPatches {
	class GW_CORE {
		author = "GuzzenVonlidl";
		name = "GW - Core Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.78;
		requiredAddons[] = {
			"GW_Main",
			"A3_Functions_F",
			"A3_UI_F"
		};
		version = 1;
		authors[] = {"GuzzenVonlidl"};
	};
};

#include "CfgEventHandlers.hpp"
