#include "script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

GVAR(DynamicViewDistance_Enabled) = false;
GVAR(DynamicViewDistance_AvgTargetDistance) = 25;
GVAR(DynamicViewDistance_getAvgFPS) = [];

GVAR(UnitCaching_Enabled) = false;
GVAR(UnitCaching_Objects) = [];

