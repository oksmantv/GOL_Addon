#include "script_Component.hpp"
/*
	Play physical terminal sounds for a GOL Mobile HQ state transition.

	Arguments:
	0: MHQ object <OBJECT>
	1: Transition <STRING> - "activate", "deactivate", "assemble", or "disassemble"
*/

params ["_mhq", ["_transition", "", [""]]];

if (!hasInterface || {isNull _mhq} || {typeOf _mhq isNotEqualTo "GOL_Mobile_HQ"}) exitWith {false};

private _sounds = switch _transition do {
	case "activate": {[["GW_MHQ_LockOpen", 0], ["GW_MHQ_LidOpen", 0.35], ["GW_MHQ_LaptopOpen", 0.8]]};
	case "deactivate": {[["GW_MHQ_LaptopClose", 0], ["GW_MHQ_LidClose", 0.45], ["GW_MHQ_LockClose", 0.9]]};
	case "assemble": {[["GW_MHQ_AntennaOpen", 0], ["GW_MHQ_SatelliteOpen", 0.7]]};
	case "disassemble": {[["GW_MHQ_SatelliteClose", 0], ["GW_MHQ_AntennaClose", 0.7]]};
	default {[]};
};

[_mhq, _sounds] spawn {
	params ["_mhq", "_sounds"];
	{
		_x params ["_sound", "_delay"];
		sleep _delay;
		_mhq say3D [_sound, 25, 1];
	} forEach _sounds;
};

true