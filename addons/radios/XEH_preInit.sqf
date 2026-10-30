#include "script_component.hpp"

#include "XEH_PREP.sqf"

diag_log "[GW][Radios] XEH_preInit started";

GVAR(allJamers) = [];

if (false) then {
	#include "Scripts\Init_ACRE.sqf"
};

if (true) then {
	#include "Scripts\Init_TFAR.sqf"
};

diag_log "[GW][Radios] XEH_preInit finished";
