
class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

class Extended_PostInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};

class Extended_DisplayLoad_EventHandlers {
	class RscDisplayInterrupt {
		ADDON = "['GW_pauseMenuOpened', _this] call CBA_fnc_localEvent;";
	};
	class RscDisplayMPInterrupt {
		ADDON = "['GW_pauseMenuOpened', _this] call CBA_fnc_localEvent;";
	};
	class RscDisplayEGSpectator {
		ADDON = "['GW_SpectatorOpened', _this] call CBA_fnc_localEvent;";
	};
};

class Extended_DisplayUnload_EventHandlers {
	class RscDisplayInterrupt {
		ADDON = "['GW_pauseMenuClosed', _this] call CBA_fnc_localEvent;";
	};
	class RscDisplayMPInterrupt {
		ADDON = "['GW_pauseMenuClosed', _this] call CBA_fnc_localEvent;";
	};
	class RscDisplayEGSpectator {
		ADDON = "['GW_SpectatorClosed', _this] call CBA_fnc_localEvent;";
	};
};
