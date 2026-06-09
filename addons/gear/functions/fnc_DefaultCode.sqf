// Wrapper around scripts\Default.sqf to provide the CBA macro context
// (EFUNC, EGVAR, etc.) when the data file is compiled standalone via
// `compile preProcessFileLineNumbers` from the mission's preInit.sqf.
// The wrapped file is preprocessed inline, so all local variables in the
// caller's scope (Handler_Addon) remain accessible at runtime.
#include "..\script_component.hpp"

diag_log format ["[GW_Gear][DefaultCode] start unit=%1 role=%2 loadoutFile=%3", _unit, _role, _loadoutFile];
#include "..\scripts\Default.sqf"

diag_log format ["[GW_Gear][DefaultCode] end unit=%1 role=%2", _unit, _role];
