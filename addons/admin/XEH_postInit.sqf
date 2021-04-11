#include "script_component.hpp"

[QGVARMAIN(playerReady), {
	if (((getArray(ConfigFile >> "CfgPatches" >> "CBA_Main" >> "versionAr")) select 1) > 9) then { //	Dirty fix for number counting 3.9 > 3.13 || 13 > 9
		[[QUOTE(PREFIX), "Admin"], "flexi_InteractSelfAdmin", "Admin Menu", {
			if (ISADMIN) then {
				["player",[],100, [QUOTE(call FUNC(flexi_InteractSelf)),"main"]] call cba_fnc_fleximenu_openMenuByDef;
			} else {
				systemChat format ["ShameList: %1 trying to access admin menu", player];
				[QGVAR(shameList), [2, player], ACTIVE_LIST] call CBA_fnc_targetEvent;
			};
		}, {}, [DIK_INSERT,[true,false,true]], false] call CBA_fnc_addKeybind;

		[[QUOTE(PREFIX), "Admin"], "key_MonitorMap", "Toggle Map Monitor", {
			if (ISADMIN) then {
				[2, 1, true] call EFUNC(MonitorMap,Handler);
			} else {
				systemChat format ["ShameList: %1 trying to access admin menu", player];
				[QGVAR(shameList), [2, player], ACTIVE_LIST] call CBA_fnc_targetEvent;
			};
		}, {}, [DIK_HOME,[true,false,true]], false] call CBA_fnc_addKeybind;

		[[QUOTE(PREFIX), "Admin"], "key_MonitorServer", "Toggle Server Monitor", {
			if (ISADMIN) then {
				[] call EFUNC(MonitorServer,Toggle);
			} else {
				systemChat format ["ShameList: %1 trying to access admin menu", player];
				[QGVAR(shameList), [2, player], ACTIVE_LIST] call CBA_fnc_targetEvent;
			};
		}, {}, [DIK_END,[true,false,true]], false] call CBA_fnc_addKeybind;
	} else {
		[QUOTE(PREFIX),"flexi_InteractSelfAdmin", "Admin Menu", {
			if (ISADMIN) then {
				["player",[],100, [QUOTE(call FUNC(flexi_InteractSelf)),"main"]] call cba_fnc_fleximenu_openMenuByDef;
			} else {
				systemChat format ["ShameList: %1 trying to access admin menu", player];
				[QGVAR(shameList), [2, player], ACTIVE_LIST] call CBA_fnc_targetEvent;
			};
		}, {}, [DIK_INSERT,[true,false,true]], false] call CBA_fnc_addKeybind;
	};
}] call CBA_fnc_addEventHandler;

