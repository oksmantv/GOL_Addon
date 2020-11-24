/*
*	Author: GuzzenVonLidl
*	Outputs server info for admins to debug
*
*	Usage:
*	[] spawn GW_MonitorServer_Fnc_Display;
*	Arguments: NO
*
*	Return Value: NO
*
*	Public: NO
*
*/

#include "script_component.hpp"
#define	COUNTUNITS(Var) ({(side _x) isEqualTo Var} count allUnits)
#define	COUNTGROUPS(Var) ({(side _x) isEqualTo Var} count allGroups)
#define	COUNTPLAYERS(Var) ({(side _x) isEqualTo Var} count allPlayers)
params ["_fps", "_hcInfo"];

if (GVARMAIN(canUseDevConsole)) then {
	DEVCONSOLE("#1110");
	LOG(FORMAT_1("Last updated: %1", time));
	LOG(FORMAT_4("AllUnits - Total: %1 | West: %2 | East: %3 | Indep: %4", (count allUnits),COUNTUNITS(west),COUNTUNITS(east),COUNTUNITS(independent),COUNTUNITS(civilian)));
	LOG(FORMAT_4("AllGroups - Total: %1 | West: %2 | East: %3 | Indep: %4", (count allGroups),COUNTGROUPS(west),COUNTGROUPS(east),COUNTGROUPS(independent),COUNTGROUPS(civilian)));
	LOG(FORMAT_5("Players - Total: %1 | West: %2 | East: %3 | Indep: %4 | Headless: %5", (count allPlayers),COUNTPLAYERS(west),COUNTPLAYERS(east),COUNTPLAYERS(independent),COUNTPLAYERS(civilian),({_x isKindOf "HeadlessClient_F"} count allPlayers)));
	LOG(FORMAT_3("FPS - Server: %1 Headless: %2 Players: %3", (_fps select 0),(_fps select 1),(_fps select 2)));
	{
		LOG(FORMAT_4("%1 - Units: %2 | Groups: %3 | FPS: %4", (_x select 0),(_x select 1),(_x select 2),(_x select 3)));
	} forEach _hcInfo;
} else {
	hintSilent "";
	private _temp = "";
	_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>AllUnits: </t><t align='left' color='#FFD30D'>%1  </t><t align='left' color='#00FFFF'>W: %2  </t><t align='left' color='#FF0000'>E: %3  </t><t align='left' color='#00FF00'>I: %4  </t><t align='left' color='#FF00FF'>C: %5</t>",(count allUnits),COUNTUNITS(west),COUNTUNITS(east),COUNTUNITS(independent),COUNTUNITS(civilian)]), lineBreak];
	_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>AllGroups: </t><t align='left' color='#FFD30D'>%1  </t><t align='left' color='#00FFFF'>W: %2  </t><t align='left' color='#FF0000'>E: %3  </t><t align='left' color='#00FF00'>I: %4  </t><t align='left' color='#FF00FF'>C: %5</t>",(count allGroups),COUNTGROUPS(west),COUNTGROUPS(east),COUNTGROUPS(independent),COUNTGROUPS(civilian)]), lineBreak];
	_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>Players: </t><t align='left' color='#FFD30D'>%1  </t><t align='left' color='#00FFFF'>W: %2  </t><t align='left' color='#FF0000'>E: %3  </t><t align='left' color='#00FF00'>I: %4  </t><t align='left' color='#FF00FF'>C: %5  </t><t align='left' color='#FFD30D'>HC: %6</t>",(count allPlayers),COUNTPLAYERS(west),COUNTPLAYERS(east),COUNTPLAYERS(independent),COUNTPLAYERS(civilian),({_x isKindOf "HeadlessClient_F"} count allPlayers)]), lineBreak];
	_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>FPS:  <t align='left' color='#FFD30D'>Server: %1  Headless: %2  Players: %3</t>", (_fps select 0),(_fps select 1),(_fps select 2)]), lineBreak, lineBreak];

	{
		_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>Machine:<t align='right' color='#FFD30D'>%1</t>", (_x select 0)]), lineBreak];
		_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>Units:<t align='right' color='#FFD30D'>%1</t>", (_x select 1)]), lineBreak];
		_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>Groups:<t align='right' color='#FFD30D'>%1</t>", (_x select 2)]), lineBreak];
		_temp = composeText [_temp,(parseText format["<t align='left' color='#FFFFFF'>FPS:<t align='right' color='#FFD30D'>%1</t>", (_x select 3)]), lineBreak, lineBreak];
	} forEach _hcInfo;
	hintSilent _temp;
};
