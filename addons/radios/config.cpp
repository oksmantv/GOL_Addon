#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonLidl";
		name = "GW - Radios Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Core",
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonLidl"};
	};
};

#include "CfgEventHandlers.hpp"
