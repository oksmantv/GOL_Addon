#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Reads the version stamp of the addon owned CBA settings file.
	The stamp is the line "// GW_SETTINGS_VERSION: <number>" in Data\cba_settings_mission.sqf.
	Bump that number whenever the file changes and missions will re-import on next load in 3DEN.

	Usage:
	[] call GW_3DEN_fnc_getSettingsVersion;

	Arguments: NO

	Return Value:
	<NUMBER> - Version, 0 if missing

	Public: NO

*/

private _version = 0;
// loadFile is used because preprocessing strips comments
private _lines = (loadFile "\x\gw\addons\3den\Data\cba_settings_mission.sqf") splitString (toString [10, 13]);

{
	if ((_x find "GW_SETTINGS_VERSION") >= 0) exitWith {
		_version = parseNumber ((_x splitString ": ") param [2, "0"]);
	};
} forEach _lines;

_version
