#include "script_Component.hpp"
/*
	Set a GOL Mobile HQ animation source locally.
	Call this through GW_MHQ_SetMobileSource so every client renders the same source phase.

	Arguments:
	0: MHQ object <OBJECT>
	1: Animation source name <STRING>
	2: Target phase <NUMBER>
	3: Instant <BOOL>
*/

params ["_mhq", "_source", "_phase", ["_instant", false, [false]]];

if (isNull _mhq || {typeOf _mhq isNotEqualTo "GOL_Mobile_HQ"}) exitWith {false};

_mhq animateSource [_source, _phase, _instant];
true