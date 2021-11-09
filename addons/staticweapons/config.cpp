#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - StaticWeapons Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {"GW_Item_StaticDummy"};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

#include "CfgEventHandlers.hpp"
//#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
