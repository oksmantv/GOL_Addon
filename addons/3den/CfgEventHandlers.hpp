
class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

class Extended_DisplayLoad_EventHandlers {
	class Display3DEN {
		ADDON = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};
