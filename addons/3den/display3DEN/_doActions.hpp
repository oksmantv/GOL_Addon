
class MENU_SUB(doActions,GarrisonBuildings) {
	action = QUOTE(5 call FUNC(doAction));
	Text = "Garrison Selected units...";
	picture = "\a3\3den\Data\CfgWaypoints\guard_ca.paa";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_5};
};

class MENU_SUB(doActions,createWaypoints) {
	action = "call GW_3den_fnc_createWaypoints";
	Text = "Generate waypoints around group...";
	picture = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_6};
};

class MENU_SUB(doActions,ToggleTerrain) {
	text = "Hide Terrain Objects...";
	action = QUOTE(4 call FUNC(doAction));
};

class MENU_SUB(doActions,pattern_Line) {
	action = QUOTE('LINE' call FUNC(setObjectPattern));
	Text = "Line pattern...";
};

class MENU_SUB(doActions,pattern_Circular) {
	action = QUOTE('CIRCULAR' call FUNC(setObjectPattern));
	Text = "Circular pattern...";
};

class MENU_SUB(doActions,pattern_offset) {
	text = "Pattern Offset";
	items[] = {
		MENU_SUB(doActions_pattern_offset,offset_1),
		MENU_SUB(doActions_pattern_offset,offset_2),
		MENU_SUB(doActions_pattern_offset,offset_3),
		MENU_SUB(doActions_pattern_offset,offset_4),
		MENU_SUB(doActions_pattern_offset,offset_5),
		MENU_SUB(doActions_pattern_offset,offset_10),
		MENU_SUB(doActions_pattern_offset,offset_15),
		MENU_SUB(doActions_pattern_offset,offset_20),
		MENU_SUB(doActions_pattern_offset,offset_25),
		MENU_SUB(doActions_pattern_offset,offset_50)
	};
};

class MENU_SUB(doActions_pattern_offset,offset_1) {
	action = "[3, 1] call GW_3DEN_fnc_doAction;";
	Text = "1 M";
};
class MENU_SUB(doActions_pattern_offset,offset_2) {
	action = "[3, 2] call GW_3DEN_fnc_doAction;";
	Text = "2 M";
};
class MENU_SUB(doActions_pattern_offset,offset_3) {
	action = "[3, 3] call GW_3DEN_fnc_doAction;";
	Text = "3 M";
};
class MENU_SUB(doActions_pattern_offset,offset_4) {
	action = "[3, 4] call GW_3DEN_fnc_doAction;";
	Text = "4 M";
};
class MENU_SUB(doActions_pattern_offset,offset_5) {
	action = "[3, 5] call GW_3DEN_fnc_doAction;";
	Text = "5 M";
};
class MENU_SUB(doActions_pattern_offset,offset_10) {
	action = "[3, 10] call GW_3DEN_fnc_doAction;";
	Text = "10 M";
};
class MENU_SUB(doActions_pattern_offset,offset_15) {
	action = "[3, 15] call GW_3DEN_fnc_doAction;";
	Text = "15 M";
};
class MENU_SUB(doActions_pattern_offset,offset_20) {
	action = "[3, 20] call GW_3DEN_fnc_doAction;";
	Text = "20 M";
};
class MENU_SUB(doActions_pattern_offset,offset_25) {
	action = "[3, 25] call GW_3DEN_fnc_doAction;";
	Text = "25 M";
};
class MENU_SUB(doActions_pattern_offset,offset_50) {
	action = "[3, 50] call GW_3DEN_fnc_doAction;";
	Text = "50 M";
};

class MENU_SUB(doActions,Help) {	// Help
	text = "Help...";
	action = "[1] call GW_3DEN_fnc_showMessage;";
};
