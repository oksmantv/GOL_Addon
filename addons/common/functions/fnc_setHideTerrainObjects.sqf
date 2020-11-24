#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Hides island objects and does not affect editor/zeus objects
	NOTE: Hidden objects do not take damage

	Usage:
	[[0,0,0], true] call GW_Common_fnc_setHideTerrainObjects

	Parameters:
	#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
	#2	BOOL:	Hides or Shows objects

	Return Value: <GROUP>
	Group that spawned

	Public: NO

	Excluded from filter:
	"MAIN ROAD",
	"ROAD",
	"TRACK",
	"TRAIL",

	{
		[_x, true] call GW_3DEN_fnc_setObjectHidden2;
	} forEach (allMissionObjects "EmptyDetector") select {(["tomato", str _x] call BIS_fnc_inString)};;

*/

params [
	"_trg",
	"_toggle",
	["_exclude", []]
];

if !(isServer) exitWith {false};

private _filter = ["BUILDING","BUNKER","BUSH","BUSSTOP","CHAPEL","CHURCH","CROSS","FENCE","FOREST BORDER","FOREST SQUARE","FOREST TRIANGLE","FOREST","FORTRESS","FOUNTAIN","FUELSTATION","HOSPITAL","HOUSE","LIGHTHOUSE","LINES","POWER""POWERSOLAR","POWERWAVE","POWERWIND","QUAY","RAILWAY","ROCK","ROCKS","RUIN","SHIPWRECK","SMALL TREE","STACK","TOURISM","TRANSMITTER","TREE","VIEW-TOWER","WALL","WATERTOWER","HIDE"];

{
	_exl = toUpper(_x);
	_filter deleteAt (_filter find _exl);
} forEach _exclude;

private _trgArea = [];
_trgArea pushBack ((triggerArea _trg) select 0);
_trgArea pushBack ((triggerArea _trg) select 1);
_trgArea pushBack ((triggerArea _trg) select 4);

private _objects = (nearestTerrainObjects [_trg, _filter, (selectMax _trgArea), false]);

{
	if ((getObjectType _x) isEqualTo 1) then {
		_x hideObjectGlobal _toggle;
		_x enableSimulationGlobal !_toggle;
		_x allowDamage !_toggle;
	};
} forEach (_objects inAreaArray _trg);

deleteVehicle _trg;

_objects
