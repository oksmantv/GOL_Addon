#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Moves selected objects in to a specified pattern.
	Idea from Revo

	Usage:
	["LINE"] call GW_3den_fnc_setObjectPattern;

	Parameters:
	#0	STRING:	 Pattern type to use

	Return Value: BOOL

	Public: NO
*/

params [["_patternType", "LINE", [""]]];

private _allEntities = ((get3DENSelected "object") + (get3DENSelected "Marker") + (get3DENSelected "Trigger") + (get3DENSelected "Logic"));
if ((count _allEntities) < 2) exitWith {false};

private _getObject = (_allEntities select 0);
private _rotation = ((_getObject get3DENAttribute "Rotation") select 0);
private _nextPos = ((_getObject get3DENAttribute "Position") select 0);

if (toUpper(_patternType) isEqualTo "LINE") then {
	_offset = ("Preferences" get3DENMissionAttribute "GW_PatternOffset");

	collect3DENHistory {
		{
			_x set3DENAttribute ["Position", _nextPos];
			_x set3DENAttribute ["Rotation", _rotation];
			_nextPos = (_x getRelPos [_offset, 90]);
			_nextPos set [2, ((_x get3DENAttribute "Position") select 0) select 2];
		} forEach _allEntities;
	};
};

if (toUpper(_patternType) isEqualTo "CIRCULAR") then {
	_radius = ("Preferences" get3DENMissionAttribute "GW_PatternOffset");
	_center = ((_getObject get3DENAttribute "Position") select 0);

	collect3DENHistory {
		{
			private _pos = (_center getPos [_radius, ((360/(count _allEntities)) * _forEachIndex)]);
			_x set3DENAttribute ["Position",_pos];
			_x set3DENAttribute ["Rotation",[0,0,(360/(count _allEntities)) * _forEachIndex]];
		} forEach _allEntities;
	};
};

[(str _this),QFUNC(setObjectPattern)] call FUNC(uiSaveFunction);

true
