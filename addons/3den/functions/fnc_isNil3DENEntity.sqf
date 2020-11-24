#include "script_component.hpp"
/*

	[] call GW_3DEN_fnc_isNil3DENEntity

*/

params ["_3denEntity"];

_location = ((_3denEntity get3DENAttribute "position") select 0);

(isNil "_location")
