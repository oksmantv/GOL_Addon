// ================================================================
// *	AUTHOR: GuzzenVonLidl
// *
// *	Description:
// *		This function moves any vehicle infront of a object
// *
// *	Usage:
// *		[] call GOL_Fnc_MoveVehicle;
// *
// *	Parameters:
// *		0:	OBJECT - Vehicle to be teleported
// *		1:	OBJECT - Target location
// *		2:	NUMBER - Distance from the target the vehicle should be placed (DEFAULT: 5)
// *
// *	Returning Value:
// *		Nothing
// *
// ================================================================

	_vehicle = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_target = [_this, 1] call BIS_fnc_param;
	_distance = [_this, 2, 5, [0]] call BIS_fnc_param;
    _vehicle setPos ([[getPosATL _target select 0, getPosATL _target select 1, getPosATL _target select 2], _distance, getDir _target] call BIS_fnc_relPos);
