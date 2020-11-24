#include "script_component.hpp"

params ["_caller","_target"];

if (_target getVariable ["ACE_Medical_inReviveState", false]) then {
	private _reviveStartTime = _target getVariable ["ACE_Medical_reviveStartTime",0];
	if (_reviveStartTime > 0) then {
		_target setVariable ["ACE_Medical_reviveStartTime", (_reviveStartTime + 60)];
	};
};

if ((ACE_Medical_level > 1) && {(random 1) >= 0.6}) then {
    _target setVariable ["ACE_Medical_inCardiacArrest", nil,true];
    _target setVariable ["ACE_Medical_heartRate", 40];
    _target setVariable ["ACE_Medical_bloodPressure", [50,70]];
};

[_target, "activity", "STR_ACE_Medical_Activity_CPR", [[_caller, false, true] call ACE_Common_fnc_getName]] call ACE_Medical_Fnc_addToLog;
[_target, "activity_view", "STR_ACE_Medical_Activity_CPR", [[_caller, false, true] call ACE_Common_fnc_getName]] call ACE_Medical_Fnc_addToLog; // TODO expand message

true
