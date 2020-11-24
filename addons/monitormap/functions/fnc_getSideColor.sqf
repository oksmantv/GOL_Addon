#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Gets the correct color depending on their side or health state

	Usage:
	[this] call GW_MonitorMap_fnc_getSideColor;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/



params ["_unit"];

private _color = "ColorCIV";

if (_unit getVariable ["ACE_isUnconscious", false]) then {
	"ColorUNKNOWN"
} else {
	switch (side _unit) do {
		case west: {
			_color = "ColorBlue";
		};
		case east: {
			_color = "ColorRed";
		};
		case independent: {
			_color = "ColorGreen";
		};
	};
	_color
};
