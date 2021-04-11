
["help", {
	[QGVAR(avilableCommands), [(_this select 0)]] call CBA_fnc_localEvent;
}, "all"] call CBA_fnc_registerChatCommand;

["admin", {
	[QGVAR(helpMsg), [(_this select 0), player], ACTIVE_LIST] call CBA_fnc_targetEvent;
}, "all"] call CBA_fnc_registerChatCommand;

["send", {
	((_this select 0) splitString ":") params ["_name","_text"];
	_unit = (_name call GW_Common_fnc_findMatch);
	["GW_Admin_sendMsg", [_text, player], _unit] call CBA_fnc_targetEvent;
}, "all"] call CBA_fnc_registerChatCommand;

["TP", {
	if (GVARMAIN(isAdmin)) then {
		params ["_name"];
		private _unit = _name call EFUNC(Common,findMatch);

		if (isNull (objectParent player)) then {
			if !(isNull (objectParent _unit)) then {
				_unit action ["Eject", (vehicle _unit)];
				moveOut _unit;
			};
			_unit setPosASL (getPosASL player);
		} else {
			_veh = (vehicle player);
			_allSeats = (fullCrew [_veh, "", true]);
			_currentSeats = (fullCrew [_veh, "", false]);
			_seat = [];
			if !(_currentSeats isEqualTo _allSeats) then {
				_seats = (_allSeats - _currentSeats);
				_seat = (_seats select ((count _seats)) - 1);
			};
			switch (toLower(_seat select 1)) do {
				case "cargo": {
					_unit moveInCargo _veh;
				};
				case "turret": {
					_unit moveInTurret [_veh, (_seat select 3)];
				};
				case "gunner": {
					_unit moveInGunner _veh;
				};
				case "commander": {
					_unit moveInCommander _veh;
				};
				case "driver": {
					_unit moveInDriver _veh;
				};
			};
		};
	};
}, "all"] call CBA_fnc_registerChatCommand;

["kill", {
	if (GVARMAIN(isAdmin)) then {
		params ["_name"];
		private _unit = _name call EFUNC(Common,findMatch);
		_unit setDamage 1;
	};
}, "all"] call CBA_fnc_registerChatCommand;

if (GVARMAIN(mod_ACE)) then {
	["heal", {
		if (GVARMAIN(isAdmin)) then {
			params ["_name"];
			private _unit = _name call EFUNC(Common,findMatch);
			[QGVAR(fullHeal), _unit, _unit] call CBA_fnc_targetEvent;
			_unit setDamage 0;
		};
	}, "all"] call CBA_fnc_registerChatCommand;
};
