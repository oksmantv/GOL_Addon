#include "script_component.hpp"

if (hasInterface && ((getNumber(missionConfigFile >> "GW_Modules" >> "Common" >> "version")) >= 2.0)) then {
	[QGVAR(update), {
		[{
			[] call FUNC(simpleRoster);
		}, []] call CBA_fnc_execNextFrame;
	}] call CBA_fnc_addEventHandler;

	[QGVARMAIN(mapLoaded), {
		if (didJip) then {
			[QGVAR(update), []] call CBA_fnc_globalEvent;
		} else {
			[QGVAR(update), []] call CBA_fnc_localEvent;
		};
	}] call CBA_fnc_addEventHandler;
};

[QGVARMAIN(playerReady), {
	[QUOTE(PREFIX),QGVAR(Eject), "Eject", {
		if (!(isNull (objectParent player))) then {
			_vehicle = (vehicle player);
			if ((driver _vehicle) isEqualTo player) then {
				_vehicle engineOn false;
			};
			player action ["Eject", _vehicle];
			moveOut player;
		};
	}, {}, [-1,[false,false,false]]] call CBA_fnc_addKeybind;

	[{
		player addEventHandler ["GetInMan", {
			params ["_unit","_role","_veh","_index"];
			if (_veh isKindOf "AIR") then {
				2 fadeSound 0.8;
			};
		}];

		player addEventHandler ["GetOutMan", {
			params ["_unit","_role","_veh","_index"];
			if (isNull (objectParent _unit)) then {
				2 fadeSound 1;
			};
		}];

		["group", {
			[{
				{
					_color = (_x getVariable [QGVAR(GroupColor), "main"]);
					if !(_color isEqualTo "main") then {
						_x assignTeam _color;
					};
				} forEach (units (group player));
			}, [], 0.5] call CBA_fnc_waitAndExecute;
		}] call CBA_fnc_addPlayerEventHandler;

		if (GVARMAIN(mod_TFAR)) then {
			private _group = (group player);
			if !((_group getVariable "TF_lr_frequency") isEqualTo TF_freq_west_lr) then {
				_group setVariable ["TF_sw_frequency", TF_freq_west, true];
				_group setVariable ["TF_dd_frequency", TF_freq_west, true];
				_group setVariable ["TF_lr_frequency", TF_freq_west_lr, true];
			};

			player setVariable ["tf_globalVolume", 0.9];
			player setVariable ["TF_receivingDistanceMultiplicator", 1];
			player setVariable ["TF_sendingDistanceMultiplicator", EGVAR(Common,radioDistnace)];
		};
	}, [], 2] call CBA_fnc_waitAndExecute;

/*
	if (GVARMAIN(mod_RHS)) then {
		[{
			["END"] call RHS_fnc_dynamicObjectDrawing;
		}, [], 60] call CBA_fnc_waitAndExecute;
	};
*/

	if ((getNumber(missionConfigFile >> "GW_Modules" >> "Common" >> "version")) > 2.0) then {
		player assignTeam (player getVariable [QGVAR(GroupColor), "main"]);

		if ((leader (group player)) isEqualTo (leader player)) then {
			{
				if !(isPlayer _x) then {
					_x assignTeam (_x getVariable [QGVAR(GroupColor), "main"]);
				};
			} forEach (units (group player));
		};

		player addEventHandler ["InventoryOpened", {
			params ["_unit","_container","_secondaryContainer"];
			if (GVAR(BlockAIGear)) then {
				if (((_container isKindOf "CAManBase") && !(_container getVariable [QGVARMAIN(isPlayer), false])) || ((_secondaryContainer isKindOf "CAManBase") && (_secondaryContainer getVariable [QGVARMAIN(isPlayer), false]))) then {
					true
				};
			} else {
				false
			};
		}];
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(serverReady), {
	["AllVehicles", "init", {
		params ["_veh"];

		[{
			_this call FUNC(addToCurators);
		}, _veh, (random [3, 5, 7])] call CBA_fnc_waitAndExecute;

		if ((_veh isKindOf "Car") || (_veh isKindOf "Tank")) then {
			_veh allowCrewInImmobile true;
		};

		if (GVAR(disableThermals) > 0) then {
			_disableTI = false;
			if (GVAR(disableThermals) isEqualTo 1) then {
				_disableTI = true;
			} else {
				if (_veh isKindOf "LandVehicle") then {
					_disableTI = true;
				};
			};

			if !(_veh isKindOf "LSV_01_AT_base_F") then {
				_disableTI = false;
			};

			_veh disableTIEquipment _disableTI;
		};

		if (_veh isKindOf "Helicopter") then {
			_veh addEventHandler ["RopeAttach", {
				params ["_veh", "", "_object"];
				if (GVAR(slingloadEnabled)) then {
					if ((fullCrew _object) isEqualTo []) then {
						private _veh = owner _veh;
						if (_veh != owner _object) then {
							_object setOwner _veh;
						};
					};

//					[QGVAR(slingload), [_heli, _object]] call CBA_fnc_serverEvent;
				};
			}];
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(loadingScreenDone), {
	if (GVARMAIN(mod_TFAR)) then {
		if !((actionKeys "pushToTalk" isEqualTo []) && (actionKeys "voiceOverNet" isEqualTo [])) then {
			_show = false;
			_keybind = (["TFAR", "SWTransmit"] call CBA_fnc_getKeybind select 8);
			_keybind append (["TFAR", "LRTransmit"] call CBA_fnc_getKeybind select 8);
			{
				_key = (_x select 0);
				if ((_key in (actionKeys "pushToTalk")) || (_key in (actionKeys "voiceOverNet"))) then {
					_show = true;
				};
			} forEach _keybind;

			if (_show) then {
				[{
					"Warning Keybind Conflict" hintC [
						"'pushToTalk' or 'voiceOverNet' key is assigned",
						"Un/Re-bind them and make sure they are not conflicting with the TFAR Transmit keybinds",
						"Fix it to make this not show up next time"
					];
				}, [], 5] call CBA_fnc_waitAndExecute;
			};
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(slingload), {
	params ["_heli", "_object"];
	private _heliOwner = (owner _heli);
	if (_heliOwner != (owner _object)) then {
		_object setOwner _heliOwner;
		[QGVAR(slingloadMsg), true, _heli] call CBA_fnc_targetEvent;
		[QGVAR(slingloadSync), [_heli, _object]] call CBA_fnc_globalEvent;
	} else {
		[QGVAR(slingloadMsg), false, _heli] call CBA_fnc_targetEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(slingloadMsg), {
	if (_this) then {
		systemChat "Slingload: Object was synced to pilot";
	} else {
		systemChat "Slingload: Object already synced";
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(slingloadSync), {
	params ["_heli", "_object"];
	_heli disableCollisionWith _object;
}] call CBA_fnc_addEventHandler;
