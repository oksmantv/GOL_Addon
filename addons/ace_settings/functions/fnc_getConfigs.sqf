#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	get all ace configs defined in description

	Usage:
	_configs = call GW_ACE_Settings_fnc_getConfigs;

	Arguments: NO

	Return Value: <ARRAY>

	Public: No
*/

_Modules = [];
_settings = [];

for "_i" from 0 to ((count ((missionConfigFile >> "ACE_Settings"))) - 1) step 1 do {
	_Modules pushBack ((missionConfigFile >> "ACE_Settings") select _i);
};

{
	private ["_config","_value","_typeName","_force"];
	_config = (missionConfigFile >> "ACE_Settings" >> configName(_x));
	_value = getNumber(_config >> "value");
	_typeName = getText(_config >> "typeName");
	_force = getNumber(_config >> "force");

	if (_typeName isEqualTo "BOOL") then {
		_value = ([false,true] select _value);
	};
	_settings pushBack [(configName _config), _value, _typeName, _force];
} forEach _Modules;

_settings
