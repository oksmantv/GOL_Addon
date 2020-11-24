#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3den_fnc_getVersion;

	Parameters:

	Return Value: <NO>

	Public: NO

*/


_fw = getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version");
_addon = getText(configfile >> "CfgPatches" >> "GW_Main" >> "Version");

if (_fw isEqualTo "") then {
	[format ["Framework: Not Found                          Addon: %2", _fw,_addon], "Framework and Addon Version Info"] spawn BIS_fnc_3DENShowMessage;
} else {
	[format ["Framework: %1                       Addon: %2", _fw,_addon], "Framework and Addon Version Info"] spawn BIS_fnc_3DENShowMessage;
};

true
