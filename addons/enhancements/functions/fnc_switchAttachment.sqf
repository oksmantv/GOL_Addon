/*
	[] call GW_enhancements_fnc_switchAttachment
*/
#include "script_component.hpp"

private _currentItem = ((primaryWeaponItems player) select 1);
private _attachments = ([_currentItem] call FUNC(findAttachment));
if !(_attachments isEqualTo []) then {
	private _nextItem = (_attachments select 0);
	if (_currentItem isEqualTo _nextItem) then {
		_nextItem = (_attachments select 1);
	};

	private _isLightActive = (player isFlashlightOn (currentWeapon player));
	private _isLaserActive = (player isIRLaserOn (currentWeapon player));
	player removePrimaryWeaponItem _currentItem;
	player addPrimaryWeaponItem _nextItem;
	playSound "GW_enhancements_Attachment";

	[{
		params ["_isLightActive","_isLaserActive"];

		if (_isLightActive || _isLaserActive) then {
			player action ["GunLightOn", player];
			player action ["IRLaserOn", player];
		};

		hintSilent format ["%1", getText(configfile >> "CfgWeapons" >> _nextItem >> "displayName")];
		[{
			hintSilent "";
		}, [], 2.5] call CBA_fnc_waitAndExecute;
	}, [_isLightActive, _isLaserActive], 0.1] call CBA_fnc_waitAndExecute;
};
