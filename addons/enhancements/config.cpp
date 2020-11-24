#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - Enhancements Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {
			"150Rnd_762x51_Box_Tracer_Red",
			"150Rnd_762x51_Box_Tracer_Yellow",
			"150Rnd_762x54_Box_Tracer_Red",
			"150Rnd_762x54_Box_Tracer_Yellow",
			"GW_X3000",
			"GVL_X2000_point",
			"GVL_X2000_wide"
		};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common",
			"A3_Weapons_F",
			"A3_Weapons_F_Beta",
			"A3_Weapons_F_Exp",
			"A3_Weapons_F_Mark",
			"A3_Weapons_F_Machineguns_Zafir",
			"A3_Weapons_F_Mark_Machineguns_Zafir",
			"A3_Weapons_F_Rifles_Khaybar"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

class asdg_SlotInfo;
class asdg_FrontSideRail: asdg_SlotInfo {
	class compatibleItems {
		GW_X3000 = 1;
		GVL_X2000_wide = 1;
		GVL_X2000_point = 1;
	};
};

#include "CfgAmmo.hpp"
#include "CfgCloudlets.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgLights.hpp"
#include "CfgMagazines.hpp"
#include "CfgMovesMaleSdr.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"

class CfgSounds {
	class GW_enhancements_Attachment {
		name = "Toggle_Attachment";
		sound[] = {QPATHTOF(data\switch_mod_04.wss),1,1,25};
		titles[] = {};
	};
};
class CfgAnimation {
	ladderSpeed="0.5*2";
};

/*
class CfgWhistleSound {
	sound[] = {QPATHTOF(data\wheesper1.wav),5,1};
	downTime = 0.2;
	silentTime = 3;
	upTime = 4;
};
*/
