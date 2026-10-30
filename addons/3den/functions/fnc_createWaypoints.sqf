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
	["_profile", "", [""]],
	["_patternOverride", "", [""]]
];

_radiusMul = (_radiusMul max 0.1) min 10;
_profile = toUpper _profile;

private _isDebug = "GW_MissionPreferences" get3DENMissionAttribute "GW_isDebug";
if !(_isDebug isEqualType true) then { _isDebug = false; };

private _dbg = {
	params ["_msg", ["_a", ""], ["_b", ""], ["_c", ""]];
	if (_isDebug) then {
		diag_log format ["[GW_3DEN][createWaypoints] %1%2%3%4", _msg, _a, _b, _c];
	};
};

private _pattern = "";
if !(_patternOverride isEqualTo "") then {
	_pattern = toUpper _patternOverride;
} else {
	_pattern = "Preferences" get3DENMissionAttribute "GW_WaypointPattern";
	if !(_pattern isEqualType "") then { _pattern = "CIRCLE"; };
	_pattern = toUpper _pattern;
};

if !(_pattern in ["CIRCLE","TRIANGLE","RECTANGLE","COLUMN"]) then { _pattern = "CIRCLE"; };

["init | args=", str _args, " | pattern=", _pattern] call _dbg;

private _radius = "Preferences" get3DENMissionAttribute "GW_WaypointRadius";
if !(_radius isEqualType 0) then { _radius = 200; };
_radius = _radius * _radiusMul;
if !(_radius isEqualType 0) then { _radius = 200; };

private _waypointCount = "Preferences" get3DENMissionAttribute "GW_WaypointCount";
if !(_waypointCount isEqualType 0) then { _waypointCount = 6; };
_waypointCount = (_waypointCount max 2) min 20;

["prefs | radiusMul=", str _radiusMul, " radius=", str _radius] call _dbg;
["prefs | waypointCount=", str _waypointCount, " profile=", _profile] call _dbg;

private _positions = [];

private _isValidNum = {
	params ["_n"];
	(_n isEqualType 0) && { _n == _n }
};

private _sanitizePos = {
	params ["_p", "_fallback"];
	if !(_p isEqualType [] && { (count _p) >= 2 }) exitWith { _fallback };
	private _x = _p select 0;
	private _y = _p select 1;
	if ([_x] call _isValidNum && {[_y] call _isValidNum}) exitWith { [_x, _y, 0] };
	if (_isDebug) then {
		diag_log format ["[GW_3DEN][createWaypoints] sanitizePos fallback | in=%1 fallback=%2", _p, _fallback];
	};
	_fallback
};

