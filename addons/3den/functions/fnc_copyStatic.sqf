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
private _groups = [];

{
	private _group = group _x;
	if !(isNull _group) then {
		_groups pushBackUnique _group;
	};
} forEach (get3DENSelected "object");

private _groupCallsigns = (_groups apply { groupId _x }) select { !(_x isEqualTo "") };
private _groupText = if (_groupCallsigns isEqualTo []) then { "No group" } else { _groupCallsigns joinString ", " };

{
	private _special = [];
	switch (_type) do {
		case 1: {
			// Units && Vehicles
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
						if ("Preferences" get3DENMissionAttribute "GW_CopyRoles") then {
							_role = [_x] call FUNC(getLoadoutClass);
							_units pushBack [GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _stance, _special, _role];
						} else {
							_units pushBack [GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _stance, _special];
						}	
					};
				};
			};
		};

		case 2: {
			// Objects
			if ((_x isKindOf "All") && !(_x isKindOf "CAManBase")) then {
				private _special = ([_x] call FUNC(getAttributes));

				(vectorDir _x) params ["_dirX","_dirY","_dirZ"];
				(vectorUp _x) params ["_upX","_upY","_upZ"];

				_objects pushBack [GETATTRIBUTE("itemClass"), (getPosWorld _x), [((_x call BIS_fnc_getPitchBank) + [(getDir _x)]), GETATTRIBUTE("rotation")], _special, GETATTRIBUTE("objectIsSimple")];
			};
		};
	};
} forEach (get3DENSelected "object");

switch (_type) do {
	case 1: {
		_objects = (get3DENSelected "object") select {(_x isKindOf "CAManBase")};
		_side = civilian;
		if (_objects isEqualTo []) then {
			_crew = (get3DENSelected "object") select {count (crew _x) > 0};
			if !(_crew isEqualTo []) then {
				_side = side (_crew select 0);
			};
		} else {
			_side = side (_objects select 0);
		};

		_sideStr = switch (_side) do {
			case west: {"west"};
			case east: {"east"};
			case independent: {"independent"};
			case civilian: {"civilian"};
			default {"civilian"};
		};

		_return = format ["[%1,%2,[],%3] call GW_Common_fnc_spawnGroup; // 3DEN | %4 | Groups: %5 | U:%6 V:%7", str(_units), str(_vehicles), _sideStr, toUpper _sideStr, _groupText, count _units, count _vehicles];
		private _cache = uiNamespace getVariable ["OKS_3DEN_CLIPBOARD_CACHE", []];
		if !(_cache isEqualType []) then { _cache = [] };
		_cache pushBack _return;
		uiNamespace setVariable ["OKS_3DEN_CLIPBOARD_CACHE", _cache];
		private _cacheCount = count _cache;
		TRACE_1("Units", _units);
		TRACE_1("Vehicles", _vehicles);
		private _copyText = format ["Copy Static | %1 | %2 | U:%3 V:%4 | Cache:%5", toUpper _sideStr, _groupText, count _units, count _vehicles, _cacheCount];
		systemChat _copyText;
		[_copyText, 0, 5, true] call BIS_fnc_3DENNotification;
	};
	case 2: {
		_return = format ["%1 call GW_Common_fnc_spawnObjects; // 3DEN | Groups: %2 | O:%3", str _objects, _groupText, count _objects];
		private _cache = uiNamespace getVariable ["OKS_3DEN_CLIPBOARD_CACHE", []];
		if !(_cache isEqualType []) then { _cache = [] };
		_cache pushBack _return;
		uiNamespace setVariable ["OKS_3DEN_CLIPBOARD_CACHE", _cache];
		private _cacheCount = count _cache;
		TRACE_1("Objects", _objects);
		private _copyText = format ["Copy Objects | %1 | O:%2 | Cache:%3", _groupText, count _objects, _cacheCount];
		systemChat _copyText;
		[_copyText, 0, 5, true] call BIS_fnc_3DENNotification;
	};
	default {
		systemChat "Copy Static: No valid copy mode selected!";
		[format["Copy Static: No valid copy mode selected!", (count _objects)], 0, 5, true] call BIS_fnc_3DENNotification;
	}
};

private _deleteOnCopy = uiNamespace getVariable ["GW_DeleteOnCopy", ("Preferences" get3DENMissionAttribute "GW_DeleteOnCopy")];
if (_deleteOnCopy) then {
	_delete = (get3DENSelected "object") + (get3DENSelected "group");
	delete3DENEntities _delete;
};

if ("Preferences" get3DENMissionAttribute "GW_CopyToClipboard") then {
	if(_return isEqualTo 0) exitWith {
		systemChat "Copy Static: Nothing to copy to clipboard!";
	};
	copyToClipboard _return;
};

if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleLog") then {
	"debug_console" callExtension (_return + "#1111");
};

if ("Preferences" get3DENMissionAttribute "GW_PrintToConsoleFile") then {
	"debug_console" callExtension (_return + "~0001");
};

[(str _this),QFUNC(copyStatic)] call FUNC(uiSaveFunction);
