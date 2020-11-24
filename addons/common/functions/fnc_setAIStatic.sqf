#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[this] call _fnc_setAIStatic;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/


params ["_unit",["_dir", -1]];
private _grp = (group _unit);
_unit setVariable [QGVAR(disableAI_Path), true, true];

if ((skill _unit) > 0.6) then {
	_unit disableAI "AIMINGERROR";
	_unit disableAI 'SUPPRESSION';
};

_unit disableAI "PATH";
_unit disableAI "TARGET";
_unit disableAI "MINEDETECTION";
_unit disableAI 'AUTOCOMBAT';			// AI run another FSM when in combat, this may reduce the calculations
_unit disableAI 'COVER';				// should disable some expensive cover calculations
//	_unit disableAI 'CHECKVISIBLE';			// Raycasting takes up a lot of CPU time, this will sharply reduce.
//	_unit disableAI 'FSM';					// Will make the AI very dumb, and reduce some calculations. they may not shoot.
_unit setSkill ['spotDistance',0.5];	// Reduce the distance at which AI can see enemy, reducing their calculations.

if !(_dir isEqualTo -1) then {
	_unit setFormDir _dir;
	_unit setDir _dir;
	_unit doWatch (_unit getPos [_dir, 50]);
};

doStop _unit;
if ((leader _grp) isEqualTo (leader _unit)) then {
	_grp setvariable ["Vcm_Disable",false];

	_grp setCombatMode "RED";
	_grp setBehaviour 'SAFE';				// Get the unit out of combat mode so some of the above can take effect.
	_grp allowFleeing 0;
	_grp enableAttack false;
	if (dynamicSimulationSystemEnabled) then {
		_grp enableDynamicSimulation true;
	};
};

[{
	_this enableGunLights "forceOff";
}, _unit, 5] call CBA_fnc_waitAndExecute;

if (_unit getVariable QGVAR(Fortify)) then {
	[_unit] execFSM "x\gw\addons\ai_enhancements\ai_bunker.fsm";
} else {
	if ((leader _grp) isEqualTo (leader _unit)) then {
		[_grp] call CBA_fnc_clearWaypoints;
		_wp = _grp addWaypoint [(getposATL _unit), 0];
		_wp setWaypointType "GUARD";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointBehaviour "SAFE";
		_grp setCurrentWaypoint _wp;
	};
};

true
