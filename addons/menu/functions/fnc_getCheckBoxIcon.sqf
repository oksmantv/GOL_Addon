#include "script_component.hpp"

params ["_toggle"];
private _return = "a3\ui_f\data\gui\RscCommon\RscCheckBox\checkbox_unchecked_ca.paa";

if (_toggle) then {
	_return = "a3\ui_f\data\gui\RscCommon\RscCheckBox\checkbox_checked_ca.paa";
};

_return
