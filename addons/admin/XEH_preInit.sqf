#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#include "XEH_PREP.sqf"

GVARMAIN(isAdmin) = false;
GVARMAIN(isSuperAdmin) = false;
GVARMAIN(isActiveAdmin) = false;
GVARMAIN(activeAdmins) = [];
GVARMAIN(adminList) = ["_SP_PLAYER_", GUZZENVONLIDL, ARROW, OKSMAN, BLU, MALLEY, THEC, HOOFED];
GVARMAIN(superAdminList) = ["_SP_PLAYER_", GUZZENVONLIDL, OKSMAN, BLU];
GVARMAIN(adminCurators) = [];

GVARMAIN(canUseDevConsole) = false;

if (isNil QEGVAR(Gear,GearboxActive)) then {
	EGVAR(Gear,GearboxActive) = true;
};
