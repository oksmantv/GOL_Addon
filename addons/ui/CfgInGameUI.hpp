
class CfgInGameUI  {
/*
	class Actions {	// Move menu closer to crosshair
		x = "(profilenamespace getvariable [""IGUI_GRID_MENU_X"", (1.5 * (((safezoneW / safezoneH) min 1.2) / 40) + safezoneX)])";
	};
*/
	class CommandBar  {
		left = 0;
		top = 9999;
	};
	class Cursor {
		attack = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		customMark = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		getIn = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		iconComplex = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		leader = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		mission = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		move = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		outArrow = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		select = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		selected = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		tactical = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		unitUnconscious = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		watch = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	};

	class DefaultAction {
		size = 0;		// Hide crosshair text
	};

	class PeripheralVision {
		cueTexture = "A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
		cueColor[] = {0,0,0,0};
		cueEnemyColor[] = {0,0,0,0};
		cueFriendlyColor[] = {0,0,0,0};
	};
};
