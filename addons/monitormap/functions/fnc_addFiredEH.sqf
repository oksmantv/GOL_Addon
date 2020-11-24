#include "script_component.hpp"

params ["_obj"];
if !(_obj getVariable [QGVAR(firedEH), false]) then {
	_obj setVariable [QGVAR(firedEH), true];
	(_obj addEventHandler ["Fired", {_this call FUNC(firedEH);}])
};
