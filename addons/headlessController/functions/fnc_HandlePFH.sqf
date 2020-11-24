#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl

	Usage:
	[] call GW_HeadlessController_Fnc_HandlePFH

	Arguments: NO

	Return Value: YEs <BOOL>

	Public: NO
*/

{
	_headlessList = (call FUNC(getList));
	if !((count _headlessList) isEqualTo 0) then {
		_x params ["_group"];
		private _headlessArray = [];
		{
			_headlessArray pushBack [(_x getVariable QGVAR(currentUnits)), _x];
		} forEach _headlessList;
		_headlessArray sort true;
		_headless = ((_headlessArray select 0) select 1);
		_headless setVariable [QGVAR(currentUnits), ((_headless getVariable QGVAR(currentUnits)) + 1), true];

		_group setGroupOwner (owner _headless);
		_group setVariable [QGVAR(Transfered), true, true];
		_group setVariable [QGVAR(pending), false, true];
		_group setVariable [QGVAR(currentOwner), _headless, true];

		[{
			params ["_group","_headless"];
			{
				if (_x getVariable [QEGVAR(Common,disableAI_Path), false]) then {
					[QEGVAR(Common,disableAICommand), _x, _headless] call CBA_fnc_targetEvent;
				};
			} forEach (units _group);
		}, [_group,_headless], 3] call CBA_fnc_waitAndExecute;

		LOG(FORMAT_2("%2 moved to %1", _headless, _group));
	} else {
		if !((count (units _group)) isEqualTo 0) then {
			LOG("Forcing Server as owner - Could not find any Headless clients");
			_group setGroupOwner 2;
			_group setVariable [QGVAR(Transfered), false, true];
		} else {
			LOG("No members in group, Transfer not completed");
		};
	};
} forEach (call FUNC(getPending));

true
