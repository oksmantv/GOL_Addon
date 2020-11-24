#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets Location in the area and then moves selected units to the valid house positions

	Usage:
	[] call GW_3DEN_fnc_getCorrectVersion

	Parameters: None

	Return Value: None

	Public: NO
*/

params ["_copyGroup","_copyType"];

if ((get3DENSelected "object") isEqualTo []) exitWith {
	systemChat "Nothing to copy";
	false
};

_getVersion = (getNumber(missionConfigFile >> "GW_Modules" >> "Common" >> "version"));

if (_getVersion isEqualTo 0) then {
	_empty = ("Preferences" get3DENMissionAttribute "GW_copyOnEmpty");
	if (_empty isEqualTo "0.8") then {
		_getVersion = 2.0;
	};
	if (_empty isEqualTo "0.6") then {
		_getVersion = 1.8;
	};
	if (_empty isEqualTo "0.5") then {
		_getVersion = 1.5;
	};
};

if (_copyGroup) then {
	if (_getVersion >= 2.0) then {
		[_copyType] call FUNC(copyGroup);
	} else {
		if (_getVersion >= 1.8) then {
			[_copyType] call FUNC(copyGroupLegacy_08);
		} else {
			[_copyType] call FUNC(copyGroupLegacy_07);
		};
	};
} else {
	if (_getVersion >= 2.0) then {
		[_copyType] call FUNC(copyStatic);
	} else {
		if (_getVersion >= 1.8) then {
			[_copyType] call FUNC(copyStaticLegacy_08);
		} else {
			[_copyType] call FUNC(copyStaticLegacy_07);
		};
	};
};
