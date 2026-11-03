#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Re-imports the addon owned CBA settings into the mission when the mission was
	configured with an older settings version. Runs when a mission is loaded in 3DEN.

	Usage:
	[] spawn GW_3DEN_fnc_checkSettingsVersion;

	Arguments: NO

	Return Value: NO

	Public: NO

*/

if (!is3DEN) exitWith {};
if (uiNamespace getVariable ["GW_3DEN_settingsCheckRunning", false]) exitWith {};
uiNamespace setVariable ["GW_3DEN_settingsCheckRunning", true];

// Let the editor finish loading the mission
uiSleep 2;
waitUntil {!isNull (findDisplay 313)};

if (
	[] call FUNC(isFW4) &&
	{"GW_MissionPreferences" get3DENMissionAttribute "GW_isConfigured"}
) then {
	private _current = [] call FUNC(getSettingsVersion);
	private _stored = "GW_MissionPreferences" get3DENMissionAttribute "GW_settingsVersion";
	if !(_stored isEqualType 0) then {_stored = 0};

	if (_current > _stored) then {
		LOG_2("CBA settings outdated (mission %1, addon %2), re-importing", _stored, _current);
		[format ["GW: Updating mission CBA settings (v%1 -> v%2)", _stored, _current], 0, 5, true] call BIS_fnc_3DENNotification;
		[] call FUNC(importCBASettings);
	};
};

uiNamespace setVariable ["GW_3DEN_settingsCheckRunning", false];