private _posAtDistOnPoly = {
	params ["_verts", "_dist"]; // _verts: [[x,y],...]
	private _count = count _verts;
	if (_count < 2) exitWith { [0,0] };

	private _remaining = _dist;
	private _out = _verts select 0;
	private _found = false;
	for "_j" from 0 to (_count - 1) do {
		if (_found) then { } else {
			private _a = _verts select _j;
			private _b = _verts select ((_j + 1) mod _count);
			private _validVerts = _a isEqualType [] && {count _a >= 2} && {_b isEqualType []} && {count _b >= 2};
			if (_validVerts) then {
			private _dx = (_b select 0) - (_a select 0);
			private _dy = (_b select 1) - (_a select 1);
			private _len = sqrt (_dx*_dx + _dy*_dy);
			// Guard against NaN/invalid lengths.
			if !(_len isEqualType 0 && {_len == _len}) then {
				if (_isDebug) then {
					diag_log format ["[GW_3DEN][createWaypoints] invalid segment len=%1 dx=%2 dy=%3 a=%4 b=%5", _len, _dx, _dy, _a, _b];
				};
				_len = 0;
			};
			if (_len > 0.001) then {
				if (_remaining <= _len) then {
					private _div = _len;
					if !(_div isEqualType 0 && {_div == _div} && {_div > 0}) then { _div = 0.001; };
					private _num = _remaining;
					if !(_num isEqualType 0 && {_num == _num}) then { _num = 0; };
					private _t = 0;
					// Never divide unless divisor is a valid positive number (SQF can still throw "Zero divisor" for NaN/0).
					if (_div isEqualType 0 && {_div == _div} && {_div > 0}) then {
						_t = _num / _div;
					} else {
						if (_isDebug) then {
							diag_log format ["[GW_3DEN][createWaypoints] skip division | num=%1 div=%2 len=%3 remaining=%4", _num, _div, _len, _remaining];
						};
					};
					// Harden interpolation: enforce scalar validity and remove any operator-precedence ambiguity around `select`.
					if !(_t isEqualType 0 && {_t == _t}) then { _t = 0; };
					_t = (_t max 0) min 1;
					if !(_dx isEqualType 0 && {_dx == _dx}) then { _dx = 0; };
					if !(_dy isEqualType 0 && {_dy == _dy}) then { _dy = 0; };
					private _ax = _a select 0;
					private _ay = _a select 1;
					if !(_ax isEqualType 0 && {_ax == _ax}) then { _ax = 0; };
					if !(_ay isEqualType 0 && {_ay == _ay}) then { _ay = 0; };
					_out = [_ax + (_dx * _t), _ay + (_dy * _t)];
					_found = true;
				} else {
					_remaining = _remaining - _len;
				};
			};
			} else {
				if (_isDebug) then {
					diag_log format ["[GW_3DEN][createWaypoints] invalid verts | j=%1 verts=%2", _j, _verts];
				};
			};
		};
	};
	if (_isDebug && {!_found}) then {
		diag_log format ["[GW_3DEN][createWaypoints] posAtDistOnPoly not found | dist=%1 verts=%2", _dist, _verts];
	};
	_out
};

private _polyPerimeter = {
	params ["_verts"]; // [[x,y],...]
	private _p = 0;
	private _count = count _verts;
	if (_count < 2) exitWith { 0 };
	for "_j" from 0 to (_count - 1) do {
		private _a = _verts select _j;
		private _b = _verts select ((_j + 1) mod _count);
		private _dx = (_b select 0) - (_a select 0);
		private _dy = (_b select 1) - (_a select 1);
		private _len = sqrt (_dx*_dx + _dy*_dy);
		if (_len > 0.001) then { _p = _p + _len; };
	};
	_p
};

private _rotate2D = {
	params ["_p", "_deg"]; // [x,y]
	// SQF trig uses degrees.
	private _c = cos _deg;
	private _s = sin _deg;
	private _x = _p select 0;
	private _y = _p select 1;
	[_x * _c - _y * _s, _x * _s + _y * _c]
};

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

// Build waypoint positions (MOVE x (count-1) + final CYCLE).
private _origin = getPosATL _leader;
private _dir = getDir _leader;
private _originSafe = [_origin, _origin] call _sanitizePos;

["leader | origin=", str _originSafe, " dir=", str _dir] call _dbg;

private _minCount = switch (_pattern) do {
	case "TRIANGLE": { 4 };   // 3 corners + cycle back to first
	case "RECTANGLE": { 5 };  // 4 corners + cycle back to first
	default { 2 };             // CIRCLE/COLUMN
};

if (_waypointCount < _minCount) then {
	[format ["Waypoint Count increased to %1 for %2 pattern", _minCount, _pattern], 0, 5, false] call BIS_fnc_3DENNotification;
	_waypointCount = _minCount;
};

private _wpMoveCount = _waypointCount - 1;

["computed | minCount=", str _minCount, " waypointCount=", str _waypointCount] call _dbg;
["computed | wpMoveCount=", str _wpMoveCount] call _dbg;

