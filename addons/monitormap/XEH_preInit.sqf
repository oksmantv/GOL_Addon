#include "script_component.hpp"
#include "XEH_PREP.sqf"

GVAR(Enabled) = false;
GVAR(sigTerm) = false;
GVAR(constantUpdate) = false; // Whether markers should update while the map isn't open.
GVAR(bulletMarkerLifetime) = 2; // Seconds of marker lifetime.
GVAR(bulletMaxFlighttime) = 2; // Seconds of max bullet lifetime.
GVAR(bulletMarkerRefreshRate) = 20; // Hertz of bullet tracking refresh rate, same as FPS.
FUNC(compareBool) = {
		((_this select 0) && (_this select 1)) || {!(_this select 0) && !(_this select 1)}; // Either both true or both false
};
