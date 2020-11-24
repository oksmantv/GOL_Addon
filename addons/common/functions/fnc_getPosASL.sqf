#include "script_Component.hpp"
/*
	AUTHOR: GuzzenVonLidl
	Gets location of a marker, object or array ([0,0,0])

	Usage:
	[MHQ] call GW_Common_fnc_getPosASL;	// Object
	["Hello"] call GW_Common_fnc_getPosASL;	// Marker

	Parameters:
	#0:	OBJECT || STRING || ARRAY - Gets location from a place

	Return Value: <ARRAY>
	Position

	Public: NO
*/

params ["_type"];
private ["_returnValue"];

switch (typeName _type) do {

	case "STRING": {
		_returnValue = (getMarkerPos _type);
	};

	case "OBJECT": {
		_returnValue = (getPosASL _type);
	};

	case "GROUP": {
		_returnValue = (getPosASL (leader _type));
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
