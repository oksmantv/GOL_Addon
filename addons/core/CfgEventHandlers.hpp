class Extended_PreStart_EventHandlers {
	class GW_Core_XEH_PreStart {
		init = QUOTE(diag_log '[GW][CoreEH] preStart dispatch'; call COMPILE_FILE(XEH_preStart));
	};
};

class Extended_PreInit_EventHandlers {
	class GW_Core_XEH_PreInit {
		init = QUOTE(diag_log '[GW][CoreEH] preInit dispatch'; call COMPILE_FILE(XEH_preInit); diag_log '[GW][CoreEH] preInit after call');
	};
};

class Extended_PostInit_EventHandlers {
	class GW_Core_XEH_PostInit {
		init = QUOTE(diag_log '[GW][CoreEH] postInit dispatch'; call COMPILE_FILE(XEH_postInit));
	};
};

class Extended_DisplayLoad_EventHandlers {
	class RscDisplayLoading {
		GW_customLoadingScreen = QUOTE(call COMPILE_FILE(initLoadingScreen));
	};
};
