
class MENU_SUB(Copy,Group) {
	text = "Group with waypoints...";
	action = "[true] call GW_3DEN_fnc_getCorrectVersion;";
	shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_1};
};

class MENU_SUB(Copy,OnlyMen) {
	text = "Static Units...";
	action = "[false, 1] call GW_3DEN_fnc_getCorrectVersion;";
	shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_2};
};

class MENU_SUB(Copy,AllObjects) {
	text = "Objects...";
	action = "[false, 2] call GW_3DEN_fnc_getCorrectVersion;";
	shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_3};
};

class MENU_SUB(Copy,Loadout) {
	text = "Loadout... (Experimenatal)";
	action = "[] call GW_3DEN_fnc_copyLoadout";
	shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_4};
};

class MENU_SUB(Copy,prefabMHQ) {
	text = "Copy MHQ Prefab...";
	action = QUOTE(1 call FUNC(doAction));
};

class MENU_SUB(Copy,relativeObjects) {
	text = "Copy Location Relative From Object...";
	action = QUOTE(0 call FUNC(doAction));
};

class MENU_SUB(Copy,Export) {
	text = "Export Composition to Configs...";
	action = "[] call GW_3DEN_fnc_createComposition;";
};
