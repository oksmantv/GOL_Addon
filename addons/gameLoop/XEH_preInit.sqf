#include "script_component.hpp"

#include "XEH_PREP.sqf"

#include "initSettings.sqf"

GVAR(Timer) = -1;	// useType == false

GVAR(CiviKillCount) = 0;

GVAR(SafeMode_Enabled) = false;
GVAR(SafeZoneMarkers) = [];
