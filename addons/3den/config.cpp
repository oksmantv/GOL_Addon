#include "script_component.hpp"
//#include "\a3\3DEN\UI\dikCodes.inc"
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - 3DEN Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common",
			"A3_Modules_F",
			"A3_Data_F",
			"A3_Misc_F",
			"A3_Plants_F_Bush",
			"A3_Roads_F",
			"A3_Rocks_F",
			"A3_Signs_F",
			"A3_Soft_F",
			"A3_Structures_F",
			"A3_Structures_F_Households",
			"A3_Structures_F_Ind",
			"A3_Structures_F_Mil",
			"A3_Structures_F_Wrecks"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

class ctrlButtonPictureKeepAspect;
class ctrlButtonToolbar;
class ctrlCheckbox;
class ctrlCheckboxToolbar;
class ctrlCombo;
class ctrlControlsGroupNoScrollbars;
class ctrlDefault;
class ctrlDefaultText;
class ctrlEdit;
class ctrlListBox;
class ctrlListNBox;
class ctrlMenu;
class ctrlMenuStrip;
class ctrlShortcutButton;
class ctrlSliderH;
class ctrlSliderV;
class ctrlStatic;
class ctrlStaticPicture;
class ctrlToolbox;
class ctrlToolboxPicture;
class ctrlTree;
class RscButtonMenu;
class RscControlsGroup;
class RscHTML;
class RscPicture;
class RscStructuredText;
class RscText;
class Separator1;

class RscCombo;
class RscEdit;

class CfgEditorSubcategories {
	class EdSubcat_GW_Bushes {
		displayName = "Bushes";
	};
	class EdSubcat_GW_clutter {
		displayName = "Clutter";
	};
	class EdSubcat_GW_Plants {
		displayName = "Plants";
	};
	class EdSubcat_GW_Trees {
		displayName="Trees";
	};
	class EdSubcat_GW_Trees_tanoa {
		displayName="Trees Tanoa";
	};
	class EdSubcat_GW_Road {
		displayName="Road Segments";
	};
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgGroups.hpp"
#include "CfgVehicles.hpp"
#include "display3DEN.hpp"

class ace_arsenal_display {
	class controls {
		class GW_Export : RscButtonMenu {
			x ="0.445 * safezoneW + safezoneX";
			y = "0.92 * safezoneH + safezoneY";
			w = "0.115 * safezoneW";
			h ="0.03 * safezoneH";
			text = "Export GW Loadout";
			action = "[] call GW_3den_fnc_copyLoadout";
		};
	};
};

class RscDisplayArsenal {
	class controls {
		class GW_Export : RscButtonMenu {
			x ="0.445 * safezoneW + safezoneX";
			y = "0.92 * safezoneH + safezoneY";
			w = "0.115 * safezoneW";
			h ="0.03 * safezoneH";
			text = "Export GW Loadout";
			action = "[] call GW_3den_fnc_copyLoadout";
		};
	};
};

class RscDisplayConfigViewer {
	class controls {
		class ConfigViewer_export: RscButtonMenu {
			idc=7301;
			text = "Export";
			x="32.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y="safezoneY + safezoneH - 2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w="11.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h="1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onButtonClick = "[] call GW_3den_fnc_configViewerExport;";
			tooltip = "Copy the content of the current config to the clipboard";
		};
	};
};
