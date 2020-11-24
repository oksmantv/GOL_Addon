
[QGVAR(BlockAIGear), "CHECKBOX", ["Blocks access to ai Inventories", "Stops players from being able to scavenge dead AI"], [QUOTE(ADDON), "#0 General"], true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;

[
	QGVAR(disableThermals), "LIST",
	["Disable Thermals", "Auto disables TI Equipment for vehicles"],
	["GW_Common", "#0 General"],
	[[0,1,2], ["Disabled","All Vehicles","Only Ground"], 0], CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[QGVAR(radioDistnace), "SLIDER", ["Radio Distance", "Multiplier for radio distance, default is 1"], [QUOTE(ADDON), "#0 General"], [0.5, 4.0, 1.9, 1], CBA_SERVEROVERWRITE, {
	GVAR(radioDistnace) = (parseNumber (_this toFixed 1));
}] call cba_settings_fnc_init;

[QGVAR(slingloadEnabled), "CHECKBOX", ["Slingload Fix", "This is a dirty attemt to try to make slingloading less buggy"], [QUOTE(ADDON), "#0 General"], true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;

/*
[
	QGVAR(relationsBlufor), "LIST",
	["West friendly to", "Set side relations for X side"],
	["GW_Common", "Side Relations "],
	[[0,1,2,3], ["None","Opfor","Independent","Both"], 2], CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call CBA_settings_fnc_init;

[
	QGVAR(relationsOpfor), "LIST",
	["Opfor friendly to", "Set side relations for X side"],
	["GW_Common", "Side Relations "],
	[[0,1,2,3], ["None","Blufor","Independent","Both"], 2], CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call CBA_settings_fnc_init;

[
	QGVAR(relationsIndependent), "LIST",
	["Independent friendly to", "Set side relations for X side"],
	["GW_Common", "Side Relations "],
	[[0,1,2,3], ["None","Blufor","Opfor","Both"], 3], CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call CBA_settings_fnc_init;
*/
