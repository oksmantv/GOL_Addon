#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Copy units, vehicles and waypoints

	Usage:
	[] call GW_3DEN_fnc_CopyStatic

	Arguments:
	#0:	NUMBER:		 Copy Mode, 1 - Static units || 2 - Objects and Vehicles Only
	Return Value: NO

	Public: NO
*/
#define	GETATTRIBUTE(Var) ((_x get3DENAttribute Var) select 0)
//#define	CUT_X(Var1) [Var1, 2] call BIS_fnc_cutDecimals
#define	CUT_X(Var1) parseNumber(Var1 toFixed 3)
#define	CUT_XYZ(Var1,Var2,Var3) [CUT_X(Var1),CUT_X(Var2),CUT_X(Var3)]

params [
	"_type"
];

private _units = [];
private _vehicles = [];
private _objects = [];
private _return = 0;

{
	private _special = [];
	switch (_type) do {
		case 1: { // Units && Vehicles
			if (_x isKindOf "AllVehicles") then {
				private _special = ([_x] call FUNC(getAttributes));

				if !(_x isKindOf "CAManBase") then {
					private _crewList = [];
					private _crew = (fullCrew _x);
					if ((count _crew) isEqualTo 0) then {
						_crew = (fullCrew [_x, "", true]);
					} else {
						{
							_crewList pushBack [(_x select 1), (_x select 2), (_x select 3)];
						} forEach _crew;
					};

					_vehicles pushBack [GETATTRIBUTE("itemClass"), GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _crewList, _special];
				};

				if (_x isKindOf "CAManBase") then {
					private _stance = ["Up","Middle","Down","Auto"] select ((_x get3DENAttribute "UnitPos") select 0);

					if ((isNull (objectParent _x)) || !((objectParent _x) in (get3DENSelected "object"))) then {
						_units pushBack [GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _stance, _special];
					};
				};
			};
		};

		case 2: { // Objects
			if ((_x isKindOf "All") && !(_x isKindOf "CAManBase")) then {
				private _special = ([_x] call FUNC(getAttributes));

				(vectorDir _x) params ["_dirX","_dirY","_dirZ"];
				(vectorUp _x) params ["_upX","_upY","_upZ"];

				_objects pushBack [GETATTRIBUTE("itemClass"), (getPosWorld _x), [((_x call BIS_fnc_getPitchBank) + [(getDir _x)]), GETATTRIBUTE("rotation")], _special, GETATTRIBUTE("objectIsSimple")];
//				_objects pushBack [GETATTRIBUTE("itemClass"), (getPosWorld _x), [CUT_XYZ(_dirX,_dirY,_dirZ), CUT_XYZ(_upX,_upY,_upZ)], _special, GETATTRIBUTE("objectIsSimple")];
			};
		};
	};
} forEach (get3DENSelected "object");

switch (_type) do {
	case 1: {
		_objects = (get3DENSelected "object") select {(_x isKindOf "CAManBase")};
		_side = "civilian";
		if (_objects isEqualTo []) then {
			_crew = (get3DENSelected "object") select {count (crew _x) > 0};
			if !(_crew isEqualTo []) then {
				_side = str(side (_crew select 0));
			};
		} else {
			_side = str(side(_objects select 0));
		};
		if (_side isEqualTo "CIV") then {
			_side = "civilian";
		};
		if (_side isEqualTo "GUER") then {
			_side = "independent";
		};

		_return = (str([_side, _units, _vehicles, []]) + (" call GW_Common_fnc_addToSpawnList;"));
		TRACE_1("Units", _units);
		TRACE_1("Vehicles", _vehicles);
		systemChat format ["Copy Static: %3, %1 units, %2 vehicles copied", (count _units), (count _vehicles), _side];
	};
	case 2: {
		_return = (str(_objects) + (" call GW_Common_fnc_spawnObjects;"));
		TRACE_1("Objects", _objects);
		systemChat format ["Copy Objects: %1 objects copied", (count _objects)];
	};
};

if ("Preferences" get3DENMissionAttribute "GW_DeleteOnCopy") then {
	_delete = (get3DENSelected "object") + (get3DENSelected "group");
	delete3DENEntities _delete;
};

if ("Preferences" get3DENMissionAttribute "GW_CopyToClipboard") then {
	copyToClipboard _return;
};

if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleLog") then {
	"debug_console" callExtension (_return + "#1111");
};

if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleFile") then {
	"debug_console" callExtension (_return + "~0001");
};

[(str _this),QFUNC(copyStatic)] call FUNC(uiSaveFunction);
