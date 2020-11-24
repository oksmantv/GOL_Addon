// #define DEBUG_MODE_FULL
#include "script_component.hpp"

if (isClass(missionConfigFile >> "GW_Modules" >> "Performance")) exitWith {false};

GVAR(ignoreDead) = allDead;

[QGVARMAIN(serverReady), {
	["CAManBase", "init", {
		params ["_unit"];

		if (isPlayer _unit) exitWith {false};

		if (GVAR(Simulation)) then {
			_unit call FUNC(Simulation);
		};

		if (dynamicSimulationSystemEnabled) then {
			_trigger = false;
			switch (GVAR(disableWakeUp)) do {
				case 1: {
					_trigger = true;
				};
				case 2: {
					if (_unit getVariable [QEGVAR(Common,isSpawned), false]) then {
						_trigger = true;
					};
				};
			};

			if (_trigger) then {
				_unit triggerDynamicSimulation false;		//	(canTriggerDynamicSimulation cursorObject)
			};

			if ((leader (group _unit)) == (leader _unit)) then {
				_simulate = false;
				switch (GVAR(autoCaching)) do {
					case 1: {
						_simulate = true;
					};
					case 2: {
						if (_unit getVariable [QEGVAR(Common,isSpawned), false]) then {
							_simulate = true;
						};
					};
					case 3: {
						if (_unit getVariable [QEGVAR(Common,disableAI_Path), false]) then {
							_simulate = true;
						};
					};
				};
				if (_simulate) then {
					(group _unit) enableDynamicSimulation true;		// (dynamicSimulationEnabled (group cursorObject))
				};
			};
		};

		if (GVAR(autoDelete)) then {
			[{
				params ["_unit"];
				if ((_unit distance2d [0,0,0]) < 20) then {
					deleteVehicle _unit;
				};
			},	_this, 30] call CBA_fnc_waitAndExecute;
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	["AllVehicles", "KILLED", {
		params ["_unit"];
		if (_unit isKindOf "CAManBase") then {
			_unit call FUNC(HandlerKilled);
		} else {
			[{
				params ["_veh"];
				{_veh deleteVehicleCrew _x} forEach (crew _veh);
			},	_this, 10] call CBA_fnc_waitAndExecute;
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	if (GVAR(Cleanup)) then {
		GVAR(CleanUp_PFH) = [{
			if (count (allDeadMen select {!(_x getVariable ["GW_isPlayer", false])}) > 50) then {
				deleteVehicle (allDeadMen select random count allDeadMen);
			};

			{
				if ((_object getVariable [QGVAR(ObjectRemovalTimer), 20]) < 9) then {
					if ((count ((_x nearEntities ["Man", 25]) select {isPlayer _x})) > 0) then {
						if !(simulationEnabled _x) then {
							_x enableSimulationGlobal true;
						};
					} else {
						if (simulationEnabled _x) then {
							_x enableSimulationGlobal false;
						};
					};
					if ((_object getVariable [QGVAR(ObjectRemovalTimer), 20]) < 5) then {
						if ((count ((_x nearEntities ["Man", 150]) select {isPlayer _x})) > 0) then {
							if (isObjectHidden _x) then {
								_x hideObjectGlobal false;
							};
						} else {
							if !(isObjectHidden _x) then {
								_x hideObjectGlobal true;
							};
						};
					};
				};
			} forEach allDeadMen;

			if ((time mod 60) <= 10) then {	// Only execture once every minute
				[] call FUNC(HandlerCleanUp);
			};
		}, 10, []] call CBA_fnc_addPerFrameHandler;
	};

	if (GVAR(deleteBuilding)) then {
		addMissionEventHandler ["BuildingChanged", {
			params ["_previousObject", "_newObject", "_isRuin"];
			if (_isRuin) then {
				private _pos = (getPos _previousObject);
				private _radius = (sizeOf (typeOf _previousObject));
				private _closeObjects = (nearestObjects [_pos, ["NonStrategic","Strategic","Thing"], _radius]);

				(boundingBoxReal _previousObject) params ["_p1","_p2"];
				_x = abs ((_p2 select 0) - (_p1 select 0));
				_y = abs ((_p2 select 1) - (_p1 select 1));
				_z = abs ((_p2 select 2) - (_p1 select 2));
				_objectsInBuilding = (_closeObjects inAreaArray [_pos, _x, _y, (getdir _previousObject), true, _z]);

				_objectsInBuilding deleteAt (_objectsInBuilding find _newObject);

				{
					if (!isPlayer _x) then {
						_x setDamage [1, false];
					};
				} forEach (_pos nearEntities ["Man", _radius]);

				{
					if ((isDamageAllowed _x) && !(isObjectHidden _x) && ((vehicleVarName _x) isEqualTo "") && ((actionIDs _x) isEqualTo [])) then {
						deleteVehicle _x;
					};
				} forEach _objectsInBuilding;
			};
		}];
	};

	[{
		if (dynamicSimulationSystemEnabled && (GVAR(autoHide) > 0)) then {
			[{
				_list = (allGroups select {(dynamicSimulationEnabled _x)});
				_list deleteRange [(count _list) / 2, (count _list)];

				[QGVAR(updateCached), ((allGroups select {(dynamicSimulationEnabled _x)}) - _list)] call CBA_fnc_localEvent;
				[{
					[QGVAR(updateCached), _this] call CBA_fnc_localEvent;
				}, _list, 0.5] call CBA_fnc_waitAndExecute;

				[{
					{
						_grp = _x;
						if (_grp getVariable ["GW_isCached", false]) then {
							if !(isObjectHidden (leader _grp)) then {
								{
									_x hideObjectGlobal true;
								} forEach (units _grp);
							};
						} else {
							if (isObjectHidden (leader _grp)) then {
								{
									_x hideObjectGlobal false;
								} forEach (units _grp);
							};
						};
					} forEach allGroups;
				}, [], 1] call CBA_fnc_waitAndExecute;
			}, 5, []] call CBA_fnc_addPerFrameHandler;
		};
	}, [], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(removeGroup), {
	if (_this getVariable [QGVAR(autoDelete), true]) then {
		deleteGroup _this;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(updateCached), {
	{
		_unit = (leader _x);
		_eye = (eyeDirection _unit);
		_weapon = (_unit weaponDirection (currentWeapon _unit));
		_pos = (_unit getVariable ["GW_TestPos", [[0,0,0], [0,0,0]]]);
		if ((_eye isEqualTo (_pos select 0)) && (_weapon isEqualTo (_pos select 1))) then {
			(_x setVariable ["GW_isCached", true]);
			true
		} else {
			(_x setVariable ["GW_isCached", false]);
			(_unit setVariable ["GW_TestPos", [_eye, _weapon]]);
			false
		};
	} forEach _this;
}] call CBA_fnc_addEventHandler;
