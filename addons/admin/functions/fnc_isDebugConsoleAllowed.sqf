#include "script_Component.hpp"

if (isServer || serverCommandAvailable "#kick") exitWith {true};

if (str missionConfigFile == "A3\Missions_F_Bootcamp\Scenarios\Arsenal.VR\description.ext") exitWith {true};

if (missionNamespace getVariable ["GW_isAdmin", false]) exitWith {true};

if ((getMissionConfigValue ["enableDebugConsole", 0]) isEqualTo 2) exitWith {true};

false
