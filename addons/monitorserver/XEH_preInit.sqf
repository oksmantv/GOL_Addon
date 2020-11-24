#include "script_component.hpp"
#include "XEH_PREP.sqf"

GVAR(isEnabled) = false;
GVAR(doRecive) = false;
GVAR(infoFPS) = [];
GVAR(infoHC) = [];
GVAR(adminUpdateList) = [];
GVAR(HeadlessList) = [];

[QGVAR(addHC), {
	GVAR(HeadlessList) pushBack _this;
}] call CBA_fnc_addEventHandler;

[QGVAR(addServerRequest), {
	GVAR(adminUpdateList) pushBackUnique _this;
	if ((count GVAR(adminUpdateList)) isEqualTo 1) then {
		GVAR(isEnabled) = true;
		publicVariable QGVAR(isEnabled);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(removeServerRequest), {
	params ["_unit"];
	GVAR(adminUpdateList) deleteAt (GVAR(adminUpdateList) find _unit);

	if ((count GVAR(adminUpdateList)) isEqualTo 0) then {
		GVAR(isEnabled) = false;
		publicVariable QGVAR(isEnabled);
		GVAR(infoFPS) = [];
		GVAR(infoHC) = [];
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(sendInfo), {
	GVAR(infoFPS) pushBack _this;
}] call CBA_fnc_addEventHandler;

[QGVAR(sendInfoHC), {
	params ["_headless","_units","_groups","_fps"];
	GVAR(infoHC) pushBack [_headless, _units, _groups, _fps];
}] call CBA_fnc_addEventHandler;

[QGVAR(reciveServerInfo), {
	_this call FUNC(Display);
}] call CBA_fnc_addEventHandler;
