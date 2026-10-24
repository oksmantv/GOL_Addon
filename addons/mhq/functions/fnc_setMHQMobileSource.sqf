#include "script_Component.hpp"
/*
	Set a GOL Mobile HQ animation source on the object owner.
	This ensures source changes replicate when the MHQ is server-local on a dedicated server.

	Arguments:
	0: MHQ object <OBJECT>
	1: Animation source name <STRING>
	2: Target phase <NUMBER>
	3: Instant <BOOL>
*/

params ["_mhq", "_source", "_phase", ["_instant", false, [false]]];

if (isNull _mhq || {typeOf _mhq isNotEqualTo "GOL_Mobile_HQ"}) exitWith {false};

if (!local _mhq) exitWith {
	[_mhq, _source, _phase, _instant] remoteExecCall [QFUNC(setMHQMobileSource), _mhq];
	true
};

_mhq animateSource [_source, _phase, _instant];
true