[{
	if (hasInterface) then {
		[{
			GVARMAIN(ZeuzModuleAdminLogged) addEventHandler ["CuratorPinged", {
				params ["_curator", "_unit"];
				[QGVAR(shameList), [0, _unit], ACTIVE_LIST] call CBA_fnc_targetEvent;
			}];
		},	[], 5] call CBA_fnc_waitAndExecute;

		if ((getPlayerUID player) in GVARMAIN(adminList)) then {
			[QGVARMAIN(AddAdmin), player] call CBA_fnc_localEvent;
			if ((getPlayerUID player) in GVARMAIN(superAdminList)) then {
				GVARMAIN(isSuperAdmin) = true;
			};
		};

		if (ISADMIN) then {
			player createDiaryRecord ["Diary", ["ShameList", "This list is to show players who tries to access admin menu"]];
			player addEventHandler ["Respawn", {
				params ["_unit", "_corpse"];
				_curator = (getassignedcuratorlogic _corpse);
				if !(isnull _curator) then {
					[QGVAR(AssignCurator), [_unit, _curator]] call CBA_fnc_serverEvent;
				};
			}];
		};
	};

	if (isServer) then {
		if (isMultiplayer) then {
			GVARMAIN(activeAdmins_PFH) = [{
				if (diag_fps < 25) then {
					[QGVARMAIN(sendMessage), format ["Warning: Server low fps %1", diag_fps], ACTIVE_LIST] call CBA_fnc_targetEvent;
				};
				if (((count allUnits) - (count allPlayers)) > 150) then {
					[QGVARMAIN(sendMessage), format ["Warning: High unit count %1", ((count allUnits) - (count allPlayers))], ACTIVE_LIST] call CBA_fnc_targetEvent;
				};
				if ((count allGroups) > 125) then {
					[QGVARMAIN(sendMessage), format ["Warning: High group count %1", (count allGroups)], ACTIVE_LIST] call CBA_fnc_targetEvent;
				};
				if ((count allDead) > 50) then {
					[QGVARMAIN(sendMessage), format ["Warning: High dead count %1", (count allDead)], ACTIVE_LIST] call CBA_fnc_targetEvent;
				};
			}, 30, []] call CBA_fnc_addPerFrameHandler;
		};
		addMissionEventHandler ["HandleDisconnect", {
			params ["_unit"];

			_module = (getAssignedCuratorLogic _unit);
			if !(isNull _module) then {
				unassignCurator _module;
			};

			false
		}];

		["ModuleCurator_F", "init", {
			[{
				params ["_ZeuzModule"];

				{
					_ZeuzModule addCuratorEditableObjects [[_x],true];
				} forEach (allUnits + vehicles);

				if !(toLower(_ZeuzModule getVariable ["Name", ""]) isEqualTo "AdminZeusLogged") then {
					[QGVAR(shameList), [1, (getAssignedCuratorUnit _ZeuzModule)], ACTIVE_LIST] call CBA_fnc_targetEvent;
				};
			},	_this, 5] call CBA_fnc_waitAndExecute;
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	};
}, [], 1] call CBA_fnc_waitAndExecute;

["GW_pauseMenuOpened", {
	params ["_display"];
	if !(ISADMIN) then {
		_admin = (_display displayCtrl 256101);	//	GW_MainMenu_Admin_base
		_admin ctrlEnable false;
//		_admin ctrlShow false;
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(sendMessage), {
	params ["_message"];
	systemChat _message;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(AddAdmin), {
	params ["_admin"];
	GVARMAIN(isAdmin) = true;
	missionNamespace setVariable [QGVARMAIN(isAdmin), true];
	[QGVARMAIN(AddAdminServer), _admin] call CBA_fnc_serverEvent;
	diag_log "GW_Admin: Player Added to adminList";
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(AddAdminServer), {
	params ["_admin"];
	GVARMAIN(adminList) pushBackUnique _admin;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(RemoveAdmin), {
	params ["_admin"];
	GVARMAIN(isAdmin) = false;
	[QGVARMAIN(RemoveAdminServer), _admin] call CBA_fnc_serverEvent;
	diag_log "GW_Admin: Player Removed from adminList";
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(RemoveAdminServer), {
	params ["_admin"];
	if (_admin in GVARMAIN(adminList)) then {
		GVARMAIN(adminList) deleteAt (GVARMAIN(adminList) find _admin);
	};
}] call CBA_fnc_addEventHandler;


// Active Admin
[QGVARMAIN(AddActiveAdmin), {
	params ["_admin"];
	GVARMAIN(isActiveAdmin) = true;
	[QGVARMAIN(AddActiveAdminServer), _admin] call CBA_fnc_serverEvent;
	diag_log "GW_Admin: Player Added to activeAdminList";
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(AddActiveAdminServer), {
	params ["_admin"];
	GVARMAIN(activeAdmins) pushBackUnique _admin;
	publicVariable QGVARMAIN(activeAdmins);
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(RemoveActiveAdmin), {
	params ["_admin"];
	GVARMAIN(isActiveAdmin) = false;
	[QGVARMAIN(RemoveActiveAdminServer), _admin] call CBA_fnc_serverEvent;
	diag_log "GW_Admin: Player removed from activeAdminList";
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(RemoveActiveAdminServer), {
	params ["_admin"];
	if (_admin in GVARMAIN(activeAdmins)) then {
		GVARMAIN(activeAdmins) deleteAt (GVARMAIN(activeAdmins) find _admin);
		publicVariable QGVARMAIN(activeAdmins);
	};
}] call CBA_fnc_addEventHandler;



[QGVAR(AssignCurator), {
	_this spawn {
		params ["_unit","_curator"];
		unassigncurator _curator;
		sleep 0.5;
		_unit assignCurator _curator;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(createZeus), {
	params [["_unit", ""]];

	if !(isNull (getAssignedCuratorLogic _unit)) exitWith {
		systemChat "Player already assigned to a curator";
	};
	_zeus = allCurators select {(isNull (getAssignedCuratorUnit _x)) && !((_x getVariable ["Name", ""]) isEqualTo "AdminZeusLogged")};
	if (count _zeus > 0) then {
		_unit assignCurator (_zeus select 0);
		systemChat format ["Curator found, Assigning player to %1", (_zeus select 0)];
	} else {
		private _LogicCenter = createCenter sideLogic;
		private _moduleGroup = createGroup _LogicCenter;
		private _ZeuzModule = _moduleGroup createUnit ["ModuleCurator_F",[0,0,0],[],0,"NONE"];
		_ZeuzModule setVariable ["Owner", "", true];
		_ZeuzModule setVariable ["Name", format ["GW_Admin_Curator_%1", count GVARMAIN(adminCurators)], true];
		_ZeuzModule setVariable ["Addons", 0, true];
		_ZeuzModule setVariable ["Forced", 0, true];
		_ZeuzModule setVariable ["birdType", "", true];
		_ZeuzModule setVariable ["showNotification", false, true];
		_ZeuzModule setVariable ["adminvar",""];
		_ZeuzModule setVariable ["bis_fnc_moduleexecute_activate", true];
		_ZeuzModule setVariable ["bis_fnc_moduleinit_status", true];
		_ZeuzModule setVariable ["bis_fnc_initmodules_activate", true];
		_ZeuzModule setCuratorWaypointCost 0;
		{
			_ZeuzModule setCuratorCoef [_x,0];
		} forEach ["place","edit","delete","destroy","group","synchronize"];

		[{
			GVARMAIN(ZeuzModuleAdminLogged) addCuratorAddons (activatedAddons);
		}, [], 30] call CBA_fnc_waitAndExecute;

		GVARMAIN(adminCurators) pushBack _ZeuzModule;
		_unit assignCurator _ZeuzModule;
		_unit call bis_fnc_curatorRespawn;
		systemChat format ["Curator created %1", _ZeuzModule];
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(removeZeus), {
	params ["_unit"];
	private _zeus = (getAssignedCuratorLogic _unit);
	unassignCurator _zeus;
/*
	if !((_zeus getVariable ["Name", ""]) isEqualTo "AdminZeus") then {
		deleteVehicle _zeus;
	};
*/
}] call CBA_fnc_addEventHandler;

[QGVAR(spawnBox), {
	params ["_type","_class","_unit"];

	_box = createVehicle [_class, [0,0,0], [], 0, "NONE"];
	_pos = (_unit getRelPos [3, 0]);
	_pos set [2, (getPosASL _unit) select 2];
	_box setPos _pos;
	[_box, [_type, toLower(str([_unit] call GW_Common_Fnc_getSide)), true]] call GW_Gear_Fnc_Handler;
}] call CBA_fnc_addEventHandler;

[QGVAR(shameList), {
	params ["_type","_unit"];
	_name = (name _unit);
	_str = "";
	switch (_type) do {
		case 0: {
			_str = format ["%1 Pinged", _name];
		};
		case 1: {
			_str = format ["%1 Now got zues", _name];
		};
		case 2: {
			_str = format ["%1 Tried to open admin menu", _name];
		};
	};

	player createDiaryRecord ["Diary", ["ShameList", format ["%1: %2", ([time, "H:MM:SS"] call CBA_fnc_formatElapsedTime), _str]]];
}] call CBA_fnc_addEventHandler;

[QGVAR(avilableCommands), {
	params ["_msg"];
	if (ISADMIN) then {
		"Avilable Commands" hintC [
			"#help message - will deliver a message to all admins on server",
			"#send name message - will deliver a message to specified player",
			"#tp name - will teleport specified player to you",
			"#kill name - will kill player",
			"#heal name - will fully heal specified player"
		];
	} else {
		"Avilable Commands" hintC [
			"#help message - will deliver a message to all admins on server"
		];
	};
	hintC_arr_EH = (findDisplay 72) displayAddEventHandler ["unload", {
		0 = _this spawn {
			_this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
			hintSilent "";
		};
	}];
}] call CBA_fnc_addEventHandler;

[QGVAR(helpMsg), {
	params ["_msg", "_unit"];
	systemChat format ["Help: %1 (%2) - %3", (name _unit), _unit, _msg];
}] call CBA_fnc_addEventHandler;

[QGVAR(sendMsg), {
	params ["_msg", "_unit"];
	systemChat format ["Admin: %1 - %2", (name _unit), _msg];
}] call CBA_fnc_addEventHandler;

[QGVAR(treatmentAdvanced_CPRLocal), {
	if (getNumber(configFile >> "CfgPatches" >> "ACE_Common" >> "version") < 3.13) then {
		_this call (treatmentAdvanced_CPRLocal);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(fullHeal), {
	params ["_unit"];
	if (getNumber(configFile >> "CfgPatches" >> "ACE_Common" >> "version") >= 3.13) then {
		[_unit] call ace_medical_treatment_fnc_fullHealLocal
	} else {
		[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;
	};
}] call CBA_fnc_addEventHandler;

#include "ChatCommands.sqf"
