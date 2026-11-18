#include "script_Component.hpp"
/*
	Author: GOL
	Checks if a trigger list contains a player that is NOT airborne.
	Infantry, ground vehicles and boats count as ground.
	Players in air vehicles (incl. parachutes) or in free fall do NOT count.
	Headless clients and dead units are ignored.

	Usage:
	[thisList] call GW_Common_Fnc_hasGroundPlayer;

	Arguments:
	0: Trigger list (thisList) <ARRAY>

	Return Value: BOOL

	Public: YES
*/

params [["_list", [], [[]]]];

private _players = [_list] call FUNC(getPlayersInList);

(_players findIf {
	private _vehicle = vehicle _x;
	if (_vehicle isNotEqualTo _x) then {
		!(_vehicle isKindOf "Air")
	} else {
		!("freefall" in toLower (animationState _x))
	}
}) != -1
