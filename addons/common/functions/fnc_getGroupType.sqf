#include "script_Component.hpp"
/*	================================================================
	AUTHOR: GuzzenVonLidl
	Selects a new faction to spawn

	Usage:
	[west] call GW_Common_Fnc_getGroupType;

	Parameters:
	#0:	Side - Side to get units from

	Returning Value: ARRAY
	#0: SIDE - Side to spawn
	#1: STRING - Classname of team leader
	#2: ARRAY - Classnames

	Public: NO

	#define NO_SIDE -1
	#define EAST 0
	#define WEST 1
	#define RESISTANCE 2
	#define CIVILIAN 3
	#define NEUTRAL 4
	#define ENEMY 5
	#define FRIENDLY 6
	#define LOGIC 7

	[0] call BIS_fnc_sideName;
	[0] call BIS_fnc_sideType;
// ================================================================ */

params ["_faction"];

private _configs = (missionConfigFile >> "GW_FRAMEWORK" >> "SpawnUnits" >> toLower(_faction));
private _side = ([east,west,resistance,civilian] select (getNumber(_configs >> "Side")));
private _leader = getText(_configs >> "Leader");
private _unitList = getArray(_configs >> "Units");

[_side, _leader, _unitList]
