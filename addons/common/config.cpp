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