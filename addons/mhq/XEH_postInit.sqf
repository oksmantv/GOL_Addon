#include "script_component.hpp"

diag_log "[GW][MHQ] XEH_postInit started";

["CAManBase", "Respawn", {
	[{
		(_this select 0) spawn {
			_this setVariable ["GOL_TeleportDelay",true,true];
			_Delay = 120;
			for [{ private _i = _Delay }, { _i > 0 }, { _i = _i - 1}] do {
				[parseText format[
					("<t color='#f5791b'>"+
					"<t size='1.3'>RESPAWN DELAY</t>"+
					"<br/><t size='1.1'>YOU MAY USE SCRIPTED REINSERT IN:<br/><br/>"+
					"<t size='2'>%1</t></t></t>")
				,_i]] remoteExec ["hintSilent",_this];
				sleep 1;
			};
			[parseText
					("<t color='#f5791b'>"+
					"<t size='1.3'>RESPAWN DELAY</t>"+
					"<br/><br/><t size='1.1'>YOU MAY NOW USED SCRIPTED REINSERT.</t></t>")
			] remoteExec ["hintSilent",_this];
			_this setVariable ["GOL_TeleportDelay",false,true];
		};		
		_this call FUNC(HandlerRespawn);
	}, _this] call CBA_fnc_execNextFrame;
}, true, [], true] call CBA_fnc_addClassEventHandler;

diag_log "[GW][MHQ] XEH_postInit finished";

[QGVAR(PlayMechanicalSounds), {
	_this call FUNC(playMHQMechanicalSounds);
}] call CBA_fnc_addEventHandler;

