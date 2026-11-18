#include "script_Component.hpp"
/*
	Author: GOL
	Checks if a trigger list contains a player that is airborne.
	Counts players in air vehicles (planes, helicopters, parachutes, UAV-class air)
	and players in free fall (HALO) before the parachute opens.
	Infantry, ground vehicles and boats do NOT count.
	Headless clients and dead units are ignored.

	Usage:
	[thisList] call GW_Common_Fnc_hasAircraftPlayer;

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
		_vehicle isKindOf "Air"
	} else {
		"freefall" in toLower (animationState _x)
	}
}) != -1
