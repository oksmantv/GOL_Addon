#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets the original side of an object or unit, it belongs to, even if setCaptive is used

	Usage:
	[player] call GW_Common_Fnc_getSide;

	Parameters:
	#0	OBJECT

	Return Value: SIDE

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
*/
params ["_target"];
private _number = getNumber(configfile >> "CfgVehicles" >> (typeOf _target) >> "side");

[east,west,independent,civilian, sideEmpty, sideEnemy, sideFriendly, sideLogic] select _number
