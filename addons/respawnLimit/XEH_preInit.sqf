#include "script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

GVAR(ServerConnections) = [];
GVAR(ServerDead) = [];
GVAR(ServerDeadPermanent) = [];
GVAR(IsSpectator) = {
	(["IsSpectating"] call BIS_fnc_EGSpectator)
};
