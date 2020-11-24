#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - Performance Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

class GW_Modules_Base;
class GW_Modules: GW_Modules_Base {
	class COMPONENT {
		name = COMPONENT;
		Authors[] = {"GuzzenVonLidl"};
		version = 1.2;
		description = "Cleans up the mission for performance";
	};
};

#include "CfgEventHandlers.hpp"
