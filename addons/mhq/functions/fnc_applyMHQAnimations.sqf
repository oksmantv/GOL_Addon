#include "script_Component.hpp"
/*
	Apply deploy/active animation sources for the Rugged Terminal MHQ.

	Usage:
	[_mhq, true] call GW_MHQ_fnc_applyMHQAnimations;

	Arguments:
	0: MHQ object <OBJECT>
	1: Expanded/open state <BOOL>
*/

params ["_mhq", ["_isExpanded", false, [false]]];

if (isNull _mhq) exitWith {false};
if !(_mhq isKindOf "RuggedTerminal_01_communications_F") exitWith {false};

private _phase = [0, 1] select _isExpanded;
private _requestedNames = [
	"case_lock_l_rotation",
	"case_lock_r_rotation",
	"case_lid_rotation",
	"laptop_lid_rotation",
	"display_off_hide",
	"antenna_rotation",
	"antenna_translation",
	"satellite_rotation_1_1",
	"satellite_rotation_1_2",
	"satellite_rotation_1_3",
	"satellite_rotation_1_4",
	"satellite_rotation_1_5",
	"satellite_rotation_2_1",
	"satellite_rotation_2_2",
	"satellite_rotation_2_3",
	"satellite_rotation_2_4",
	"satellite_rotation_2_5",
	"satellite_rotation_3",
	"satellite_rotation_ending_1",
	"satellite_rotation_ending_2",
	"progress_translation"
];

private _cfgAnimSources = configFile >> "CfgVehicles" >> (typeOf _mhq) >> "AnimationSources";
private _availableAnimations = animationNames _mhq;
private _keywords = ["case", "lid", "laptop", "display", "antenna", "satellite", "progress"];

private _dynamicAnimations = _availableAnimations select {
	private _name = toLowerANSI _x;
	(_keywords findIf { _name find _x > -1 }) > -1
};

private _availableSources = [];
{
	_availableSources pushBack (configName _x);
} forEach ("true" configClasses _cfgAnimSources);

private _dynamicSources = _availableSources select {
	private _name = toLowerANSI _x;
	(_keywords findIf { _name find _x > -1 }) > -1
};

private _sourceNames = (_requestedNames + _dynamicSources) arrayIntersect (_requestedNames + _dynamicSources);
private _animationNames = (_requestedNames + _dynamicAnimations) arrayIntersect (_requestedNames + _dynamicAnimations);

if (!local _mhq) then {
	[_mhq, _phase, _sourceNames, _animationNames] remoteExecCall [QFUNC(applyMHQAnimationsLocal), _mhq];
} else {
	[_mhq, _phase, _sourceNames, _animationNames] call FUNC(applyMHQAnimationsLocal);
};

true
