#include "script_component.hpp"

private ["_distance", "_dir", "_color", "_markerLine", "_markerEnd"];
params ["_unit","_startPos","_endPos",["_startTime", 0], ["_endTime", GVAR(bulletMaxFlighttime)]];

_distance = if (isNil "_endPos") then {
	private ["_cfg"];
	_cfg = configFile >> typeOf(_projectile) >> "typicalspeed";
	if (isNumber(_cfg)) then {
			getNumber(_cfg) * (_endTime - _startTime); // Estimate range
	} else {
			300; // Average range of aprox. 150 meters
	};
} else {
	/* Delete 3rd Dimension */
	_startPos set [2, 0];
	_endPos set [2, 0];
	_startPos distance _endPos;
};
_distance = _distance / 2; // Due to marker mechanics
_dir = ((_endPos select 0) - (_startPos select 0)) atan2 ((_endPos select 1) - (_startPos select 1));
_color = [_unit] call FUNC(getSideColor);
/* Create line marker */
_markerLine = createMarkerLocal [format["shot_line_%1_%2_%3", _unit, random(100), diag_tickTime], [
	((_startPos select 0) + (_distance * sin(_dir))),
	((_startPos select 1) + (_distance * cos(_dir))),
	0
]];
_markerLine setMarkerShapeLocal 'RECTANGLE';
_markerLine setMarkerColorLocal _color;
_markerLine setMarkerDirLocal _dir;
_markerLine setMarkerSizeLocal [BULLET_MARKER_THICKNESS, _distance];
_markerLine setMarkerAlphaLocal MARKER_ALPHA;
/* Create line-end-dot marker */
_markerEnd = createMarkerLocal [format["shot_end_%1_%2_%3", _unit, random(100), diag_tickTime], _endPos];
_markerEnd setMarkerShapeLocal 'ELLIPSE';
_markerEnd setMarkerColorLocal _color;
_markerEnd setMarkerSizeLocal [(BULLET_MARKER_THICKNESS * 3), (BULLET_MARKER_THICKNESS * 3)];
_markerEnd setMarkerAlphaLocal MARKER_ALPHA;
[_markerLine, _markerEnd]
