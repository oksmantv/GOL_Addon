#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	Displays the current mission-wide protection status while either protection is active.

	Usage:
	[] call GW_Common_fnc_protectionStatusHint;

	Arguments:
	Return Value: BOOL

	Public: No
*/

if (!hasInterface) exitWith {false};

private _safeModeEnabled = missionNamespace getVariable ["GW_GameLoop_SafeMode_Enabled", false];
private _playerProtectionEnabled = missionNamespace getVariable ["GW_admin_playerProtectionEnabled", false];
private _layer = "GW_ProtectionStatus" call BIS_fnc_rscLayer;
private _protectionActive = _safeModeEnabled || _playerProtectionEnabled;

if (isNil QGVAR(protectionStatusPFH)) then {
	GVAR(protectionStatusPFH) = [{
		[] call FUNC(protectionStatusHint);
	}, 0.5] call CBA_fnc_addPerFrameHandler;
};

private _fnc_stateInfo = {
	params ["_enabled"];
	if (_enabled) then {
		["<t color='#76E38D'>ACTIVE</t>", "\A3\ui_f\data\igui\cfg\actions\ico_on_ca.paa"]
	} else {
		["<t color='#F27B7B'>INACTIVE</t>", "\A3\ui_f\data\igui\cfg\actions\ico_off_ca.paa"]
	};
};

private _safeModeInfo = [_safeModeEnabled] call _fnc_stateInfo;
private _playerProtectionInfo = [_playerProtectionEnabled] call _fnc_stateInfo;
private _text = parseText format [
	"<img image='\x\gw\addons\main\data\Logo_GOL_1.paa' size='1.80' align='center'/><br/>" +
	"<t align='center' size='1.05' color='#FFFFFF'>PROTECTION STATUS</t><br/><br/>" +
	"<t align='center' size='0.78' color='#A8C9FF'><img image='\A3\ui_f\data\igui\cfg\actions\reammo_ca.paa' size='0.85'/> WEAPON SAFE MODE</t><br/>" +
	"<t align='center' size='0.92'>%1 <img image='%2' size='0.85'/></t><br/><br/>" +
	"<t align='center' size='0.78' color='#A8C9FF'><img image='\A3\ui_f\data\igui\cfg\actions\heal_ca.paa' size='0.85'/> PLAYER PROTECTION</t><br/>" +
	"<t align='center' size='0.92'>%3 <img image='%4' size='0.85'/></t>",
	_safeModeInfo select 0,
	_safeModeInfo select 1,
	_playerProtectionInfo select 0,
	_playerProtectionInfo select 1
];

private _display = uiNamespace getVariable ["GW_ProtectionStatus", displayNull];
if (isNull _display) exitWith {
	_layer cutRsc ["GW_ProtectionStatus", "PLAIN", 0, false];
	[{ [] call FUNC(protectionStatusHint); }] call CBA_fnc_execNextFrame;
	true
};

(_display displayCtrl 31001) ctrlSetStructuredText _text;

if (_protectionActive) exitWith {
	GVAR(protectionStatusExpiresAt) = -1;
	GVAR(protectionStatusClosing) = false;
	true
};

if (GVAR(protectionStatusExpiresAt) < 0) then {
	GVAR(protectionStatusExpiresAt) = diag_tickTime + 5;
};

if (diag_tickTime >= GVAR(protectionStatusExpiresAt) && {!GVAR(protectionStatusClosing)}) then {
	GVAR(protectionStatusClosing) = true;
	_layer cutFadeOut 0.5;
	[{
		params ["_layer"];
		private _safeModeEnabled = missionNamespace getVariable ["GW_GameLoop_SafeMode_Enabled", false];
		private _playerProtectionEnabled = missionNamespace getVariable ["GW_admin_playerProtectionEnabled", false];
		if !(_safeModeEnabled || _playerProtectionEnabled) then {
			_layer cutText ["", "PLAIN"];
			if !(isNil QGVAR(protectionStatusPFH)) then {
				[GVAR(protectionStatusPFH)] call CBA_fnc_removePerFrameHandler;
				GVAR(protectionStatusPFH) = nil;
			};
			GVAR(protectionStatusExpiresAt) = -1;
		};
		GVAR(protectionStatusClosing) = false;
	}, [_layer], 0.5] call CBA_fnc_waitAndExecute;
};

true