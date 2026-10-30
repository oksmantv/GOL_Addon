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
_misc = getText(configfile >> "CBA_VERSIONING" >> "GOL_MISC_ADDON" >> "version");
if (_misc isEqualTo "") then { _misc = "N/A" };

if (_fw isEqualTo "") then {
	[format ["Framework: Not Found<br/>GW Addon: %1<br/>Misc Addon: %2", _addon, _misc], "Framework and Addon Version Info"] spawn BIS_fnc_3DENShowMessage;
} else {
	[format ["Framework: %1<br/>GW Addon: %2<br/>Misc Addon: %3", _fw, _addon, _misc], "Framework and Addon Version Info"] spawn BIS_fnc_3DENShowMessage;
};

true
