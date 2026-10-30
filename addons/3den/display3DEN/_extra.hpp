
class MENU(DebugConsole) {
	text = "External Debug Console";
	items[] = {
		MENU_SUB(DebugConsole,Clear),
		MENU_SUB(DebugConsole,Exit)
	};
};

class MENU_SUB(DebugConsole,Clear) {
	action = "'debug_console' callExtension ('C')";
	Text = "Clear Console History...";
};

class MENU_SUB(DebugConsole,Exit) {
	action = "'debug_console' callExtension ('X')";
	Text = "Shutdown Console...";
};

class MENU(ClearChat) {
	action = "clearRadio";
	Text = "Clear ChatLog... (SystemChat)";
};

class MENU(ClearServerSettings) {
	action = "['server'] call CBA_settings_fnc_clear";
	Text = "Clear Addons Options... (Server)";
};

class MENU(RefreshPlayerGearPreview) {
	action = "[true] call GW_3den_fnc_refreshPlayerGearPreview";
	Text = "Refresh Map Unit Gear Preview";
};

class MENU_SUB(Extra,Help) {	// Help
	text = "Help...";
	action = "[4] call GW_3DEN_fnc_showMessage;";
};
