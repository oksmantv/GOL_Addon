#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[] call GW_Common_fnc_getRespawnObjects;

	Arguments:

	Return Value:
	<ARRAY> - Respawn Objects grouped in to sides

	Public:
*/

_blufor = [];
_opfor = [];
_greenfor = [];
_spawns = (entities [["LocationRespawnPoint_F"], [], false, true]);

{
	private _str = toLower(_x getVariable ["GW_isRespawnPos", ""]);
	if !(_str isEqualTo "") then {
		if (_str isEqualTo "west") then {
			_blufor pushBack _x;
		};
		if (_str isEqualTo "east") then {
			_opfor pushBack _x;
		};
		if (_str isEqualTo "independent") then {
			_greenfor pushBack _x;
		};
	};
} forEach _spawns;

if (((count _opfor) + (count _blufor) + (count _greenfor)) > 1) then {
	[_opfor,_blufor,_greenfor]
} else {
	_opfor append _blufor;
	_opfor append _greenfor;
	_opfor
};
