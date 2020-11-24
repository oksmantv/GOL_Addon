#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[player] call GW_Common_fnc_getRespawn;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/

params ["_unit"];

private _side = getNumber(configfile >> "CfgVehicles" >> (typeOf _unit) >> "side");

_respawnObjs = (call GW_Common_fnc_getRespawnObjects);
if ({!(_x isEqualTo [])} count _respawnObjs > 1) then {
	_respawnObjs = (_respawnObjs select _side);
};

if ((count _respawnObjs) > 0) then {
	(getPosASL (_respawnObjs select 0))
} else {
	_markerList = [];
	{
		if !((toLower(_x) find (call GW_Common_fnc_getRespawnMarker)) isEqualTo -1) then {
			_markerList pushBack _x;
		};
	} forEach allMapMarkers;

	if ((count _markerList) > 0) then {
		(getMarkerPos (_markerList select 0))
	} else {
		(_unit getVariable [QGVARMAIN(spawnLocation), [0,0,0]])
	};
};
