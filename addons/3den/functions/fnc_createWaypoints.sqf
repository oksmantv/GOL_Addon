#include "script_component.hpp"
/*
	Author: GuzzenVonLidl

	Description:
	Creates waypoints around highlighted group in a set radius around them

	Usage:
	[] spawn GW_3den_fnc_createWaypoints;

	Parameters: None

	Return Value: None

	Public: NO
*/
private _args = _this;
if (isNil "_args") then { _args = []; };
if !(_args isEqualType []) then { _args = [_args]; };

_args params [
	["_leaderParam", objNull, [objNull]],
	["_radiusMul", 1, [0]],
	["_profile", "", [""]]
];

_radiusMul = (_radiusMul max 0.1) min 10;
_profile = toUpper _profile;

private _radius = "Preferences" get3DENMissionAttribute "GW_WaypointRadius";
if !(_radius isEqualType 0) then { _radius = 200; };
_radius = _radius * _radiusMul;

private _waypointCount = "Preferences" get3DENMissionAttribute "GW_WaypointCount";
if !(_waypointCount isEqualType 0) then { _waypointCount = 6; };
_waypointCount = (_waypointCount max 2) min 20;

private _leader = objNull;

if (!isNull _leaderParam) then {
	_leader = _leaderParam;
} else {
	private _sel = (get3DENSelected "object");
	if (_sel isEqualTo []) exitWith {
		["No group selected", 1, 5, false] call BIS_fnc_3DENNotification;
		false
	};
	_leader = leader (_sel select 0);
};

if (isNull _leader) exitWith {
	["Invalid leader for waypoints", 1, 5, false] call BIS_fnc_3DENNotification;
	false
};
collect3DENHistory {
	for "_i" from 1 to _waypointCount do {
		private "_waypoint";
		private _pos = (_leader getRelPos [_radius, (360/_waypointCount) * _i]);
		if !(_waypointCount isEqualTo _i) then {
			_waypoint = (group _leader) create3DENEntity ["Waypoint","MOVE", _pos];
			_waypoint set3DENAttribute ["timeout", [0,3,6]];
			if (_i isEqualTo 1) then {
				if (_profile isEqualTo "FAST") then {
					_waypoint set3DENAttribute ["formation", 5];	// File
					_waypoint set3DENAttribute ["speedMode", 3];	// Fast
					_waypoint set3DENAttribute ["behaviour", "AWARE"];
				} else {
					_waypoint set3DENAttribute ["formation", 5];	// File
					_waypoint set3DENAttribute ["speedMode", 1];	// Slow
					_waypoint set3DENAttribute ["behaviour", "SAFE"];
				};
			};
		} else {
			_waypoint = (group _leader) create3DENEntity ["Waypoint","CYCLE", _pos];
		};
	};
};

[(str _this),QFUNC(createWaypoints)] call FUNC(uiSaveFunction);

true
