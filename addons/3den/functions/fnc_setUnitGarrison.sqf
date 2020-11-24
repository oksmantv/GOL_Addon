#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets Location in the area and then moves selected units to the valid house positions

	Usage:
	[] call GW_3DEN_fnc_setUnitGarrison

	Parameters: None

	Return Value: None

	Public: NO
*/

params [["_pos", [0,0,0]]];

private _buildingPos = [];
private _buildingPosSort = [];
private _buildingPosUsed = [];
private _radius = ("Preferences" get3DENMissionAttribute "GW_GarrisonRadius");
private _selectedUnits = ((get3DENSelected "object") select {(_x isKindOf "CAManBase")});

if (count _selectedUnits isEqualTo 0) exitWith {
	["No units were selected!", 1, 5, false] call BIS_fnc_3DENNotification;
	false
};

{
	if (!(isObjectHidden _x)) then {
		_housePositions = ([_x] call BIS_fnc_buildingPositions);
		if (count _housePositions > 0) then {
			ADD(_buildingPos,_housePositions);
		};
	};
} forEach (nearestObjects [_pos, ["house"], _radius]);

_buildingPosSort = [_buildingPos,[],{_pos distance _x},"ASCEND"] call BIS_fnc_sortBy;

if (count _buildingPosSort > 0) then {
	collect3DENHistory {
		{
			private _unit = _x;
			if (_forEachIndex <= (count _buildingPosSort)) then {
				_selectedPos = (_buildingPosSort select _forEachIndex);
				_unit set3DENAttribute ["position",_selectedPos];
				_unit set3DENAttribute ["rotation", [0,0,floor(random 360)]];
				_buildingPosSort deleteAt (_buildingPosSort find _selectedPos);
			} else {
				["Units exided bulding positions", 1, 5] call BIS_fnc_3DENNotification;
			};
		} forEach _selectedUnits;
	};
} else {
	["No Buildings were found", 1, 5, false] call BIS_fnc_3DENNotification;
//	diag_log _buildingPos;
//	diag_log _buildingPosSort;
//	diag_log _buildingPosUsed;
};

true
