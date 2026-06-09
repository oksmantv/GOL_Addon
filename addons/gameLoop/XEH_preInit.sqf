#include "script_component.hpp"

#include "XEH_PREP.sqf"

#include "initSettings.sqf"

diag_log "[GW][SafeMode] XEH_preInit started";

GVAR(Timer) = -1;	// useType == false

GVAR(CiviKillCount) = 0;

GVAR(SafeMode_Enabled) = false;
GVAR(SafeZoneMarkers) = [];
