
class RscButtonMenu;
class GW_MainMenu_Admin_base: RscButtonMenu {
	action="(findDisplay 49) closeDisplay 0; ['player', [], 100, ['(call GW_Admin_fnc_flexi_InteractSelf)','main']] call cba_fnc_fleximenu_openMenuByDef;";
	text="Admin Menu";
	tooltip="Admin Menu";
	x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
	y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safezoneY";
	w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	idc = 256101;
};

class RscStandardDisplay;
class RscDisplayInterrupt: RscStandardDisplay {
	class controls {
		class GW_MainMenu_Admin: GW_MainMenu_Admin_base {};
	};
};

class RscDisplayMPInterrupt: RscStandardDisplay {
	class controls {
		class GW_MainMenu_Admin: GW_MainMenu_Admin_base {};
	};
};
