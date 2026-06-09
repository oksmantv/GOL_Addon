#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonLidl";
		name = "GW - MHQ Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Core",
			"GW_Common",
			"GW_Gear"
		};
		version = VERSION;
		authors[] = {"GuzzenVonLidl"};
	};
};

#include "CfgEventHandlers.hpp"
