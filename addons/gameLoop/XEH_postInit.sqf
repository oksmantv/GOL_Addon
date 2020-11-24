#include "script_Component.hpp"

//	if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};
if (isClass(missionConfigFile >> "GW_Modules" >> "StartUp")) exitWith {false};

if (isServer) then {
	[QGVARMAIN(missionStarted), {
		if (GVAR(SafeMode_useType) > 0) then {
			GVAR(SafeMode_Enabled) = true;
			publicVariable QGVAR(SafeMode_Enabled);
		};
	}] call CBA_fnc_addEventHandler;
};

[QGVARMAIN(serverReady), {
	if (GVAR(SafeMode_useType) > 0) then {
		[] spawn {
			_count = -1;
			while {GVAR(SafeMode_Enabled)} do {
				_count = _count + 1;
				_time = _count;
				if (GVAR(SafeMode_useType) isEqualTo 1) then {
					_time = (GVAR(SafeMode_Timer) - _count);

					if (GVAR(SafeMode_Timer) <= _count) then {
						[QGVAR(setSafetyMode), false] call CBA_fnc_globalEvent;
					};
				};
				[QGVAR(SafeMode_CountDown), [([_time, (_time + 1)] select (GVAR(SafeMode_useType) isEqualTo 2))]] call CBA_fnc_globalEvent;

				sleep 60;
			};

			_count = 0;
			while {!GVAR(SafeMode_Enabled)} do {	// Game Timer - End on debriefing
				_count = (_count + 1);
				[QGVAR(MissionTime), [_count, ((GVAR(event) * 60) * _count)]] call CBA_fnc_serverEvent;
				sleep (60 * GVAR(event));
			};
		};
	};

	if (GVAR(civiKillTracker)) then {
		["CAManBase", "Killed", {
			params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]]];
			if (getNumber(configfile >> "CfgVehicles" >> (typeOf _unit) >> "side") isEqualTo 3) then {
				GVAR(CiviKillCount) = GVAR(CiviKillCount) + 1;
				[QGVAR(CiviKillEvent), [GVAR(CiviKillCount), _killer], ([] call CBA_fnc_players)] call CBA_fnc_TargetEvent;
			};
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(playerReady), {
	if (GVAR(SafeMode_useType) isEqualTo 0) exitWith {false};

	[QGVAR(setSafetyMode), GVAR(SafeMode_Enabled)] call CBA_fnc_localEvent;

	#include "XEH_postInitPlayer.sqf"

	[] spawn {
		if !((markerType "protection_west") isEqualTo "") then {
			GVAR(SafeZoneMarkers) pushBackUnique [west, "protection_west"];
		};
		if !((markerType "protection_east") isEqualTo "") then {
			GVAR(SafeZoneMarkers) pushBackUnique [east, "protection_east"];
		};
		if !((markerType "protection_resistance") isEqualTo "") then {
			GVAR(SafeZoneMarkers) pushBackUnique [independent, "protection_resistance"];
		};
		private _marker = "";
		{
			if ((([player] call EFUNC(Common,getSide)) isEqualTo (_x select 0)) && ((getPosATL player) inArea (_x select 1))) then {
				_marker = (_x select 1);
			};
		} forEach GVAR(SafeZoneMarkers);

		waitUntil {
			_pos = (getPosATL (vehicle player));

			if (_pos inArea _marker) then {
				GVAR(SafeZonePos) = _pos;
			} else {
				if !(isNIl QGVAR(SafeZonePos)) then {
					player setPosATL GVAR(SafeZonePos);
					["You can leave the zone during warmup", 5] call GW_Common_Fnc_Hint;
				};
			};
			sleep 0.1;
			!(GVAR(SafeMode_Enabled) && !(_marker isEqualTo ""))
		};
		_marker setMarkerAlphaLocal 0;
		GVAR(SafeZoneMarkers) = nil;
		GVAR(SafeZonePos) = nil;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(SafeMode_CountDown), {
	if (hasInterface) then {
		params["_number"];
		TRACE_1("QGVAR(SafeMode_CountDown)", _number);
		if (_number <= -1) then {
			systemChat "[SafeMode]: Weapons & Vehicles are now active";
		} else {
			if (GVAR(SafeMode_useType) isEqualTo 1) then {
				systemChat format ["[SafeMode]: Weapons are cold, Time Remaining until mission starts: %1 min", _number];
			} else {
				systemChat format ["[SafeMode]: Weapons are cold, Waiting for admin to start. (%1 minutes since map screen)", _number];
			};
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(setSafetyMode), {
	if (isServer) then {
		GVAR(SafeMode_Enabled) = _this;
		publicVariable QGVAR(SafeMode_Enabled);
	};
	if (hasInterface) then {
		TRACE_1("QGVAR(setSafetyMode)", _this);
		[_this, false] call FUNC(WeaponLock);
		if (!GVAR(SafeMode_Enabled) && (GVAR(SafeMode_useType) isEqualTo 2)) then {
			systemChat "[SafeMode]: Weapons & Vehicles are now active";
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(CiviKillEvent), {
	params ["_count","_killer"];
	systemChat format ["Civilian Killed by %1, Be Careful %2 Civi(s) has been killed in this mission", (name _killer), _count];
}] call CBA_fnc_addEventHandler;

#ifdef DEBUG_MODE_FULL
	[QEGVAR(gameLoop,MissionTime), {
		params ["_count","_time"];
		systemChat format ["MissionTime: %1", _this];
	}] call CBA_fnc_addEventHandler;
#endif
