#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Returns name of all available pylons for the object
	Returns empty if no pylons were found

	Usage:
	_vehicle = ((get3DENSelected "object") select 0);
	[_vehicle] call GW_Common_Fnc_getPylonsAvailable;

	Arguments:
	#0:	OBJECT - Object to get pylons from

	Return Value: ARRAY

	Public: NO
*/

params [["_object", objNull]];

(("true" configClasses (configFile >> "CfgVehicles" >> (typeOf _object) >> "Components" >> "TransportPylonsComponent" >> "Pylons" ) apply {configName _x}))
