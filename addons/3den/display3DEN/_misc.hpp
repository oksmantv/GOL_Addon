
class MENU_SUB(Misc,addUnitToProjectileTracker) {
	action = QUOTE(2 call FUNC(doAction));
	Text = "Unit Projectile Tracker...";
};

class MENU_SUB(Misc,exportMissingAuthors) {
	action = QUOTE(2 call FUNC(doActionMisc));
	Text = "Export Missing Authors... (Clipboard)";
};

class MENU_SUB(Misc,exportWeapons) {
	action = QUOTE(3 call FUNC(doActionMisc));
	Text = "Export Weapons and Magazines... (Clipboard)";
};

class MENU_SUB(Misc,Utilities) {
	text = "Utilities";
	items[] = {
		MENU_SUB(Utilities,utility_moonPhases),
		MENU_SUB(Utilities,utility_jukebox),
		MENU_SUB(Utilities,utility_printConfig),
		MENU_SUB(Utilities,utility_cfgDisabledCommands)
	};
};

class MENU_SUB(Utilities,utility_moonPhases) {
	action = "[] execVM 'A3\Functions_F\Debug\Utilities\utility_moonPhases.sqf'";
	Text = "Moon Phases...";
};

class MENU_SUB(Utilities,utility_jukebox) {
	action = "[] execVM 'A3\Functions_F\Debug\Utilities\utility_jukebox.sqf'";
	Text = "JukeBox...";
};

class MENU_SUB(Utilities,utility_printConfig) {
	action = "[] execVM 'A3\Functions_F\Debug\Utilities\utility_printConfig.sqf'";
	Text = "Print Config...";
};

class MENU_SUB(Utilities,utility_cfgDisabledCommands) {
	action = "[] execVM 'A3\Functions_F\Debug\Utilities\utility_cfgDisabledCommands.sqf'";
	Text = "CfgDisabledCommands...";
};

// Help

class MENU_SUB(Misc,Help) {
	text = "Help...";
	action = "[3] call GW_3DEN_fnc_showMessage;";
};
