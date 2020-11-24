#include "script_component.hpp"
/*
 * Author: Ruthberg, commy2
 * Checks if the player can deploy a sandbag.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Can deploy <BOOL>
 *
 * Example:
 * [ACE_player] call GW_ACE_Settings_fnc_canDeploy
 *
 * Public: No
 */

params ["_unit"];

if !("ACE_Sandbag_empty" in (_unit call ACE_common_fnc_uniqueItems)) exitWith {false};

if ((_unit getVariable ["ACE_IsEngineer", 0]) > 0) exitWith {true};	// Bypass dig check

(_unit call ACE_common_fnc_canDig)
