#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Copies objects relative location and rotation from players and puts them in a Config based format

	Usage:
	[] call GW_3DEN_fnc_createComposition;

	Arguments:
	#0:	NUMBER:		 Copy Mode, 1 - Static units || 2 - Objects and Vehicles Only

	Return Value: NO

	Public: NO

*/

//	if (isNull player) exitWith { ["No player unit found!","Warning!"] call BIS_fnc_3DENShowMessage; };
if (isNull player) exitWith { ["No player unit found!", 1, 10, true] call BIS_fnc_3DENNotification; };

private ["_strArr","_CopyObjects","_count"];
private ["_start","_end","_final"];
_strArr = [];
_CopyObjects = [];
_count = -1;
_strArr = _strArr + toArray(format ["class EXAMPLE { %1	name = ""EXAMPLE""; %1	side = 8; %1	icon = ""\a3\Ui_f\data\Map\VehicleIcons\iconVehicle_ca.paa"";%1", toString [10]]);

{
	if !(_x isKindOf "CAManBase") then {
		_count = _count + 1;
		_pos = player worldToModel (position _x);
		_strArr = _strArr + toArray(format ["	class Object%1 { side = 8; rank = """";  vehicle = ""%2""; dir = %3; position[] = {%4,%5,%6}; };%7", _forEachIndex, typeOf _x, round(getDir _x), (_pos select 0), (_pos select 1), (_pos select 2), toString [10]]);
	};
} forEach get3DENSelected "object";
_strArr = _strArr + toArray(format ["}; %1", toString [10]]);

systemChat format ["%1 Objects Copied", (_count)];
copyToClipboard (toString(_strArr));
