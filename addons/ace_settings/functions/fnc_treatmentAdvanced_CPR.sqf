#include "script_component.hpp"

params ["_caller", "_target", "_selectionName", "_className", "_items"];

if (alive _target && {(_target getVariable ["ACE_Medical_inCardiacArrest", false] || _target getVariable ["ACE_Medical_inReviveState", false])}) then {
	[_target, "activity_view", "STR_ACE_Medical_Activity_CPR", [[_caller, false, true] call ACE_Common_fnc_getName]] call ACE_Medical_fnc_addToLog;

	if (local _target) then {
		["ACE_Medical_treatmentAdvanced_CPRLocal", [_caller, _target]] call CBA_fnc_localEvent;
	} else {
		["ACE_Medical_treatmentAdvanced_CPRLocal", [_caller, _target], _target] call CBA_fnc_targetEvent;
	};
};

true
