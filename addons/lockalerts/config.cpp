#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "Blu";
		name = "GW - Lock Sounds Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl", "Blu"};
	};
};

#include "CfgVehicles.cpp"