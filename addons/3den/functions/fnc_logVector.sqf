#include "script_component.hpp"
/*

	[] call GW_3DEN_fnc_logVector

*/

_text = "";
_br = tostring [13,10];
_n = 0;
_entityTypes = ["object","logic","waypoint","marker"];
_entities = [get3DENSelected "object",get3DENSelected "logic",get3DENSelected "waypoint",get3DENSelected "marker"];
_showTypes = {count _x > 0} count _entities > 1;
{
	_typeID = _foreachindex;
	if (count _x > 0) then {
		if (_n > 0) then {_text = _text + _br + _br;};
		_vectorUp = [];
		_vectorDir = [];
		{
			if (_foreachindex > 0) then {_text = _text + _br;};
			_class = ((_x get3DENAttribute "itemclass") select 0);
			{
				_vectorDir pushBack _x;
			} forEach (vectorDir _x);
			{
				_vectorUp pushBack _x;
			} forEach (vectorUp _x);
			_text = _text + format ["%1 Dir: (%2) VectorDirAndUp: ([%3, %4])",_class, ([getDir _x, 0] call BIS_fnc_cutDecimals), _vectorDir, _vectorUp];
		} foreach _x;
		_n = _n + 1;
	};
} foreach _entities;

copytoclipboard _text;
