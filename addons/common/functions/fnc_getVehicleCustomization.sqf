/*
	Author: Karel Moricky, optimized by Julien `Tom_48_97` V.

	Description:
	Return vehicle customization settings

	Parameter(s):
		0: OBJECT
		1 (Optional) STRING - object class override

	Returns:
	ARRAY in format [<textures>,<animations>]
	e.g., [["wasp",1],[["AddTread",0],["AddTread_Short",1]]]
*/

private _center = param [0,objnull,[objnull]];
private _centerType = param [1,typeof _center,[""]];
private _cfg = configfile >> "cfgvehicles" >> _centerType;

//--- Read textures
private _texture = [];
private _currentTextures = getobjecttextures _center;
{
	_currentTextures set [_foreachindex,tolower _x];
} foreach _currentTextures;

{
	if (getText (_x >> "displayName") != "") then {
		if (!isNumber (_x >> "scope") && {!((getNumber (_x >> "scope")) > 0)}) then {
			private _textures = getarray (_x >> "textures");
			private _selected = true;

			{
				if ((count _currentTextures) >= _foreachindex) then {
					if ((tolower _x) find (_currentTextures select _foreachindex) < 0) exitwith {
						_selected = false;
					};
				};
			} foreach _textures; //--- First backslash may vary

			if (_selected) then {
				_texture = [configname _x,1];
			};
		};
	};
} foreach (configproperties [_cfg >> "textureSources","isclass _x",true]);

//--- Read animations
private _animations = [];
{
	if (getText (_x >> "displayName") != "") then {
		if (!isNumber (_x >> "scope") && {!((getNumber (_x >> "scope")) > 0)}) then {
			private _animation = configname _x;
			private _animPhase = _center animationphase _animation;
			_animations pushback _animation;
			_animations pushback _animPhase;
		};
	};

} foreach (configproperties [_cfg >> "animationSources","isclass _x",true]);
[_texture,_animations]
