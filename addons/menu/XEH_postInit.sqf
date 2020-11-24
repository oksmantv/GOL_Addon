#include "script_component.hpp"

if !(hasInterface) exitWith {};

[QGVARMAIN(playerReady), {
//	[DIK code, [Shift, Ctrl, Alt]]
	[QUOTE(PREFIX),"flexi_InteractSelfClient", "Client Menu", {
		["player",[],100, [QUOTE(call FUNC(flexi_InteractSelf)),"main"]] call cba_fnc_fleximenu_openMenuByDef;
	}, {}, [DIK_RWIN,[false,false,false]]] call CBA_fnc_addKeybind;

	if (isNil {profileNamespace getVariable QGVAR(clientSettingsV3)}) then {
		[QGVAR(settings), "save"] call CBA_fnc_localEvent;
	} else {
		[QGVAR(settings), "load"] call CBA_fnc_localEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(settings), {
	params ["_type"];
	if (hasInterface) then {
		switch (toLower(_type)) do {
			case "save": {
				// Remove Old Saves -->
					if !(isNil {(profileNamespace getVariable "GOL_Client_Settings")}) then {
						profileNamespace setVariable ["GOL_Client_Settings", nil];
					};
					if !(isNil {(profileNamespace getVariable QGVAR(clientSettings))}) then {
						profileNamespace setVariable [QGVAR(clientSettings), nil];
					};
					if !(isNil {(profileNamespace getVariable QGVAR(clientSettingsV2))}) then {
						profileNamespace setVariable [QGVAR(clientSettings), nil];
					};
				// <--

				_hud = [];
				if (GVAR(STHud_Enabled)) then {
					_hud = [STHUD_UIMode, GVAR(Toggle_STHud_Compass)];
				};
				if (GVAR(STHud_EnabledOld)) then {
					_hud = [ST_STHud_ShownUI, ST_STHud_ShowCompass];
				};
				profileNamespace setVariable [QGVAR(clientSettingsV3), [[viewDistance, getTerrainGrid, getObjectViewDistance], _hud]];
//				saveProfileNamespace;
			};

			case "load": {
				(profileNamespace getVariable QGVAR(clientSettingsV3)) params ["_profilePerf","_profileUI"];
				_profilePerf params ["_view","_terrain","_objects"];

				if (GVAR(viewDistance_Enabled)) then {
					if (GVAR(viewDistance_Default) isEqualTo 0) then {
						setViewDistance _view;
						if (!isNil "_objects") then {
							setObjectViewDistance _objects;
						};
					} else {
						setViewDistance GVAR(viewDistance_Default);
						setObjectViewDistance GVAR(viewObjectDistance_Default);
					};
				};
				if (GVAR(Grass_Enabled)) then {
					setTerrainGrid _terrain;
				};

				if !(_profileUI isEqualTo []) then {
					_profileUI params ["_uiMode","_enableHud"];
					if (GVAR(STHud_EnabledOld)) then {
						ST_STHud_ShowCompass = _enableHud;
						_uiMode call fn_sthud_usermenu_changeMode;
					};
					if (GVAR(STHud_Enabled)) then {
						STHUD_UIMode = _uiMode;
						[_enableHud] call FUNC(STHud_Toggle_Compass);
					};
				};
			};
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(paradropMode), {
	params ["_enable"];
	if (_enable) then {
		GVAR(ParadropHalo) = true;
		publicVariable QGVAR(ParadropHalo);
	} else {
		GVAR(ParadropHalo) = false;
		publicVariable QGVAR(ParadropHalo);
	};
}] call CBA_fnc_addEventHandler;
