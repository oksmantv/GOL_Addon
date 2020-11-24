#include "script_component.hpp"

[{
	GVAR(PFH) = [{
		if (GVAR(isEnabled)) then {
			private _machine = 0;

			if (isServer) then {
				_machine = 1;
				[{
					[] call FUNC(addUpdate);
				}, [], 1] call CBA_fnc_waitAndExecute;
			};

			if (CBA_isHeadlessClient) then {
				_machine = 2;
				_units = ({local _x} count allUnits);
				_groups = ({local _x} count allGroups);
				[QGVAR(sendInfoHC), [player, _units, _groups, (round diag_fps)]] call CBA_fnc_serverEvent;
			};

			[QGVAR(sendInfo), [_machine, (round diag_fps)]] call CBA_fnc_serverEvent;
		};
	}, 4, []] call CBA_fnc_addPerFrameHandler;

	if (CBA_isHeadlessClient) then {
		[QGVAR(addHC), player] call CBA_fnc_serverEvent;
	};

	if (isServer) then {
		addMissionEventHandler ["HandleDisconnect",{
			params ["_unit","_id","_uid","_name"];
			if !(_unit isKindOf "HeadlessClient_F") exitWith {false};
			GVAR(HeadlessList) deleteAt (GVAR(HeadlessList) find _unit);
			publicVariable QGVAR(HeadlessList);
		}];
	};
}, [], 3] call CBA_fnc_waitAndExecute;
