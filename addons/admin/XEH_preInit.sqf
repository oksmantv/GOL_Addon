#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#include "XEH_PREP.sqf"

GVARMAIN(isAdmin) = false;
GVARMAIN(isSuperAdmin) = false;
GVARMAIN(isActiveAdmin) = false;
GVARMAIN(activeAdmins) = [];
GVARMAIN(adminList) = ["_SP_PLAYER_", ADMINLIST];
GVARMAIN(superAdminList) = ["_SP_PLAYER_", GUZZENVONLIDL, OKSMAN, BLU];
GVARMAIN(adminCurators) = [];

GVARMAIN(canUseDevConsole) = false;

if (isNil QEGVAR(Gear,GearboxActive)) then {
	EGVAR(Gear,GearboxActive) = true;
};

// Add multiple curators at mission start to prevent lag if other people needs access
if (isServer && isMultiplayer) then {
	private _LogicCenter = createCenter sideLogic;
	private _moduleGroup = createGroup _LogicCenter;

	for "_i" from 1 to 2 step 1 do {
		_curtor = _moduleGroup createUnit ["ModuleCurator_F",[0,0,1000],[],0,"CAN_COLLIDE"];
		_curtor setVariable ["Owner", "", true];
		_curtor setVariable ["Name", format ["GW_Admin_Curator_%1", count GVARMAIN(adminCurators)], true];
		_curtor setVariable ["Addons", 3, true];
		_curtor setVariable ["Forced", 0, true];
		_curtor setVariable ["birdType", "", true];
		_curtor setVariable ["showNotification", false, true];
		_ZeuzModule setVariable ["adminvar",""];
		_ZeuzModule setVariable ["bis_fnc_moduleexecute_activate", true];
		_ZeuzModule setVariable ["bis_fnc_moduleinit_status", true];
		_ZeuzModule setVariable ["bis_fnc_initmodules_activate", true];
		_curtor setCuratorWaypointCost 0;
		{
			_curtor setCuratorCoef [_x,0];
		} forEach ["place","edit","delete","destroy","group","synchronize"];

		GVARMAIN(adminCurators) pushBack _curtor;
	};
};
