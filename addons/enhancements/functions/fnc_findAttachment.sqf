/*
	["GW_X3000"] call GW_enhancements_fnc_findAttachment
*/
#include "script_component.hpp"

private _weapons = [];
params ["_currentItem"];
{
	if (_currentItem isEqualTo (_x select 0) || _currentItem isEqualTo (_x select 1)) then {
		_weapons = _x;
	};
} forEach GVAR(attachmentList);

_weapons
