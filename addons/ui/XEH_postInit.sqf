#include "script_Component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

if !(hasInterface) exitWith {false};

[QGVARMAIN(playerReady), {
	if (GVARMAIN(mod_ACE3)) then {
		if (GVAR(nameTags) > 0) then {
			if (ace_nametags_showPlayerNames > 0) then {
				private _tag = 0;
				if (ace_nametags_showPlayerNames in [1,2,5]) then {
					_tag = 1;
				} else {
					if (ace_nametags_showPlayerNames in [3,4]) then {
						_tag = 2;
					};
				};
				[QGVAR(nameTags), _tag, true, "client", true] call CBA_settings_fnc_set;
			};

			["ace_nametags_showPlayerNames", 0, true, "client", true] call CBA_settings_fnc_set;	// Update in menu if avilable
			ace_nametags_showPlayerNames = 0;	// Force disable even if settings dont allow it
		};
	};

	["GW","show_nametags_key", "Show NameTags", {
		if (GVAR(nameTags) isEqualTo 2) then {
			GVAR(showNameTags) = true;
		} else {
			GVAR(showNameTags) = false;
		};
		false
	}, {
		GVAR(showNameTags) = false;
		false
	}, [DIK_TAB, [false, false, false]], false] call CBA_fnc_addKeybind;

	addMissionEventHandler ["EntityRespawned",{
		params ["_entity", "_corpse"];

		if (GVAR(allowSpectator)) then {
			if ([player] call FUNC(canOpenSpectator)) then {
				GVAR(spectate) = true;
				[{!([player] call FUNC(canOpenSpectator))}, {
					GVAR(spectate) = false;
				}, []] call CBA_fnc_waitUntilAndExecute;
			};
		};
	}];

	if ((EGVAR(menu,STHud_Enabled)) || (EGVAR(menu,STHud_EnabledOld))) then {

		if (EGVAR(menu,STHud_Enabled)) then {
		};
		if (EGVAR(menu,STHud_EnabledOld)) then {
			["player",[[35,[true,false,true]]],-99,["@sthud\addons\sthud_usermenu\st_menu_init_sthud_self.sqf","main"],true] call CBA_ui_fnc_remove;

			ST_STHud_GetColour = compileFinal "
				params [""_unit"",""_distance""];

				if (_unit == player) exitWith{
					if (leader(player) == _unit) then {
						[1, 1, 1, 1];
					} else {
						[0.85, 0.85, 0, 1];
					};
				};

				if (_distance < ST_STHud_Close) exitWith {
					[0.85, 0.4, 0, 1];
				};

				private _result = [0, 0.8, 0, 1];
				if (leader(player) == _unit) then {
					_result = [1, 1, 1, 1];
				};

				if (_distance > ST_STHud_MaxDist) then {
				private _alpha = (0 max (ST_STHud_FadeEdge - _distance)) / ST_STHud_EdgeStep;
					_alpha = 0.8 min _alpha;
					_result set [3, _alpha];
				};

				if (call GW_UI_isTagsBlurred) then {
					_result set [3, 0.1];
				};

				_result;
			";

			ST_STHud_GetColour_FromTeam = compileFinal "
				params [""_unit"",""_distance""];

				private _team_colour = _unit call ST_STHud_assignedTeam;
				private _is_player = (_unit == player);

				if ((!_is_player) && (_distance < ST_STHud_Close)) exitWith {
					[0.85, 0.4, 0, 1];
				};

				private _colour = switch (_team_colour) do {
					case ""MAIN"": {if (_is_player) then {[1, 1, 1, 1]} else {[0.7, 0.7, 0.7, 1]}};
					case ""RED"": {[0.9, 0, 0, 1]};
					case ""BLUE"": {[0.2, 0.2, 1, 1]};
					case ""GREEN"": {[0, 0.8, 0, 1]};
					case ""YELLOW"": {[0.85, 0.85, 0, 1]};
					default {[0, 0.8, 0, 1]}
				};

				if (_distance < ST_STHud_MaxDist) then {
					_colour set [3, 0.8];
				} else {
					private ""_alpha"";
					_alpha = (0 max (ST_STHud_FadeEdge - _distance)) / ST_STHud_EdgeStep;
					_alpha = 0.8 min _alpha;
					_colour set [3, _alpha];
				};

				if (_is_player) then {
					_colour set [3, 1];
				};

				if (call GW_UI_isTagsBlurred) then {
					_colour set [3, 0.1];
				};

				_colour;
			";
		};

		["featureCamera", {
			if ((call CBA_fnc_getActiveFeatureCamera) isEqualTo "") then {
				[true] call FUNC(toggleHud);
			} else {
				[false] call FUNC(toggleHud);
			};
		}] call CBA_fnc_addPlayerEventHandler;
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(pauseMenuOpened), {
	params ["_display"];
	if (["IsSpectating"] call BIS_fnc_EGSpectator) then {
		_ctrlAbort = _display displayctrl 104;
		_ctrlAbort ctrlshow false;
		_ctrlAbortNew = _display ctrlcreate ["RscButtonMenuCancel",2];
		_ctrlAbortNew ctrlsetposition ctrlposition _ctrlAbort;
		_ctrlAbortNew ctrlcommit 0;
		_ctrlAbortNew ctrlsettext "Close (Spectator Mode)";
		_ctrlAbortNew ctrladdeventhandler ["buttonclick", {
			(findDisplay 49) closeDisplay 0;
			['Terminate'] call BIS_fnc_EGSpectator;
		}];
	} else {
		if (GVAR(allowSpectator) && GVAR(spectate)) then {
			private _size = 0.3;
			private _width = (_size + 0.5) * safezoneW;
			private _height = _size * safezoneH * (getResolution#4);

			private _button = _display ctrlCreate ["RscButtonMenu", -1];
			_button ctrlSetPosition [
				(1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)),
				(9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safezoneY),
				(15 * (((safezoneW / safezoneH) min 1.2) / 40)),
				(1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
			];
			_button ctrlCommit 0;
			_button ctrlSetBackgroundColor [0.3,0.3,0.3,1];
			_button ctrlSetText "Open Spectator Mode";
			_button buttonSetAction "(findDisplay 49) closeDisplay 0; [{ ['Initialize', [player]] call BIS_fnc_EGSpectator; }, [], 0.1] call CBA_fnc_waitAndExecute;";
			_button ctrlShow true;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(pauseMenuClosed), {
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(SpectatorOpened), {
	["OnSwitchFocusClicked", [true]] call (uiNamespace getVariable ["RscDisplayEGSpectator_script", {}]);
	["SetCameraMode", ["follow"]] call BIS_fnc_EGSpectatorCamera;
	BIS_EGSpectator_allowFreeCamera = false;
/*
	if (EGVAR(Menu,STHud_EnabledOld)) then {
		0 call fn_sthud_usermenu_changeMode;
	};
	if (EGVAR(Menu,STHud_Enabled)) then {
		STHUD_UIMode = 0;
	};
*/
	if (isMultiplayer) then {
		BIS_EGSpectator_allowAiSwitch = false;
		BIS_EGSpectator_allow3PPCamera = true;
	};
}] call CBA_fnc_addEventHandler;
