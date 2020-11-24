#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#include "XEH_PREP.sqf"

GVARMAIN(isAdmin) = false;
GVARMAIN(isSuperAdmin) = false;
GVARMAIN(isActiveAdmin) = false;
GVARMAIN(activeAdmins) = [];
GVARMAIN(adminList) = ["_SP_PLAYER_", GUZZENVONLIDL, ARROW, OKSMAN, R4IDER, FILTHY, PARKER, JASON];
GVARMAIN(superAdminList) = ["_SP_PLAYER_", GUZZENVONLIDL, ARROW];
GVARMAIN(adminCurators) = [];

GVARMAIN(canUseDevConsole) = false;

if (isNil QEGVAR(Gear,GearboxActive)) then {
	EGVAR(Gear,GearboxActive) = true;
};
