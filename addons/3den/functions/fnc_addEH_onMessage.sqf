#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl

	Usage:
	[0] call GW_3den_fnc_addEH_onMessage;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/



params ["_switch"];

switch (_switch) do {
	case 0: {	//	Mission saved
	};
	case 1: {	//	Mission autosaved
	};
	case 2: {	//	Trying to move a character into full vehicle
	};
	case 3: {	//	Moved character into enemy vehicle
	};
	case 4: {	//	Trying to run mission without any player
	};
	case 5: {	//	Mission exported to SP
	};
	case 6: {	//	Mission exported to MP
		if (isClass(missionConfigFile >> "GW_FRAMEWORK")) then {
			edit3DENMissionAttributes 'GW_MissionPreferences';
			if !(GVAR(ExportErrorCount) isEqualTo 0) then {
				["Errors needs to be fixed before uploading the final version of this mission", 1, 15, true] call BIS_fnc_3DENNotification;
			};
		};
	};
	case 7: {	//	Attempting to delete a default layer
	};
	default {
		diag_log str _this;
	};
};
