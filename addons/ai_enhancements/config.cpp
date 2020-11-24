#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - AI_Enhancements Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		addonRootClass = "A3_Weapons_F";
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common",
			"A3_Data_F",
			"A3_Characters_F",
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
/*
class CfgAddons {
	class PreloadAddons {
		class ADDON {
			list[] = {ADDON};
		};
	};
};
*/

class close;
class fullauto_medium;
class manual;
class medium;
class short;
class single;

class Mode_SemiAuto {
	RIFLE_SINGLE
};
class Mode_Burst: Mode_SemiAuto {
	RIFLE_BURST
};
class Mode_FullAuto: Mode_SemiAuto {
	RIFLE_FULL
};

#include "CfgAISkill.hpp"
#include "CfgAmmo.hpp"
#include "CfgBrains.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"

class CfgSurfaces {
	class Default {
		AIAvoidStance = 1; // less likely prone
	};
};
