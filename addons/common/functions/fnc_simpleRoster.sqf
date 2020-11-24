#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Creates a diary subject for the player's team, current units connected and roles
	Only updated at mission start and new person joins
	Note: This only takes predefined roles, changing role mid mission wont change it

	Usage:
	[] call GW_Common_Fnc_simpleRoster;

	Arguments: NO

	Return Value: NO

	Public: NO
*/

if (!hasInterface) exitWith {false};

private _strFinal = "";
private _strColorGrp = "'#990099'";
private _allGroups = [];
if (isMultiplayer) then {
	_allGroups = (allGroups select {((side _x) isEqualTo playerSide) && (({isPlayer _x} count (units _x)) > 0)});
} else {
	_allGroups = (allGroups select {((side _x) isEqualTo playerSide)});
};

switch (playerSide) do {
	case west: {
		_strColorGrp = "'#0066CC'";
	};
	case east: {
		_strColorGrp = "'#990000'";
	};
	case independent: {
		_strColorGrp = "'#339900'";
	};
};

{
	_group = _x;
	_strFinal =  _strFinal + "<br/>";
	{
		_strFinal =  _strFinal + "<font color=" + _strColorGrp + ">" + (roleDescription _x) + ": </font>" + (name _x) +"<br/>";
	} forEach (units _x);
} forEach _allGroups;

if !(player diarySubjectExists QGVAR(simpleRoster)) then {
	player createDiarySubject [QGVAR(simpleRoster),"Platoon Roster"];
};
player createDiaryRecord [QGVAR(simpleRoster),[format ["Platoon Roster - %1", [time, "H:MM:SS"] call CBA_fnc_formatElapsedTime], _strFinal]];
