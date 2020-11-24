#include "script_Component.hpp"

if (isClass(missionConfigFile >> "GW_Modules" >> "HeadlessController")) exitWith {false};
if !(GVAR(Enable)) exitWith {false};

[QGVARMAIN(playerReady), {
	[(group player), true] call FUNC(BlackList);
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(headlessReady), {
	[(group player), true] call FUNC(BlackList);
	[{
		[QGVAR(addHC), player] call CBA_fnc_serverEvent;
		[QGVAR(adjustViewDistance), []] call CBA_fnc_localEvent;
	}, [], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(serverReady), {
	[QGVAR(adjustViewDistance), []] call CBA_fnc_localEvent;

	["CAManBase", "init", {
		[{
			params ["_unit"];
			private _group = (_unit call CBA_fnc_getGroup);

			if ((_group getVariable [QGVAR(BlackList), false]) || !(({isPlayer _x} count (units _group)) isEqualTo 0)) exitWith {
				LOG(FORMAT_1("Group: %1 is blacklisted", _group));
				false
			};

			_group setVariable [QGVAR(pending), true, true];
		}, _this, 15] call CBA_fnc_waitAndExecute;
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	["CAManBase", "Local", {
		params ["_unit", "_isLocal"];
		if (_unit getVariable [QEGVAR(Common,disableAI_Path), false]) then {
			[QEGVAR(Common,disableAICommand), _unit] call CBA_fnc_localEvent;
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	[{	// Add delay before first event
		GVAR(PFH) = [{
			if !((count (call FUNC(getPending))) isEqualTo 0) then {
				[] call FUNC(HandlePFH);
			};
		}, 30, []] call CBA_fnc_addPerFrameHandler;
	}, [], 15] call CBA_fnc_waitAndExecute;

	addMissionEventHandler ["HandleDisconnect", {
		params ["_unit","_id","_uid","_name"];
		if !(_unit isKindOf "HeadlessClient_F") exitWith {false};

		LOG(FORMAT_1("Headless Client: %1 Disconnected", _unit));
		LOG(FORMAT_1("There are %1 Headless left in the mission", count (call FUNC(getList))));
		if !((count (call FUNC(getList))) isEqualTo 0) then {
			[QGVAR(updateBalance), true] call CBA_fnc_serverEvent;
		} else {
			{
				_x setVariable [QGVAR(Transfered), false];
			} forEach allGroups;
		};
	}];
}] call CBA_fnc_addEventHandler;

[QGVAR(addHC), {
	params ["_headless"];
	LOG(FORMAT_1("Headless Client: %1 Connected", _headless));
	_headless setVariable [QGVAR(currentUnits), 0, true];

	if (didJIPOwner _headless) then {
		if !((count (call FUNC(getList))) isEqualTo 0) then {
			[QGVAR(updateBalance), true] call CBA_fnc_serverEvent;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(adjustViewDistance), {
	if ((count (call FUNC(getList))) > 0) then {
		if (isServer) then {
			setViewDistance 1000;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
		if (CBA_isHeadlessClient) then {
			setViewDistance 2500;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
	} else {
		if (isServer) then {
			setViewDistance 2500;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(updateBalance), {
	params ["_rebalance"];
	if (_rebalance) then {
		LOG("Forcing a rebalance on all groups");

		{
			_x setVariable [QGVAR(pending), true, false];
			_x setVariable [QGVAR(Transfered), false, false];
		} forEach (call FUNC(getTransfered));

		{
			_x setVariable [QGVAR(currentUnits), 0, true];
		} forEach (call FUNC(getList));
	} else {
		{
			(_x select 1) setVariable [QGVAR(currentUnits), (_x select 0), true];
			TRACE_2("Headless Stats", (_x select 0), (_x select 1));
		} forEach (call FUNC(countBalance));
	};
}] call CBA_fnc_addEventHandler;
