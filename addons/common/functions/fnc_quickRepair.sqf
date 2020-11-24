#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Emergency repair for a vehicle, fixes all parts that have been destroyed to the first movable

	Usage:
	[this] call GW_Common_Fnc_quickRepair;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: NO
*/

params ["_veh", cursorObject, [objNull]];

if (_veh isEqualTo objNull) exitWith {false};

_list = getAllHitPointsDamage _veh;
_localPos = (_veh worldToModel (getPosWorld player));
(boundingBoxReal _veh) params ["_p1","_p2"];
_maxWidth = abs((_p2 select 0) - (_p1 select 0));
_maxLength = abs((_p2 select 1) - (_p1 select 1));
_maxHeight = abs((_p2 select 2) - (_p1 select 2));
if (({_x >= 0.8} count (_list select 2) > 0) && (_localPos inArea [[0,0,0], (_maxWidth/1.7), (_maxLength/1.6), 0, true, _maxHeight])) then {
	_veh engineOn false;
	if (primaryWeapon player != "") then {
		player playMoveNow "AmovPknlMstpSlowWrflDnon";
	};
	["Emergency Repair", (40 + floor(random 20)), {
		(_this select 0) params ["_veh"];
		_localPos = (_veh worldToModel (getPosWorld player));
		(boundingBoxReal _veh) params ["_p1","_p2"];
		_maxWidth = abs((_p2 select 0) - (_p1 select 0));
		_maxLength = abs((_p2 select 1) - (_p1 select 1));
		_maxHeight = abs((_p2 select 2) - (_p1 select 2));
		((_localPos inArea [[0,0,0], (_maxWidth/1.7), (_maxLength/1.6), 0, true, _maxHeight]) && !(isEngineOn _veh))
	}, {
		(_this select 0) params ["_veh"];
		_list = getAllHitPointsDamage _veh;
		{
			if (_x >= 0.8) then {
				_veh setHitPointDamage [((_list select 0) select _forEachIndex), 0.7];
			};
		} forEach (_list select 2);
	}, {
		["Aborted", 3] call GW_Common_Fnc_Hint;
	}, [_veh]] call CBA_fnc_progressBar;
};
