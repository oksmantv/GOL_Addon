#include "script_Component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

GVAR(onScreenUnits) = [];

GVAR(showNameTags) = false;
GVAR(MaxDistance) = 60;
GVAR(nameAlpha) = 1;
GVAR(damageAlpha) = 1;
GVAR(isTagsBlurred) = {false};

GVAR(spectate) = false;
