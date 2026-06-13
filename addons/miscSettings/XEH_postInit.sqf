#include "script_component.hpp"

diag_log "[GW][MiscSettings] XEH_postInit started";

if (isClass(configFile >> "CfgPatches" >> "GW_menu")) then {
	EGVAR(menu,viewDistance_Enabled) = true;	// Toggle Change ViewDistance with GOL Menu
	EGVAR(menu,viewDistance_Default) = 1000;	// Anything above 0 overwrites the personal default ViewDistance that is on mission start
	EGVAR(menu,viewObjectDistance_Default) = 0;	// Anything above 0 overwrites the personal default objectViewDistance that is on mission start
	EGVAR(menu,viewDistance_Max) = 10000;		// Set Max ViewDistance Allowed
	EGVAR(menu,Grass_Enabled) = true;			// Enable Change Grass
	EGVAR(menu,Grass_allowDisable) = true;		// Enable Ability to disable grass fully
};

/*
	[
		"Custom Actions",
		"","","",
		[QUOTE(call FUNC(customMenu_Example)),"exampleMenu", 1],
		-1,true,
		true
	] call FUNC(addToFlexiMenu);
*/

if (isClass(configFile >> "CfgPatches" >> "GW_StaticWeapons")) then {
//	EGVAR(StaticWeapons,BlackList) pushBackUnique "CUP_WV_CIWS_staticweapon_base";
};

if (isClass(configFile >> "CfgPatches" >> "STUI_Core")) then {
	STHud_NoSquadBarMode = false;		// Default: false
	STHud_ShowBearingInVehicle = true;	// Default: true
	STUI_Occlusion = true;				// Default: true
	STUI_RemoveDeadViaProximity = true; // Default: true
};

if (true) then {
	RHS_HEAT_ENABLED = false;
	RHS_SPALL_ENABLED = false;
	RHS_ENGINE_STARTUP_OFF = 1;	// turn off RHS engine startup script
};

diag_log "[GW][MiscSettings] XEH_postInit finished";
