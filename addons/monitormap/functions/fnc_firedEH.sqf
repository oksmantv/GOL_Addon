#include "script_component.hpp"

if (GVAR(Enabled)) then {
	params ["_unit","","","","","","_projectile"];
	[_unit, _projectile, (getPos _projectile), time] spawn {
		private ["_endTime", "_markers", "_trackProj"];
		params ["_unit","_projectile","_startPos","_startTime"];
		_endTime = (time + GVAR(bulletMaxFlighttime));
		_markers = [];
		_trackProj = true;
		while {_trackProj} do {
			_trackProj = !((isNull _projectile) || {!(alive _projectile)} || {time > _endTime});
			if (_trackProj) then {
				{deleteMarkerLocal _x} forEach _markers;
				_markers = [_unit, _startPos, (getPos _projectile), _startTime, time] call FUNC(drawBulletMarker);
				uiSleep (1/GVAR(bulletMarkerRefreshRate));
			} else {
				uiSleep GVAR(bulletMarkerLifetime);
				{deleteMarkerLocal _x} forEach _markers;
			};
		};
	};
};
