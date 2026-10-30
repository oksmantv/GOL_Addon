#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - Common Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Core"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

#include "CfgEventHandlers.hpp"

class RscStructuredText;
class RscTitles {
	class GW_ProtectionStatus {
		idd = -1;
		duration = 1e+011;
		fadeIn = 0;
		fadeOut = 0;
		onLoad = "uiNamespace setVariable ['GW_ProtectionStatus', _this select 0]";
		onUnload = "uiNamespace setVariable ['GW_ProtectionStatus', displayNull]";
		class controls {
			class Status: RscStructuredText {
				idc = 31001;
				style = 2;
				x = "safeZoneX + 0.02";
				y = "safeZoneY + 0.02";
				w = 0.30;
				h = 0.36;
				colorBackground[] = {0, 0, 0, 0};
				text = "";
			};
		};
	};
};

class GW_FRAMEWORK {
	class SpawnUnits {
		#include "CfgSpawnUnits.hpp"
	};
};

class CfgFunctions {
	class A3_Mark {
		class Vehicles {
			class getVehicleCustomization {
				file = QPATHTOF(functions\DOUBLES(fnc,getVehicleCustomization).sqf);
			};
		};
	};
	class TFAR {
		class Radio {
			class sessionTracker {
				file = QPATHTOF(functions\DOUBLES(fnc,empty).sqf);
			};
		};
	};
};