[QGVAR(SetMobileSource), {
	if (isServer) then {
		_this call FUNC(setMHQMobileSource);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(SatelliteLoop), {
	if (isServer) then {
		_this call FUNC(loopMHQSatellite);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(Enabled), {
	params [
		"_mhq",
		["_toggle",false,[true]],
		["_side","West",["",0]]
	];

	_mhq setVariable [QGVAR(Active), _toggle, true];
	TRACE_3("QGVAR(Enabled)", _mhq, (_mhq getVariable [QGVAR(Active), false]), _toggle);
	if (_mhq getVariable [QGVAR(Active), false]) then {
		_mhq setVariable [QGVAR(Fuel), (fuel _mhq)];
		_mhq setVariable [QGVAR(Side), toLower(_side), true];
		[_mhq,0] remoteExecCall ["setFuel", _mhq];
	} else {	// restore fuel
		[_mhq,(_mhq getVariable [QGVAR(Fuel), (fuel _mhq)])] remoteExecCall ["setFuel", _mhq];
		[QGVAR(Assembled), [_mhq, false]] call CBA_fnc_LocalEvent;
	};
	if (typeOf _mhq isNotEqualTo "GOL_Mobile_HQ") then {
		[_mhq, ((_mhq getVariable [QGVAR(Active), false]) || (_mhq getVariable [QGVAR(Assembled), false]))] call FUNC(applyMHQAnimations);
	} else {
		[QGVAR(SetMobileSource), [_mhq, "Terminal_source_sound", 0, true]] call CBA_fnc_serverEvent;
		[QGVAR(SatelliteLoop), [_mhq, _toggle && {_mhq getVariable [QGVAR(Assembled), false]}]] call CBA_fnc_serverEvent;
	};
	[QGVAR(Actions), [_mhq]] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(Assembled), {
	params [
		"_mhq",
		["_toggle",false,[true]]
	];

	_mhq setVariable [QGVAR(Assembled), _toggle, true];
	if (_mhq getVariable [QGVAR(Assembled), false]) then {
		[_mhq] call FUNC(prefabCreate);
//		[_mhq, (_mhq getVariable QGVAR(Info)) select 4] call FUNC(getDeployType);
	} else {	// Remove objects
		{
			deleteVehicle _x;
		} forEach (_mhq getVariable QGVAR(objectsCreated));
		_mhq setVariable [QGVAR(objectsCreated), [], true];
	};

	if (_toggle) then {
		GVAR(AssembledArray) pushBackUnique _mhq;
		publicVariable QGVAR(AssembledArray);
		if !(_mhq getVariable [QGVAR(Active), false]) then {
			[QGVAR(Enabled), [_mhq, true]] call CBA_fnc_serverEvent;
		};
	} else {
		GVAR(AssembledArray) deleteAt (GVAR(AssembledArray) find _mhq);
		publicVariable QGVAR(AssembledArray);
	};
	if (typeOf _mhq isNotEqualTo "GOL_Mobile_HQ") then {
		[_mhq, ((_mhq getVariable [QGVAR(Active), false]) || (_mhq getVariable [QGVAR(Assembled), false]))] call FUNC(applyMHQAnimations);
	} else {
		if (_toggle && {_mhq getVariable [QGVAR(Active), false]}) then {
			[QGVAR(SatelliteLoop), [_mhq, true]] call CBA_fnc_serverEvent;
		} else {
			[QGVAR(SatelliteLoop), [_mhq, false]] call CBA_fnc_serverEvent;
			if (_mhq getVariable [QGVAR(Active), false]) then {
				[QGVAR(SetMobileSource), [_mhq, "Terminal_source", 45, false]] call CBA_fnc_serverEvent;
			};
		};
	};
	TRACE_3("QGVAR(Assembled)", _mhq, (_mhq getVariable [QGVAR(Assembled), false]), _toggle);
}] call CBA_fnc_addEventHandler;

[QGVAR(Actions), {
	#define	ARGUMENT(VAR) VAR,1,false,false,""
	#define	CONDITION_1 "(alive _target) && (vehicle player isEqualTo player) && !(player getVariable ['GOL_TeleportDelay',false])"
	#define	CONDITION_2 "(_target getVariable 'GW_MHQ_Assembled')"
	#define	CONDITION_3 "(alive _target) && (speed _target) < 0.1"
	#define CONDITION_4 "(gunner _target) == player || (driver _target) == player || (commander _target) == player || vehicle player isNotEqualTo _target"
	params ["_mhq"];
	[_mhq, _mhq getVariable [QGVAR(Active), false]] call FUNC(loopMHQActiveSound);
	diag_log format["[MHQ DEBUG] _MHQ Variable: %1",_mhq];
	private _startMaintenanceAnimation = {
		params ["_target", "_caller", "_actionId", "_args"];
		_args params ["", "_duration", "_mobileHQAction"];
		if (typeOf _target isEqualTo "GOL_Mobile_HQ" && {_mobileHQAction in ["activate", "deactivate"]}) then {
			if (_mobileHQAction isEqualTo "activate") then {
				[QGVAR(SetMobileSource), [_target, "Terminal_source", 45, false]] call CBA_fnc_serverEvent;
				[QGVAR(PlayMechanicalSounds), [_target, "activate"]] call CBA_fnc_globalEvent;
			} else {
				[QGVAR(SatelliteLoop), [_target, false]] call CBA_fnc_serverEvent;
				[QGVAR(SetMobileSource), [_target, "Terminal_source", 100, true]] call CBA_fnc_serverEvent;
			};
			[QGVAR(SetMobileSource), [_target, "Progress_source", [0, 100] select (_mobileHQAction isEqualTo "deactivate"), true]] call CBA_fnc_serverEvent;
			_caller setVariable [format ["GW_MHQ_HoldActionStarted_%1", _actionId], diag_tickTime];
			_caller setVariable [format ["GW_MHQ_HoldActionTerminalClosing_%1", _actionId], false];
		};
		if (vehicle _caller isNotEqualTo _caller) exitWith {};
		_caller setVariable [format ["GW_MHQ_HoldActionAnimated_%1", _actionId], true];
		_caller playMove "AinvPknlMstpSnonWnonDnon_medic4";
	};
	private _loopMaintenanceAnimation = {
		params ["_target", "_caller", "_actionId", "_args"];
		_args params ["", "_duration", "_mobileHQAction"];
		if (typeOf _target isEqualTo "GOL_Mobile_HQ" && {_mobileHQAction in ["activate", "deactivate"]}) then {
			private _startedAt = _caller getVariable [format ["GW_MHQ_HoldActionStarted_%1", _actionId], diag_tickTime];
			private _progress = 100 * (((diag_tickTime - _startedAt) / _duration) min 1);
			[QGVAR(SetMobileSource), [_target, "Progress_source", [_progress, 100 - _progress] select (_mobileHQAction isEqualTo "deactivate"), true]] call CBA_fnc_serverEvent;
			if (_mobileHQAction isEqualTo "deactivate" && {_progress >= 70} && {!(_caller getVariable [format ["GW_MHQ_HoldActionTerminalClosing_%1", _actionId], false])}) then {
				_caller setVariable [format ["GW_MHQ_HoldActionTerminalClosing_%1", _actionId], true];
				[QGVAR(SetMobileSource), [_target, "Terminal_source", 0, false]] call CBA_fnc_serverEvent;
			};
		};
		if (vehicle _caller isNotEqualTo _caller || {!(_caller getVariable [format ["GW_MHQ_HoldActionAnimated_%1", _actionId], false])}) exitWith {};
		if !((toLowerANSI animationState _caller) find "ainvpknlmstpsnonwnondnon_medic4" == 0) then {
			_caller playMove "AinvPknlMstpSnonWnonDnon_medic4";
		};
	};
	private _finishMaintenanceAnimation = {
		params ["_target", "_caller", "_actionId", "_completed", "_mobileHQAction"];
		_caller setVariable [format ["GW_MHQ_HoldActionStarted_%1", _actionId], nil];
		_caller setVariable [format ["GW_MHQ_HoldActionTerminalClosing_%1", _actionId], nil];
		if (typeOf _target isEqualTo "GOL_Mobile_HQ" && {_mobileHQAction in ["activate", "deactivate"]}) then {
			if (!_completed) then {
				private _cancelState = [0, 100] select (_mobileHQAction isEqualTo "deactivate");
				[QGVAR(SetMobileSource), [_target, "Progress_source", _cancelState, false]] call CBA_fnc_serverEvent;
				[QGVAR(SetMobileSource), [_target, "Terminal_source", _cancelState, false]] call CBA_fnc_serverEvent;
				if (_mobileHQAction isEqualTo "deactivate") then {
					[QGVAR(SatelliteLoop), [_target, true]] call CBA_fnc_serverEvent;
				};
			} else {
				if (_mobileHQAction isEqualTo "activate") then {
					[QGVAR(SetMobileSource), [_target, "Progress_source", 100, true]] call CBA_fnc_serverEvent;
				} else {
					[QGVAR(SetMobileSource), [_target, "Progress_source", 0, true]] call CBA_fnc_serverEvent;
					[QGVAR(PlayMechanicalSounds), [_target, "deactivate"]] call CBA_fnc_globalEvent;
				};
			};
		};
		private _variableName = format ["GW_MHQ_HoldActionAnimated_%1", _actionId];
		if !(_caller getVariable [_variableName, false]) exitWith {};
		_caller setVariable [_variableName, nil];
		if (vehicle _caller isNotEqualTo _caller) exitWith {};
		_caller switchMove "AinvPknlMstpSnonWnonDnon_medicEnd";
	};

	private	_add = [];
	private _mhqActiveActions = (_mhq getVariable [QGVAR(ActiveActions), []]);
	{
		[(_x select 0), (_x select 1)] call BIS_fnc_holdActionRemove;
		(_x select 0) removeAction (_x select 1);
	} forEach _mhqActiveActions;
	_mhq setVariable [QGVAR(ActiveActions), []];

	if (_mhq getVariable QGVAR(Active)) then {
		diag_log format["[MHQ DEBUG DEACTIVATE] _MHQ Variable: %1",_mhq];
		_id = [
			_mhq,
			"<t color='#ec2b14'>Deactivate MHQ</t>",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_unbind_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_unbind_ca.paa",
			CONDITION_4 + " && " + CONDITION_3 + " && !" + CONDITION_2,
			CONDITION_4 + " && " + CONDITION_3 + " && !" + CONDITION_2,
			_startMaintenanceAnimation,
			_loopMaintenanceAnimation,
			{
				params ["_target", "_caller", "_actionId", "_args"];
				_args params ["_finishMaintenanceAnimation"];
				[QGVAR(Enabled), [_target, false, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent;
				_mhqMarkerId setMarkerAlpha 0;
				(format ["%1_Area", _mhqMarkerId]) setMarkerAlpha 0;
				[_target, _caller, _actionId, true, "deactivate"] call _finishMaintenanceAnimation;
			},
			{ params ["_target", "_caller", "_actionId", "_args"]; _args params ["_finishMaintenanceAnimation"]; [_target, _caller, _actionId, false, "deactivate"] call _finishMaintenanceAnimation; },
			[_finishMaintenanceAnimation, 5, "deactivate"],
			5,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushBack [_mhq, _id, true];

		_id = [
			_mhq,
			"<t color='#0fdf29'>Assemble MHQ</t>",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_loaddevice_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_loaddevice_ca.paa",
			CONDITION_1 + " && !" + CONDITION_2,
			CONDITION_1 + " && !" + CONDITION_2,
			_startMaintenanceAnimation,
			_loopMaintenanceAnimation,
			{
				params ["_target", "_caller", "_actionId", "_args"];
				_args params ["_finishMaintenanceAnimation"];
				[QGVAR(Assembled), [_target, true]] call CBA_fnc_serverEvent;
				[QGVAR(PlayMechanicalSounds), [_target, "assemble"]] call CBA_fnc_globalEvent;
				[_target, _caller, _actionId, true, ""] call _finishMaintenanceAnimation;
			},
			{ params ["_target", "_caller", "_actionId", "_args"]; _args params ["_finishMaintenanceAnimation"]; [_target, _caller, _actionId, false, ""] call _finishMaintenanceAnimation; },
			[_finishMaintenanceAnimation, 10, ""],
			10,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushBack [_mhq, _id, true];

		_id = [
			_mhq,
			"<t color='#ec2b14'>Disassemble MHQ</t>",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_unloaddevice_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_unloaddevice_ca.paa",
			CONDITION_1 + " && " + CONDITION_2,
			CONDITION_1 + " && " + CONDITION_2,
			_startMaintenanceAnimation,
			_loopMaintenanceAnimation,
			{
				params ["_target", "_caller", "_actionId", "_args"];
				_args params ["_finishMaintenanceAnimation"];
				[QGVAR(Assembled), [_target, false]] call CBA_fnc_serverEvent;
				[QGVAR(PlayMechanicalSounds), [_target, "disassemble"]] call CBA_fnc_globalEvent;
				[_target, _caller, _actionId, true, ""] call _finishMaintenanceAnimation;
			},
			{ params ["_target", "_caller", "_actionId", "_args"]; _args params ["_finishMaintenanceAnimation"]; [_target, _caller, _actionId, false, ""] call _finishMaintenanceAnimation; },
			[_finishMaintenanceAnimation, 10, ""],
			10,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushBack [_mhq, _id, true];
		_id = [
			_mhq,
			"<t color='#eeb20e'>Teleport to Staging Area</t>",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			"(alive _target) && (vehicle _this isEqualTo _this) && !(_this getVariable ['GOL_TeleportDelay', false])",
			"(alive _target) && (vehicle _this isEqualTo _this) && !(_this getVariable ['GOL_TeleportDelay', false])",
			{},
			{},
			{
				params ["_target", "_caller"];
				[_caller, ([_target] call FUNC(getFlag))] call BIS_fnc_moveToRespawnPosition;
			},
			{},
			[],
			3,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushback [_mhq, _id, true];
		private _mhqName = _mhq;
		if(["p3d", str _mhq] call BIS_fnc_inString) then {
			_mhqName = format["%1 MHQ",[configFile >> "CfgVehicles" >> typeOf _mhq] call BIS_fnc_displayName];
		};
		_id = [
			([_mhq] call FUNC(getFlag)),
			format ["<t color='#eeb20e'>Teleport to %1</t>", _mhqName],
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			"(alive _target) && (vehicle _this isEqualTo _this) && !(_this getVariable ['GOL_TeleportDelay', false])",
			"(alive _target) && (vehicle _this isEqualTo _this) && !(_this getVariable ['GOL_TeleportDelay', false])",
			{},
			{},
			{
				params ["_target", "_caller", "_actionId", "_args"];
				_args params ["_mhq"];
				diag_log format["[MHQ DEBUG TELEPORT TO] _MHQ Variable: %1",_mhq];
				private _MhqSafeZone = missionNamespace getVariable ["MHQSAFEZONE",50];
				private _EnemyNearUnits = (_mhq nearEntities ["Man", _MhqSafeZone]) select {(side _X) getFriend (side _caller) < 0.6 && side _X != civilian};
				if(count _EnemyNearUnits == 0) then {	
					private _height = 5;
					private _sleep = 3.5;	
					private _camera = "camera" camCreate [getPosATL _mhq select 0,getPosATL _mhq select 1,100];
					cutText ["", "BLACK OUT",1]; sleep 1;
					1 fadeSound 0;
					cutText ["", "BLACK IN",1];
					if(vehicleVarName _mhq == "Mobile_HQ") then {
						[_caller, _mhq] call BIS_fnc_moveToRespawnPosition;
						_camera camSetTarget _caller;
						_height = 2;
						_sleep = 5;
					} else {
						_camera camSetTarget _mhq;
					};	
					showCinemaBorder true;
					_camera cameraEffect ["internal", "back"];
					waitUntil { camCommitted _camera; };
					1 fadeSound 1;

					_camera camSetPos [getPosATL _mhq select 0, getPosATL _mhq select 1, _height];
					_camera camCommit 4.5;
					sleep _sleep;
					cutText ["", "BLACK OUT", 1];
					waitUntil { sleep 1; camCommitted _camera; };
					_camera cameraEffect ["terminate", "back"];
					camDestroy _camera;
					if (vehicleVarName _mhq != "Mobile_HQ") then {
						[_caller, _mhq] call BIS_fnc_moveToRespawnPosition;
					};
					sleep 1.1;
					cutText ["", "BLACK IN", 1];
				} else {
					if (count crew _mhq > 0) then {
						systemChat format ["Enemies are near the MHQ. You cannot move to the MHQ until the immediate area is secure (%1m). The crew has been notified.", _MhqSafeZone];
						(format ["Reinsert: %1 attempted to move to the MHQ.", name _caller]) remoteExec ["SystemChat", crew _mhq];
					} else {
						private _groupLeaders = [];
						systemChat format ["Enemies are near the MHQ. You cannot move to the MHQ until the immediate area is secure (%1m). Group leaders have been notified", _MhqSafeZone];
						if (!isNil "flag_west_1") then { _groupLeaders = allPlayers select {leader group _x isEqualTo _x && _x distance flag_west_1 > 100}; };
						if (!isNil "flag_east_1") then { _groupLeaders = allPlayers select {leader group _x isEqualTo _x && _x distance flag_east_1 > 100}; };
						(format ["Reinsert: %1 attempted to move to the MHQ.", name _caller]) remoteExec ["SystemChat", _groupLeaders];
					};
					_caller spawn {
						_this setVariable ["GOL_TeleportDelay", true, true];
						for [{private _i = 10}, {_i > 0}, {_i = _i - 1}] do {
							[parseText format ["<t color='#f5791b'><t size='1.3'>RESPAWN DELAY</t><br/><t size='1.1'>YOU MAY USE SCRIPTED REINSERT IN:<br/><br/><t size='2'>%1</t></t></t>", _i]] remoteExec ["hintSilent", _this];
							sleep 1;
						};
						[parseText "<t color='#f5791b'><t size='1.3'>RESPAWN DELAY</t><br/><br/><t size='1.1'>YOU MAY NOW USED SCRIPTED REINSERT.</t></t>"] remoteExec ["hintSilent", _this];
						sleep 2;
						_this setVariable ["GOL_TeleportDelay", false, true];
					};
				};
			},
			{},
			[_mhq],
			1,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushback [([_mhq] call FUNC(getFlag)), _id, true];
	} else {
		diag_log format["[MHQ DEBUG ELSE] _MHQ Variable: %1",_mhq];

		_id = [
			_mhq,
			"<t color='#0fdf29'>Activate MHQ</t>",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			"\A3\ui_f\data\IGUI\Cfg\holdactions\holdaction_connect_ca.paa",
			CONDITION_4 + " && " + CONDITION_3,
			CONDITION_4 + " && " + CONDITION_3,
			_startMaintenanceAnimation,
			_loopMaintenanceAnimation,
			{
				params ["_target", "_caller", "_actionId", "_args"];
				_args params ["_finishMaintenanceAnimation"];
				private _mhqSafeZone = missionNamespace getVariable ["MHQSAFEZONE", 50];
				private _enemyNearUnits = (_target nearEntities ["Man", _mhqSafeZone]) select {(side _x) getFriend (side player) < 0.6 && side _x != civilian};
				if (_enemyNearUnits isEqualTo []) then {
					[QGVAR(Enabled), [_target, true, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent;
					private _mhqMarkerId = _target getVariable ["MHQ_MarkerId", ""];
					_mhqMarkerId setMarkerAlpha 1;
					_mhqMarkerId setMarkerPos (getPos _target);
					private _mhqMarkerAreaId = format ["%1_Area", _mhqMarkerId];
					_mhqMarkerAreaId setMarkerAlpha 1;
					_mhqMarkerAreaId setMarkerPos (getPos _target);
					private _players = [];
					if (!isNil "flag_west_1") then { _players = allPlayers select {_x distance flag_west_1 < 100}; };
					if (!isNil "flag_east_1") then { _players = allPlayers select {_x distance flag_east_1 < 100}; };
					MHQ_waitUntilDelayOver = {
						params ["_mhq"];
						waitUntil { sleep 1; !(player getVariable ["GOL_TeleportDelay", false]) };
						if (_mhq getVariable "GW_MHQ_Active") then {
							hint parseText "<t color='#f5791b'><t size='1.3'>MOBILE HQ ACTIVE</t><br/><br/><t size='1.1'>YOU MAY NOW TELEPORT TO MHQ.</t></t>";
						};
					};
					if !(_players isEqualTo []) then { [_target] remoteExec ["MHQ_waitUntilDelayOver", _players]; };
				} else {
					systemChat format ["Enemies are near the MHQ. You cannot activate the MHQ until the immediate area is secure (%1m).", _mhqSafeZone];
				};
				[_target, _caller, _actionId, true, "activate"] call _finishMaintenanceAnimation;
			},
			{ params ["_target", "_caller", "_actionId", "_args"]; _args params ["_finishMaintenanceAnimation"]; [_target, _caller, _actionId, false, "activate"] call _finishMaintenanceAnimation; },
			[_finishMaintenanceAnimation, 5, "activate"],
			5,
			7,
			false,
			false
		] call BIS_fnc_holdActionAdd;
		_add pushBack [_mhq, _id, true];
	};
	_mhq setVariable [QGVAR(ActiveActions), _add];
	TRACE_2("QGVAR(Actions)", _mhq, _mhqActiveActions);
}] call CBA_fnc_addEventHandler;
