#include "script_component.hpp"

params [["_detailLevel", 1, [0]], ["_interval", 1, [0]]];
private _markers = [];

while {GVAR(Enabled)} do {
	private ["_doneObjs", "_sigTerm"];
	_doneObjs = [];
	waitUntil {
		_sigTerm = GVAR(sigTerm);
		visibleMap || {shownGPS} || {GVAR(constantUpdate)} || {_sigTerm};
	};

	{
		_x params ["_obj", "_marker", "_alive", "_side", "_isPlayer"];

		if ( // Object has changed state or script is ending
			_sigTerm || // Script ending
			{isNull _obj} || // Object deleted
			{(side _obj) != _side} || // Changed sides
			{(vehicle _obj) != _obj} || // Switched vehicles
			{!([(alive _obj), _alive] call FUNC(compareBool))} || // Died or was revived
			{!([(isPlayer _obj), _isPlayer] call FUNC(compareBool))} // Changed playable status
		) then { // Delete marker
			deleteMarkerLocal _marker;
			_markers set [_forEachIndex, objNull];
		} else { // Keep marker
			_doneObjs set [(count _doneObjs), _obj];
			private ["_objPos", "_mrkPos"];
			_objPos = getPos _obj;
			_mrkPos = getMarkerPos _marker;
			if ( // Object has moved
				((getDir _obj) != (markerDir _marker)) ||
				{((_objPos select 0) != (_mrkPos select 0)) || {(_objPos select 1) != (_mrkPos select 1)}}
			) then { // Update marker position if needed
				_marker setMarkerPosLocal _objPos;
				_marker setMarkerDirLocal (getDir _obj);
			};
			if ((_obj isKindOf "CAManBase") && (alive _obj)) then {
				_color = ([_obj] call FUNC(getSideColor));
				if (_color != getMarkerColor _marker) then {
					_marker setMarkerColorLocal _color;
				};
			};
		};
	} forEach _markers;

	_markers = _markers - [objNull];
	/* Exit if received termination signal */
	if (_sigTerm) exitWith {
		GVAR(sigTerm) = false;
	};

	if (visibleMap || GVAR(constantUpdate)) then { // Repaint map markers
		{
			if (alive _x) then {
				[_x] call FUNC(addFiredEH);
				private ["_playerStat"];
				_playerStat = _x getVariable QGVAR(playerStat);
				if ((isNil "_playerStat") || {!([(isPlayer _x), (_playerStat select 1)] call FUNC(compareBool))}) then {
					_x setVariable [QGVAR(playerStat), [(name _x), (isPlayer _x)], true];
				};
				if (!(_x in _doneObjs) && {(vehicle _x) isEqualTo _x}) then {
					private ["_color", "_type", "_marker"];
					_color = [_x] call FUNC(getSideColor);
					_type = if (isPlayer _x) then {"mil_arrow2"} else {"mil_arrow"};
					_marker = [_markers, _x, _type, _color, [0.4, 0.4], MARKER_ALPHA] call FUNC(paintObjMarker);
					if (_detailLevel >= 1) then {
						if ((isPlayer _x) || {_detailLevel >= 3}) then {
							_marker setMarkerTextLocal (name _x);
						};
					};
				};
			};
		} forEach allUnits;		/* Paint unit map markers */

		{
			if (!(_x in _doneObjs)) then {
				private ["_marker", "_playerStat"];
				_marker = [_markers, _x, "mil_arrow", "ColorBlack", [0.4, 0.4], MARKER_ALPHA] call FUNC(paintObjMarker);
				_playerStat = _x getVariable QGVAR(playerStat);
				if ((_detailLevel >= 1) && {!isNil "_playerStat"}) then {
					if ((_playerStat select 1) || {_detailLevel >= 3}) then {
						_marker setMarkerTextLocal (_playerStat select 0);
					};
				};
			};
		} forEach allDead;		/* Paint dead map markers */

		{
			if (_x isKindOf "AllVehicles") then {
				private _color = "ColorBlack";
				if (alive _x) then {
					[_x] call FUNC(addFiredEH);
					_color = [_x] call FUNC(getSideColor);
				};
				if (!(_x in _doneObjs)) then {
					private ["_type", "_marker"];
					_type = switch (true) do {
						case (_x isKindOf "StaticWeapon"): {"b_inf"};
						case (_x isKindOf "Car"): {"b_motor_inf"};
						case (_x isKindOf "Tank"): {"b_armor"};
						case (_x isKindOf "Helicopter"): {"b_air"};
						case (_x isKindOf "Plane"): {"b_plane"};
						default {"b_unknown"};
					};
					_marker = [_markers, _x, _type, _color, [0.8, 0.8], MARKER_ALPHA] call FUNC(paintObjMarker);
					if (_detailLevel >= 1) then {
						if (((count (crew _x)) > 0) && {isPlayer((crew _x) select 0)}) then {
						_marker setMarkerTextLocal (name ((crew _x) select 0));
						} else {
							if (_detailLevel >= 2) then {
//								_marker setMarkerTextLocal ('"' + (typeOf(_x)) + '"');
								if (count (crew _x) > 0) then {
									_marker setMarkerTextLocal format ["(%2) '%1'", (typeOf _x), count (crew _x)];
								} else {
									_marker setMarkerTextLocal format ["'%1'", (typeOf _x)];
								};
							};
						};
					};
				};
			};
		} forEach vehicles;		/* Paint vehicle map markers */
	};
	uiSleep _interval;
};

GVAR(Enabled) = false;
