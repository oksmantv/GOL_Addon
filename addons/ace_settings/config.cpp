#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - ACE Settings";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

#include "CfgEventHandlers.hpp"

class ACE_Medical_Actions {
	class Basic {
		class Bandage;
		class CPR: Bandage {
			callbackSuccess = QUOTE(FUNC(treatmentAdvanced_CPR));
		};
	};
	class Advanced {
		class fieldDressing;
		class CPR: fieldDressing {
			callbackSuccess = QUOTE(FUNC(treatmentAdvanced_CPR));
		};
	};
};

class ACE_Repair {
	class Actions {
		class MiscRepair {
			items[] = {};
			itemConsumed = 0;
		};
		class FullRepair {
			itemConsumed = 0;
		};
	};
};

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Sandbag_place {
                condition = QUOTE(_this call FUNC(canDeploy));
            };
        };
    };
};
