#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Gets the correct respawn marker for the side the player is on

	Usage:
	[this] call _fnc_getRespawnMarker;

	Arguments:
	0: <Object> - Player

	Return Value:
	<String> - Respawn marker name

	Public:
*/



params ["_unit"];
private _side = (getNumber(configfile >> "CfgVehicles" >> typeOf player >> "side"));
if ((_side < 0) || (_side > 2)) then {
	"respawn_civilian"
} else {
	["respawn_east","respawn_west","respawn_resistance"] select _side
};
