#include "script_Component.hpp"
/*
	Author: GW Team
	Description:
	Shows or hides Arma's complete native action-menu HUD component for this client.
	The component includes standard actions, scripted addActions, and BIS hold actions.

	Arguments:
	0: Show the action-menu component <BOOL>

	Return Value:
	None
*/

params ["_showActionPrompts"];

if !(hasInterface) exitWith {};

private _hudComponents = shownHUD;
_hudComponents set [5, _showActionPrompts];
showHUD _hudComponents;