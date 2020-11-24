
class MENU_SUB(set3DENAttributes,unitStance) {	// Stance
	items[] = {
		MENU_SUB(set3DENAttributes,unitStance_up),
		MENU_SUB(set3DENAttributes,unitStance_middle),
		MENU_SUB(set3DENAttributes,unitStance_down),
		MENU_SUB(set3DENAttributes,unitStance_auto)
	};
	text = "Unit Stance";
};
class MENU_SUB(set3DENAttributes,unitStance_up) {
	text = "Up";
	action = "[5, 0] call GW_3DEN_fnc_setAttribute;";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_1};
	picture = "\a3\3den\Data\Attributes\Stance\up_ca.paa";
};
class MENU_SUB(set3DENAttributes,unitStance_middle) {
	text = "Middle";
	action = "[5, 1] call GW_3DEN_fnc_setAttribute;";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_2};
	picture = "\a3\3den\Data\Attributes\Stance\middle_ca.paa";
};
class MENU_SUB(set3DENAttributes,unitStance_down) {
	text = "Down";
	action = "[5, 2] call GW_3DEN_fnc_setAttribute;";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_3};
	picture = "\a3\3den\Data\Attributes\Stance\down_ca.paa";
};
class MENU_SUB(set3DENAttributes,unitStance_auto) {
	text = "Auto";
	action = "[5, 3] call GW_3DEN_fnc_setAttribute;";
	shortcuts[] = {INPUT_CTRL_OFFSET + DIK_4};
};

class MENU_SUB(set3DENAttributes,simpleObject) {	// Simple
	items[] = {
		MENU_SUB(set3DENAttributes,simpleObject_true),
		MENU_SUB(set3DENAttributes,simpleObject_false)
	};
	text = "CreateSimpleObject";
};
class MENU_SUB(set3DENAttributes,simpleObject_true) {
	text = "True";
	action = "[4, True] call GW_3DEN_fnc_setAttribute;";
};
class MENU_SUB(set3DENAttributes,simpleObject_false) {
	text = "False";
	action = "[4, false] call GW_3DEN_fnc_setAttribute;";
};

class MENU_SUB(set3DENAttributes,enableSimulation) {	// Simulation
	items[] = {
		MENU_SUB(set3DENAttributes,enableSimulation_true),
		MENU_SUB(set3DENAttributes,enableSimulation_false)
	};
	text = "EnableSimulation";
};
class MENU_SUB(set3DENAttributes,enableSimulation_true) {
	text = "True";
	action = "[1, true] call GW_3DEN_fnc_setAttribute;";
};
class MENU_SUB(set3DENAttributes,enableSimulation_false) {
	text = "False";
	action = "[1, false] call GW_3DEN_fnc_setAttribute;";
};

class MENU_SUB(set3DENAttributes,dynamicSim) {	// Simulation
	items[] = {
		MENU_SUB(set3DENAttributes,dynamicSim_true),
		MENU_SUB(set3DENAttributes,dynamicSim_false)
	};
	text = "Dynamic Simulation";
};
class MENU_SUB(set3DENAttributes,dynamicSim_true) {
	text = "True";
	action = "[6, true] call GW_3DEN_fnc_setAttribute;";
};
class MENU_SUB(set3DENAttributes,dynamicSim_false) {
	text = "False";
	action = "[6, false] call GW_3DEN_fnc_setAttribute;";
};

class MENU_SUB(set3DENAttributes,allowDamage) {	// Damage
	items[] = {
		MENU_SUB(set3DENAttributes,allowDamage_true),
		MENU_SUB(set3DENAttributes,allowDamage_false)
	};
	text = "AllowDamage";
};
class MENU_SUB(set3DENAttributes,allowDamage_true) {
	text = "True";
	action = "[2, true] call GW_3DEN_fnc_setAttribute;";
};
class MENU_SUB(set3DENAttributes,allowDamage_false) {
	text = "False";
	action = "[2, false] call GW_3DEN_fnc_setAttribute;";
};


class MENU_SUB(set3DENAttributes,Help) {	// Help
	text = "Help...";
	action = "[2] call GW_3DEN_fnc_showMessage;";
};
