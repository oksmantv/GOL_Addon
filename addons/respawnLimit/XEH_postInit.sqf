#include "script_Component.hpp"

if (isClass(missionConfigFile >> "GW_Modules" >> "Respawn")) exitWith {false};

[QGVARMAIN(playerReady), {
	if !(GVAR(Mode) isEqualTo 0) then {	// Dont activate if disabled
		["CAManBase", "Respawn", {
			params ["_unit"];
			[QGVAR(respawnServer), [_unit]] call CBA_fnc_serverEvent;
		}, true, [], true] call CBA_fnc_addClassEventHandler;

		[QGVAR(initServer), [player]] call CBA_fnc_serverEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(initServer), {
	params ["_unit"];
	private _uid = (getPlayerUID _unit);
	private _respawns = 0;
	private _connectionType = false;
	if (GVAR(JIP) || (EGVAR(gameLoop,SafeMode_Enabled) || (time < 30))) then {
//	if (GVAR(JIP) || (time < 30)) then {
		_connectionType = true;
		if !(_uid in GVAR(ServerConnections)) then {
			GVAR(ServerConnections) pushBackUnique _uid;
		};
	};
	_respawns = GVAR(Count);
	if (_uid in GVAR(ServerDead)) then {
		_respawns = (GVAR(Count) - ({_x isEqualTo _uid} count GVAR(ServerDead)));
		if (_respawns <= 0) then {
			_connectionType = false;
		};
	};
	_unit setVariable [QGVAR(isSpectating), false, true];
	_unit setVariable [QGVAR(Count), _respawns, true];
	[QGVAR(initPlayer), [_unit, _connectionType], _unit] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(initPlayer), {
	params ["_unit","_JIP"];
	private _uid = (getPlayerUID _unit);
	private	_respawns = ([_unit] call FUNC(getRespawns));
	if (_respawns > 0 || _JIP) then {
		systemChat format ["%1 connected to server", (name _unit)];
		if (GVAR(Mode) isEqualTo 1) then {
			if (_respawns isEqualTo 1) then {
				systemChat "Last life!!, when you die you will be in spectator";
			} else {
				if (_respawns <= 0) then {
					_respawns = 0;
				} else {
					_respawns = (_respawns - 1);
				};
				systemChat format ["%1 respawns remaining", (_respawns)];
			};
		};
		if (GVAR(Mode) isEqualTo 2) then {
			systemChat format ["Your team have %1 respawns remaining", _respawns];
		};
	} else {
		if !(GVAR(Mode) isEqualTo 0) then {
			systemChat format ["JIP is diabled or %1 is trying to re-slot", (name _unit)];
			[QGVAR(SpectatorToggle), [_unit, true]] call CBA_fnc_localEvent;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnServer), {
	params [["_unit", objNull, [objNull]]];
	private _uid = (getPlayerUID _unit);
	private _respawns = 0;

	if (_uid isEqualTo "") exitWith {false};

	GVAR(ServerDead) pushBack _uid;

	if (GVAR(Mode) isEqualTo 1) then {
		_respawns = ([_unit] call FUNC(getRespawns));
		if !(_respawns isEqualTo 0) then {
			DEC(_respawns);
			_unit setVariable [QGVAR(Count), _respawns, true];
		};
	};

	if (GVAR(Mode) isEqualTo 2) then {
		switch ([_unit] call EFUNC(Common,getSide)) do {
			case 0: {
				DEC(GVAR(CountTeamEast));
				publicVariable QGVAR(CountTeamEast);
			};
			case 1: {
				DEC(GVAR(CountTeamWest));
				publicVariable QGVAR(CountTeamWest);
			};
			case 2: {
				DEC(GVAR(CountTeamIndependent));
				publicVariable QGVAR(CountTeamIndependent);
			};
			case 3: {
				DEC(GVAR(CountTeamCivilian));
				publicVariable QGVAR(CountTeamCivilian);
			};
		};
	};

	if !(GVAR(Mode) isEqualTo 0) then {
		if (([_unit] call FUNC(getRespawns)) > 0) then {
			[{
				params ["_unit"];
				[QGVAR(respawnPlayer), [_unit], _unit] call CBA_fnc_targetEvent;
			}, [_unit], 0.1] call CBA_fnc_waitAndExecute;
		} else {
			GVAR(ServerDeadPermanent) pushBack _uid;
			[QGVAR(SpectatorToggle), [_unit, true], _unit] call CBA_fnc_targetEvent;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnPlayer), {
	params ["_unit"];
	private _respawns = ([_unit] call FUNC(getRespawns));

	if (_respawns >= 1) then {
		if (call GVAR(IsSpectator)) then {
			[QGVAR(SpectatorToggle), [_unit, false]] call CBA_fnc_localEvent;
		};
		if (_respawns isEqualTo 1) then {
			systemChat "Last life!!, when you die you will be in spectator";
		} else {
			systemChat format ["%1 more lives remaining", (_respawns - 1)];
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(secondChanceServer), {
	params ["_unit",["_add", 1, [0]]];
	private _respawns = ([_unit] call FUNC(getRespawns));

	if (_respawns < 1) then {
		GVAR(ServerDeadPermanent) deleteAt (GVAR(ServerDeadPermanent) find (getPlayerUID _unit));
	};

	if (GVAR(Mode) isEqualTo 1) then {
		_respawns = (_respawns + _add);
		_unit setVariable [QGVAR(Count), _respawns, true];
	};

	if (GVAR(Mode) isEqualTo 2) then {
		switch ([_unit] call EFUNC(Common,getSide)) do {
			case 0: {
				ADD(GVAR(CountTeamEast), _add);
				publicVariable QGVAR(CountTeamEast);
			};
			case 1: {
				ADD(GVAR(CountTeamWest), _add);
				publicVariable QGVAR(CountTeamWest);
			};
			case 2: {
				ADD(GVAR(CountTeamIndependent), _add);
				publicVariable QGVAR(CountTeamIndependent);
			};
			case 3: {
				ADD(GVAR(CountTeamCivilian), _add);
				publicVariable QGVAR(CountTeamCivilian);
			};
		};
	};
	[QGVAR(secondChancePlayer), [_unit], _unit] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(secondChancePlayer), {
	params ["_unit"];
	private _respawns = ([_unit] call FUNC(getRespawns));

	if (_unit getVariable [QGVAR(isSpectating), false]) then {
		[QGVAR(SpectatorToggle), [_unit, false]] call CBA_fnc_localEvent;
		cutText ["","BLACK IN",5];
		_unit setPosASL (_unit getVariable [QGVARMAIN(spawnLocation), (getMarkerPos format (["respawn_%1", str([_unit] call EFUNC(Common,getSide))]))]);
		systemChat "You have been given a second chance";
	} else {
		systemChat format ["You have been given one more respawn, total respawns: %1", (_respawns - 1)];
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(SpectatorToggle), {
	params ["_unit","_active"];

	if (GVARMAIN(mod_ACRE)) then {
		[_active] call acre_api_fnc_setSpectator;
	};
	if (GVARMAIN(mod_TFAR)) then {
		[_unit, _active] call TFAR_fnc_forceSpectator;
	};
	_unit setVariable [QGVAR(isSpectating), _active, true];

	if (_active) then {
		cutText ["","BLACK Out",5];
		cutText ["","BLACK IN",5];
		systemChat "You are being moved to spectator";
		_unit setPosATL (getMarkerPos "spectator");
		if !(["IsSpectating"] call BIS_fnc_EGSpectator) then {
			(["Initialize", [player, [], true]] call BIS_fnc_EGSpectator);
			RscSpectator_allowFreeCam = false;
		};
//		[true] call ace_spectator_fnc_setSpectator;
	} else {
		(["Terminate"] call BIS_fnc_EGSpectator);
	};
}] call CBA_fnc_addEventHandler;
