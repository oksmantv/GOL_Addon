/*
*	Author: GuzzenVonLidl
*	Outputs server info for admins to debug
*
*	Usage:
*	[] call GW_MonitorServer_Fnc_addUpdate;
*	Arguments: NO
*
*	Return Value: NO
*
*	Public: NO
*
*/
#include "script_component.hpp"

private _infoHC = (([["Server",({local _x} count allUnits),({local _x} count allGroups),(round diag_fps)]]) + GVAR(infoHC));
GVAR(infoHC) = [];

private _server = 0;
private _listHC = [];
private _listPlayers = [];
{
	switch (_x select 0) do {
		case 1: {
			_server = (_x select 1);
		};
		case 2: {
			_listHC pushBack (_x select 1);
		};
		default {
			_listPlayers pushBack (_x select 1);
		};
	};
} forEach GVAR(infoFPS);

private _fpsList = [_server, round(_listHC call EFUNC(Common,findAverage)), round(_listPlayers call EFUNC(Common,findAverage))];

{
	[QGVAR(reciveServerInfo), [_fpsList, _infoHC], _x] call CBA_fnc_targetEvent;
} forEach GVAR(adminUpdateList);

// Reset variables
GVAR(infoFPS) = [];
GVAR(infoHC) = [];
