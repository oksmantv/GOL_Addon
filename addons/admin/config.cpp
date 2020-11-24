#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - Admin Component";
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

class CfgAddons {
	class PreloadAddons {
		class ADDON {
			list[] = {ADDON};
		};
	};
};

class CfgFunctions {
	class A3 {
		class Debug {
			class isDebugConsoleAllowed {
				file = QPATHTOF(functions\DOUBLES(fnc,isDebugConsoleAllowed).sqf);
			};
		};
		class MP {
			class admin {
				file = QPATHTOF(functions\DOUBLES(fnc,admin).sqf);
			};
		};
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgGUI.hpp"

cba_settings_whitelist[] += {ADMINLIST};
enableDebugConsole[] += {ADMINLIST};
