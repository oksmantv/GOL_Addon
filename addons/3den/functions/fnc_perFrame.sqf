#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[1, true] call GW_3den_fnc_perFrame;

	Parameters:
	#0	NUMBER:	Case in Switch

	Return Value: <BOOL>

	Public: NO

*/

params [
	"_trigger"
];

private _hiddenArray = [];
while {!([_trigger] call FUNC(isNil3DENEntity))} do {
	if (_trigger in (get3DENSelected "trigger")) then {
		_str = ((_trigger get3DENAttribute "onActivation") select 0);
		_newStr = [_str, (_str find "[""") + 1, (_str find """]")] call BIS_fnc_trimString;
		_exclude = (_newStr splitString '","');

		private _radius = ((_trigger get3DENAttribute "size3") select 0);
		private _objects = (nearestTerrainObjects [_trigger, (HIDEOBJECTFILTER - _exclude), (selectMax _radius), false]);

		{
			if !(isObjectHidden _x) then {
				_x hideObjectGlobal true;
			};
			_hiddenArray pushBackUnique _x;
		} forEach (_objects inAreaArray _trigger);

		{
			_x hideObjectGlobal false;
			_hiddenArray deleteAt (_hiddenArray find _x);
		} forEach (_hiddenArray select { (isObjectHidden _x) && !(_x inArea _trigger) });
	};
	sleep 0.1;
};

{
	_x hideObjectGlobal false;
	_hiddenArray deleteAt (_hiddenArray find _x);
} forEach (_hiddenArray select {isObjectHidden _x});

true
