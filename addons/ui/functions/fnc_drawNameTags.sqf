#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Draws nametags for units
	Function can be called multiple times per frame so is high maintenance

	Usage:
	[wfac, player, 1, false] call GW_UI_fnc_drawNameTags;

	Arguments:
	0: <Object> - Target
	1: <Object> - Player
	2: <Number> - Direction
	3: <Bool> 	- isZoomed

	Return Value:
	0: <Array> - Color formated in RGBA
	1: <Array> - Position

	Public:
*/

params ["_target","_player","_dir","_isZoomed"];

private _alpha = 0;
private _distance = (_player distance _target);

if (_isZoomed) then {
	_aim = (linearConversion [0.95, 0.6, _dir, 1.0, 0.1, true]);
	_dist = (linearConversion [30, 59, _distance, 1.0, 0.1, true]);
	_alpha = (_aim * _dist);
} else {
	_aim = (linearConversion [0.8, -0.9, _dir, 1.0, 0.0, true]);
	_dist = (linearConversion [3, 30, _distance, 1.0, 0.0, true]);
	_alpha = ((_aim * _dist) max 0.01);
};

_alpha = (_alpha * GVAR(nameAlpha));

if (_alpha > 0.1) then {	// Only calculate if needed
	private _posZ = (((_target modelToWorldVisual (_target selectionPosition "pelvis")) select 2) + (linearConversion [5, 30, _distance, 1.0, 1.7, true]));
	(visiblePosition _target) params ["_posX","_posY"];

	private _color = [0.7, 0.5, 0.25, _alpha];

	if (_target in (units _player)) then {
		if ((assignedTeam _target) isEqualTo "RED") then {
			_color = [0.9,0,0,_alpha];
		};
		if ((assignedTeam _target) isEqualTo "GREEN") then {
			_color = [0,0.9,0,_alpha];
		};
		if ((assignedTeam _target) isEqualTo "BLUE") then {
			_color = [0,0,0.9,_alpha];
		};
		if ((assignedTeam _target) isEqualTo "YELLOW") then {
			_color = [0.9,0.9,0,_alpha];
		};
		if ((assignedTeam _target) isEqualTo "MAIN") then {
			_color = [0.9,0.9,0.9,_alpha];
		};
	};

	[_color, [_posX, _posY, _posZ]]
} else {
	[]
};