switch (_pattern) do {
	case "TRIANGLE": {
		// Equilateral triangle around leader; rotated with leader direction.
		private _r = _radius;
		private _verts = [
			[0, _r],
			[-0.8660254 * _r, -0.5 * _r],
			[0.8660254 * _r, -0.5 * _r]
		];
		private _rot = _dir;
		private _vertsR = _verts apply { [_x, _rot] call _rotate2D };
		private _per = [_vertsR] call _polyPerimeter;
		["triangle | vertsR=", str _vertsR, " per=", str _per] call _dbg;
		if (_per <= 0.001) then { _pattern = "CIRCLE"; } else {
			private _step = _per / _wpMoveCount;
			["triangle | step=", str _step] call _dbg;
			for "_i" from 0 to (_wpMoveCount - 1) do {
				private _dist = _step * _i;
				private _p2 = [_vertsR, _dist] call _posAtDistOnPoly;
				private _pos = [
					(_originSafe select 0) + (_p2 select 0),
					(_originSafe select 1) + (_p2 select 1),
					0
				];
				_positions pushBack ([_pos, _originSafe] call _sanitizePos);
			};
			// Cycle back to first waypoint position
			_positions pushBack (_positions select 0);
		};
	};
	case "RECTANGLE": {
		private _r = _radius;
		private _verts = [
			[-_r, -_r],
			[_r, -_r],
			[_r, _r],
			[-_r, _r]
		];
		private _rot = _dir;
		private _vertsR = _verts apply { [_x, _rot] call _rotate2D };
		private _per = [_vertsR] call _polyPerimeter;
		["rectangle | vertsR=", str _vertsR, " per=", str _per] call _dbg;
		if (_per <= 0.001) then { _pattern = "CIRCLE"; } else {
			private _step = _per / _wpMoveCount;
			["rectangle | step=", str _step] call _dbg;
			for "_i" from 0 to (_wpMoveCount - 1) do {
				private _dist = _step * _i;
				private _p2 = [_vertsR, _dist] call _posAtDistOnPoly;
				private _pos = [
					(_originSafe select 0) + (_p2 select 0),
					(_originSafe select 1) + (_p2 select 1),
					0
				];
				_positions pushBack ([_pos, _originSafe] call _sanitizePos);
			};
			_positions pushBack (_positions select 0);
		};
	};
	case "COLUMN": {
		// Straight out-and-back line along leader direction.
		// Example: with 10 total waypoints -> 9 MOVE points -> 5 out, 4 back, then CYCLE to first.
		private _outCount = ceil (_wpMoveCount / 2);
		private _backCount = _wpMoveCount - _outCount;
		private _vd = vectorDir _leader;
		private _vx = _vd select 0;
		private _vy = _vd select 1;
		if !(_vx isEqualType 0 && {_vx == _vx}) then { _vx = 0; };
		if !(_vy isEqualType 0 && {_vy == _vy}) then { _vy = 1; };
		["column | out=", str _outCount, " back=", str _backCount] call _dbg;
		["column | v=", str [_vx, _vy], " radius=", str _radius] call _dbg;

		if (_outCount > 0) then {
			private _stepOut = _radius / _outCount;
			for "_i" from 1 to _outCount do {
				private _dist = _i * _stepOut;
				private _pos = [
					(_originSafe select 0) + (_vx * _dist),
					(_originSafe select 1) + (_vy * _dist),
					0
				];
				_positions pushBack ([_pos, _originSafe] call _sanitizePos);
			};
		};

		if (_backCount > 0) then {
			private _stepBack = _radius / _backCount;
			for "_i" from 1 to _backCount do {
				private _dist = _radius - (_i * _stepBack);
				private _pos = [
					(_originSafe select 0) + (_vx * _dist),
					(_originSafe select 1) + (_vy * _dist),
					0
				];
				_positions pushBack ([_pos, _originSafe] call _sanitizePos);
			};
		};

		// Cycle back to first waypoint position
		_positions pushBack (_positions select 0);
	};
	default {
		// CIRCLE
		private _step = 360 / _wpMoveCount;
		["circle | stepDeg=", str _step] call _dbg;
		for "_i" from 0 to (_wpMoveCount - 1) do {
			private _pos = (_leader getRelPos [_radius, _step * _i]);
			_positions pushBack ([_pos, _originSafe] call _sanitizePos);
		};
		_positions pushBack (_positions select 0);
	};
};

if ((count _positions) < _waypointCount) exitWith {
	["Failed to build waypoint positions", 1, 5, false] call BIS_fnc_3DENNotification;
	false
};

collect3DENHistory {
	for "_i" from 1 to _waypointCount do {
		private "_waypoint";
		private _pos = [_positions select (_i - 1), _originSafe] call _sanitizePos;
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
