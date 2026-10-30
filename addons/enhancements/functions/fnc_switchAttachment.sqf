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
	private _nextItemConfig = configFile >> "CfgWeapons" >> _nextItem;
	private _isGOLIRAttachment = (getText (_nextItemConfig >> "baseWeapon")) isEqualTo "GOL_OX3000";
	private _canUseLight = (getNumber (_nextItemConfig >> "ItemInfo" >> "Flashlight" >> "intensity")) > 0;
	private _canUseLaser = !((getText (_nextItemConfig >> "ItemInfo" >> "Pointer" >> "irLaserPos")) isEqualTo "");
	player removePrimaryWeaponItem _currentItem;
	player addPrimaryWeaponItem _nextItem;
	playSound "GW_enhancements_Attachment";

	[{
		params ["_isLightActive","_isLaserActive","_isGOLIRAttachment","_canUseLight","_canUseLaser"];

		// GOL OX3000 modes are controlled explicitly by the BettIR keybind. Do not create an IR beam/light while cycling modes.
		if (!_isGOLIRAttachment && _isLightActive && _canUseLight) then {
			player action ["GunLightOn", player];
		};
		if (!_isGOLIRAttachment && _isLaserActive && _canUseLaser) then {
			player action ["IRLaserOn", player];
		};

		hintSilent format ["%1", getText(configfile >> "CfgWeapons" >> _nextItem >> "displayName")];
		[{
			hintSilent "";
		}, [], 2.5] call CBA_fnc_waitAndExecute;
	}, [_isLightActive, _isLaserActive, _isGOLIRAttachment, _canUseLight, _canUseLaser], 0.1] call CBA_fnc_waitAndExecute;
};
