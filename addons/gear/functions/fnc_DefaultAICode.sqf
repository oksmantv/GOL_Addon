// Wrapper around scripts\Default_AI.sqf — see fnc_DefaultCode.sqf for rationale.
#include "..\script_component.hpp"

diag_log format ["[GW_Gear][DefaultAICode] start unit=%1 role=%2 loadoutFile=%3", _unit, _role, _loadoutFile];
#include "..\scripts\Default_AI.sqf"

diag_log format ["[GW_Gear][DefaultAICode] end unit=%1 role=%2", _unit, _role];
