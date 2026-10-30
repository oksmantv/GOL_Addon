#include "script_Component.hpp"
/*
	Play the vanilla upload-terminal loop locally while the GOL Mobile HQ is active.

	Arguments:
	0: MHQ object <OBJECT>
	1: Enable loop <BOOL>
*/

params ["_mhq", ["_enabled", false, [false]]];

if (!hasInterface || {isNull _mhq} || {typeOf _mhq isNotEqualTo "GOL_Mobile_HQ"}) exitWith {false};

private _enabledVariable = QGVAR(ActiveSoundEnabled);
if ((_mhq getVariable [_enabledVariable, false]) isEqualTo _enabled) exitWith {true};

private _loopId = (_mhq getVariable [QGVAR(ActiveSoundLoopId), 0]) + 1;
_mhq setVariable [_enabledVariable, _enabled];
_mhq setVariable [QGVAR(ActiveSoundLoopId), _loopId];

if !_enabled exitWith {true};

[_mhq, _loopId] spawn {
	params ["_mhq", "_loopId"];

	while {
		!isNull _mhq
		&& {_mhq getVariable [QGVAR(ActiveSoundEnabled), false]}
		&& {(_mhq getVariable [QGVAR(ActiveSoundLoopId), -1]) isEqualTo _loopId}
	} do {
		_mhq say3D ["GW_MHQ_ActiveTerminal", 18, 1];
		sleep 10;
	};
};

true