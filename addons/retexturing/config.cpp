#include "script_component.hpp"

/*
	Textures sourced from:
	R3F Uniforms		http://www.armaholic.com/page.php?id=24727
	CAF Mod				http://www.armaholic.com/page.php?id=19420
*/

class CfgPatches {
	class ADDON {
		author = "GuzzenVonLidl";
		name = "GW - Retexturing Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonLidl"};
	};
};

#include "CfgVehicles.cpp"
