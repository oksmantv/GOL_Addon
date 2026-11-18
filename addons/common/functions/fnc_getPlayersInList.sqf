#include "script_Component.hpp"
/*
	Author: GOL
	Extracts the real player units from a trigger list (thisList).
	Handles vehicles in the list by resolving their crew, so players are found
	whether the list contains the man, the vehicle, or both.
	Headless clients, dead units and non-man entities are excluded.

	Usage:
	[thisList] call GW_Common_Fnc_getPlayersInList;

	Arguments:
	0: Trigger list (thisList) <ARRAY>

	Return Value: ARRAY of player units (no duplicates)

	Public: YES
*/

params [["_list", [], [[]]]];

private _units = [];

{
	if (_x isKindOf "CAManBase") then {
		_units pushBack _x;
	} else {
		_units append (crew _x);
	};
} forEach _list;

_units = _units arrayIntersect _units;

_units select {
	isPlayer _x
	&& {alive _x}
	&& {_x isKindOf "CAManBase"}
	&& {!(_x isKindOf "HeadlessClient_F")}
}
