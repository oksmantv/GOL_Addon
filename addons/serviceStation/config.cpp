#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - serviceStation Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl","Neko-Arrow"};
		description = "NeKo-Arrow's ServiceStation | Date: 25/10/19";
	};
};

class GW_Modules_Base;
class GW_Modules: GW_Modules_Base {
	class COMPONENT {
		name = COMPONENT;
		Authors[] = {"NeKo-Arrow","GuzzenVonLidl"};
		version = 3;
		description = "NeKo-Arrow's ServiceStation | Date: 25/10/19";
		postInit = "";
	};
};

#include "CfgEventHandlers.hpp"
