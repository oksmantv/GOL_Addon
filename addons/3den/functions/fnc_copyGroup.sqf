#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Copy units, vehicles and waypoints
	
	Usage:
	[] call GW_3den_fnc_copyGroup;
	
	Arguments: NO
	
	Return Value: YES <ARRAY>
	#0:ARRAY - units [pos, dir]
	#1:ARRAY - vehicles[class, pos, dir]
	#2:ARRAY - waypoints[pos, type, behaviour, combatMode, completionRadius, formation, speedMode]
	
	Public: NO
	
https// community.bistudio.com/wiki/get3DENSelected
https// community.bistudio.com/wiki/Eden_Editor:_Setting_Attributes#Trigger
	
	typeitemClass
	Descriptiondescription
	Orderorder
	Identifiedname
	positionposition
	Placement RadiusplacementRadius
	Completion RadiuscompletionRadius
	Combat ModecombatMode
	Behaviorbehaviour
	formationformation
	speedModespeedMode
	Conditioncondition
	On ActivationonActivation
	Scriptscript
	Map Visibilityshow2D
	Scene Visibilityshow3D
	Timer valuestimeout
	Effect ConditioneffectCondition
	Soundsound
	Voicevoice
	EnvironmentsoundEnvironment
	Musicmusic
	UI Overlaytitle
*/
#define	GETATTRIBUTE(Var) ((_x get3DENAttribute Var) select 0)

private _units = [];
private _groupWaypoint = [];
private _vehicles = [];

private _waypoints = [];
private _grps = [];

{
	if !(isNull(group _x)) then {
		_grps pushBackUnique (group _x);
	};
} forEach (get3DENSelected "object");

if ((count _grps) > 1) then {
	["Multiple groups selected, Could not copy waypoints", 1, 5, true] call BIS_fnc_3DENNotification;
} else {
	{
		if ((_x select 0) isEqualTo (_grps select 0)) then {
			_waypoints pushBack _x;
		};
	} forEach (all3DENEntities select 4);
};

{
	if (_x isKindOf "AllVehicles") then {
		private _special = [];

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

			_special = ([_x, false] call FUNC(getAttributes));
			_vehicles pushBack [GETATTRIBUTE("itemClass"), GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _crewList, _special];
		};

		 if (_x isKindOf "CAManBase") then {
			// Infantry only
			if ((isNull (objectParent _x)) || !((objectParent _x) in (get3DENSelected "object"))) then {
				if ((count _units) isEqualTo 0) then {
					_special = ([_x, true] call FUNC(getAttributes));
				} else {
					_special = ([_x, false] call FUNC(getAttributes));
				};
				if ("Preferences" get3DENMissionAttribute "GW_CopyRoles") then {
					_role = [_x] call FUNC(getLoadoutClass);
					_units pushBack [GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _special, _role];
				} else {
					_units pushBack [GETATTRIBUTE("position"), round(GETATTRIBUTE("rotation") select 2), _special];
				}
			};
		};
	};
} forEach (get3DENSelected "object");

{
	private _waypointSettings = [];
	TRACE_1("New Waypoint", _x);

	private _type = (GETATTRIBUTE("itemClass"));
	if (_type isEqualTo "SeekAndDestroy") then {
		_type = "SAD";
	};
	if (_type isEqualTo "Transport UNLOAD") then {
		_type = "TR UNLOAD";
	};
	if (_type isEqualTo "lambs_danger_CQB") then {
		_type = "SCRIPTED";
		// insert LAMBS CQB WP Code
	};
	_waypointSettings pushBack [0, _type];

	if !(GETATTRIBUTE("behaviour") isEqualTo "UNCHANGED") then {
		_waypointSettings pushBack [1, GETATTRIBUTE("behaviour")];
	};

	if !(GETATTRIBUTE("combatMode") isEqualTo "NO CHANGE") then {
		_waypointSettings pushBack [2, GETATTRIBUTE("combatMode")];
	};

	if !(GETATTRIBUTE("completionRadius") isEqualTo 0) then {
		_waypointSettings pushBack [3, GETATTRIBUTE("completionRadius")];
	};

	if !(GETATTRIBUTE("formation") isEqualTo 0) then {
		_formation = ["NO CHANGE", "WEDGE", "VEE", "LINE", "COLUMN", "FILE", "STAG COLUMN", "ECH LEFT", "ECH RIGHT", "DIAMOND"] select GETATTRIBUTE("formation");
		_waypointSettings pushBack [4, _formation];
	};

	if !(GETATTRIBUTE("speedMode") isEqualTo 0) then {
		_speed = ["UNCHANGED", "LIMITED", "NORMAL", "FULL"] select GETATTRIBUTE("speedMode");
		_waypointSettings pushBack [5, _speed];
	};

	if !(GETATTRIBUTE("timeout") isEqualTo [0, 0, 0]) then {
		_waypointSettings pushBack [6, GETATTRIBUTE("timeout")];
	};

	// if (!(GETATTRIBUTE("condition") isEqualTo "true") || !(GETATTRIBUTE("onActivation") isEqualTo "")) then {
		if ((!(GETATTRIBUTE("condition") isEqualTo "call{
			true
		}") || !(GETATTRIBUTE("condition") isEqualTo "true")) && !(GETATTRIBUTE("onActivation") isEqualTo "")) then {
			_waypointSettings pushBack [7, [GETATTRIBUTE("condition"), GETATTRIBUTE("onActivation")]];
		};

		_groupWaypoint pushBack ([(GETATTRIBUTE("position"))] + [_waypointSettings]);
	} forEach _waypoints;

	_objects = (get3DENSelected "object") select {
		(_x isKindOf "CAManBase")
	};
	_side = civilian;
	if (_objects isEqualTo []) then {
		_crew = (get3DENSelected "object") select {
			count (crew _x) > 0
		};
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

	_return = format ["[%1,%2,%3,%4] call GW_Common_fnc_spawnGroup;", str(_units), str(_vehicles), str(_groupWaypoint), _sideStr];

	private _cache = uiNamespace getVariable ["OKS_3DEN_CLIPBOARD_CACHE", []];
	if !(_cache isEqualType []) then { _cache = [] };
	_cache pushBack _return;
	uiNamespace setVariable ["OKS_3DEN_CLIPBOARD_CACHE", _cache];
	private _cacheCount = count _cache;

	private _deleteOnCopy = uiNamespace getVariable ["GW_DeleteOnCopy", ("Preferences" get3DENMissionAttribute "GW_DeleteOnCopy")];
	if (_deleteOnCopy) then {
		_delete = (get3DENSelected "object") + (get3DENSelected "waypoint") + (get3DENSelected "group");
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

	[[], QFUNC(copyGroup)] call FUNC(uiSaveFunction);

	systemChat format ["Copy Group: %4, %1 units, %2 vehicles, %3 waypoints copied (Cache=%5)", (count _units), (count _vehicles), (count _groupWaypoint), _sideStr, _cacheCount];
	[format ["Copy Group: %4: %1 units, %2 vehicles, %3 waypoints copied (Cache=%5)", (count _units), (count _vehicles), (count _groupWaypoint), _sideStr, _cacheCount], 0, 5, true, 0.5] call BIS_fnc_3DENNotification;

	TRACE_1("Units", _units);
	TRACE_1("Waypoints", _groupWaypoint);
	TRACE_1("Objects", _vehicles);