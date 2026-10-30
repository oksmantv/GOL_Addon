#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonLidl";
		name = "GW - Callsigns Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Core",
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonLidl", "Blu"};
	};
};

#include "CfgEventHandlers.hpp"

class RscButton;
class RscCombo;
class RscEdit;
class RscPicture;
class RscText;

class CfgRscTitles {
	#include "CfgRscTitles.hpp"
};
