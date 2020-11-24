#include "script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

GVAR(HintInt) = 0;
GVAR(tempCurator) = [];

if (isClass(missionConfigFile >> "GW_FRAMEWORK")) then {
	[] spawn {
		uisleep 1;
		_list = [];
		{
			_list pushBackUnique ((CBA_settings_default getVariable _x) select 4)
		} forEach CBA_settings_allSettings;
		_list sort true;
		_index = (_list find QUOTE(ADDON));
		_index = (_index + ({!((_x find "STR_") isEqualTo -1)} count _list));
		uiNamespace setVariable ["cba_settings_addonIndex", _index];
	};
};
