#include "script_Component.hpp"
/*
	Runs an Enhanced Eden attribute expression on an object (used for runtime spawns and for the GW fallback attribute).

	Params:
	0: OBJECT - target (_this inside the expression)
	1: STRING - Enhanced attribute class (e.g. "ENH_MakeHostage", "ENH_AmbientAnimations")
	2: ANY    - attribute value (_value inside the expression)

	Returns: BOOL - true if the expression was found and executed
*/
params [
	["_target", objNull],
	["_class", ""],
	["_attrValue", nil]
];

if (isNull _target || {_class isEqualTo ""}) exitWith {false};

private _expr = "";
{
	private _cfg = _x >> "Attributes" >> _class;
	if (isClass _cfg) exitWith {
		_expr = getText (_cfg >> "expression");
	};
} forEach ("true" configClasses (configFile >> "Cfg3DEN" >> "Object" >> "AttributeCategories"));

if (_expr isEqualTo "") exitWith {
	WARNING(FORMAT_1("applyEnhAttribute: %1 attribute expression not found (Enhanced Eden not loaded?); skipped", _class));
	false
};

_target call compile (format ["private _value = %1; %2", str _attrValue, _expr]);
true
