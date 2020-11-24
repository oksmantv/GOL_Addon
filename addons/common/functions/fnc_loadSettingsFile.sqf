#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl


	Usage:
	[(preprocessFile "x\gw\addons\ACE_Settings\cba_settings.sqf")] call GW_Common_Fnc_loadSettingsFile;

	Arguments:
	#0:	Config

	Return Value: No

	Public: NO
*/

params ["_missionConfig"];

{
	_x params ["_setting", "_value", "_priority"];
	CBA_settings_mission setVariable [_setting, [_value, _priority]];
	[_setting, _value, _priority, "server", false] call CBA_settings_fnc_set;
} forEach ([_missionConfig, false] call CBA_settings_fnc_parse);



/*

Legacy, Not working

params ["_missionConfig"];

{
	_x params ["_setting", "_value", "_priority"];
	CBA_settings_serverConfig setVariable [_setting, [_value, _priority]];
} forEach ([_missionConfig, false] call CBA_settings_fnc_parse);

{
	private _setting = _x;
	private _settingInfo = CBA_settings_serverConfig getVariable _setting;

	if (isNil "_settingInfo") then {
		private _settingsHash = (findDisplay 313) getVariable ["CBA_settings_hash", ([] call CBA_fnc_hashCreate)];
		_settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;
	};

	if (!isNil "_settingInfo") then {
		_settingInfo params ["_value", "_priority"];

		// convert boolean to number
		_priority = [0, 1, 2] select _priority;

		if ([_setting, _value] call CBA_settings_fnc_check) then {
			CBA_settings_Server setVariable [_setting, [_value, _priority]];
		};
	};
} forEach CBA_settings_allSettings;
*/
