#include "script_Component.hpp"
/*
	Loop the GOL Mobile HQ satellite sweep while the MHQ is active.
	Called on the dedicated server, which is authoritative for these sources.

	Arguments:
	0: MHQ object <OBJECT>
	1: Enable loop <BOOL>
*/

params ["_mhq", ["_enabled", false, [false]]];

if (isNull _mhq || {typeOf _mhq isNotEqualTo "GOL_Mobile_HQ"}) exitWith {false};

private _loopId = (_mhq getVariable [QGVAR(SatelliteLoopId), 0]) + 1;
_mhq setVariable [QGVAR(SatelliteLoopId), _loopId];

if !_enabled exitWith {true};

[_mhq, _loopId] spawn {
	params ["_mhq", "_loopId"];

	while {
		!isNull _mhq
		&& {(_mhq getVariable [QGVAR(SatelliteLoopId), -1]) isEqualTo _loopId}
	} do {
		_mhq animateSource ["Terminal_source", 100, false];
		waitUntil {
			sleep 0.1;
			isNull _mhq
			|| {(_mhq getVariable [QGVAR(SatelliteLoopId), -1]) isNotEqualTo _loopId}
			|| {(_mhq animationSourcePhase "Terminal_source") >= 99.9}
		};
		if (isNull _mhq || {(_mhq getVariable [QGVAR(SatelliteLoopId), -1]) isNotEqualTo _loopId}) exitWith {};

		_mhq animateSource ["Terminal_source", 45, false];
		waitUntil {
			sleep 0.1;
			isNull _mhq
			|| {(_mhq getVariable [QGVAR(SatelliteLoopId), -1]) isNotEqualTo _loopId}
			|| {(_mhq animationSourcePhase "Terminal_source") <= 45.1}
		};
	};
};

true
