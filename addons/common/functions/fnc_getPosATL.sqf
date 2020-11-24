#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets location of a marker, object or array ([0,0,0])

	Usage:
	[MHQ] call GW_Common_fnc_getPosATL;	// Object
	["Hello"] call GW_Common_fnc_getPosATL;	// Marker
	[car1, 1] call GW_Common_fnc_getPosATL;	// Real z coordinate of an object, for placing stuff on roofs, etc.

	Parameters:
	#0:	OBJECT || STRING || ARRAY - Gets location from a place
	#1:	NUMBER - ONLY if #0 is OBJECT, 0 for normal, 1 for real height

	Return Value: <ARRAY>
	Position

	Public: NO
*/

params ["_type", ["_extream", 0, [0]]];
private ["_returnValue","_DebugName"];

switch (typeName _type) do {

	case "STRING": {
		_returnValue = (getMarkerPos _type);
	};

	case "OBJECT": {
		_returnValue = (getPosATL _type);
	};

	case "OBJECT": {
		_returnValue = (getPosATL _type);
	};

	case "GROUP": {
		_returnValue = (getPosATL (leader _type));
	};

	case "LOCATION": {
		_returnValue = (position _type);
	};

	case "ARRAY": {
		_returnValue = _type;
	};

	default {
		ERROR(FORMAT_1("%1 was passed to this function, only accepts STRING, OBJECT, GROUP, LOCATION or ARRAY", (typeName _type)));
	};

};

_returnValue
