#include "script_component.hpp"

if (GVAR(Toggle_STHud_Compass)) then {
	params ["_canvas", "_lookDir"];
	{
		_x params ["_bearing", "_size", "_image"];
		private _mapPos = STHud_Mid vectorAdd [
			STHud_CompassScale * sin(_bearing - _lookDir),
			STHud_CompassScale * cos(_bearing - _lookDir),
			0
		];

		_canvas drawIcon [
			_image,
			[1,1,1,0.65],
			_mapPos,
			_size,
			_size,
			_bearing - _lookDir,
			"",
			false
		];
	} forEach STHud_CompassData;
};
