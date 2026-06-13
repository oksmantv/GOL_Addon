#include "script_Component.hpp"
/*
	Apply MHQ animation phases on the local machine.

	Arguments:
	0: MHQ object <OBJECT>
	1: Target phase <NUMBER>
	2: Animation source names <ARRAY>
	3: Animation names <ARRAY>
*/

params [
	"_mhq",
	["_phase", 0, [0]],
	["_sourceNames", [], [[]]],
	["_animationNames", [], [[]]]
];

if (isNull _mhq) exitWith {false};

{
	_mhq animateSource [_x, _phase, true];
} forEach _sourceNames;

{
	_mhq animate [_x, _phase, true];
} forEach _animationNames;

true
