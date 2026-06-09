#include "script_component.hpp"

diag_log "[GW][Callsigns] XEH_postInit started";

if (!hasInterface) exitWith {};

private _condition = {leader group player == leader player || player in [w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]};
private _action = [
	"CallsignAct",
	"Change Callsign",
	"\A3\ui_f\data\map\markers\nato\b_unknown.paa",
	{[_this select 1] spawn FUNC(showCallsigns);},
	_condition
] call ace_interact_menu_fnc_createAction;

[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement"], _action] call ace_interact_menu_fnc_addActionToClass;

diag_log "[GW][Callsigns] XEH_postInit finished";
