
[{
	LOG("Event mapLoaded");
	[QGVARMAIN(mapLoaded), []] call CBA_fnc_localEvent;

	if (hasInterface) then {
		GVARMAIN(logModules) sort false;
		player createDiarySubject ["framework_diary","Modules Loaded"];
		{
			player createDiaryRecord ["framework_diary", [FORMAT_1("%1", (_x select 0)),
				FORMAT_3("Version: %2  by %1, <br/>Description: %3", (_x select 1), (_x select 2), (_x select 3))
			]];
		} forEach GVARMAIN(logModules);

		[{
			player createDiaryRecord ["framework_diary", ["Framework",
				"==============================================
				<br/>
				<br/>	Mission: "+(getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Name"))+"
				<br/>	By: "+(getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Author"))+"
				<br/>	Version: "+str(getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "version"))+"
				<br/>	File name: "+(missionName)+"
				<br/>
				<br/>	==============================================
				<br/>
				<br/>	Framework by: GuzzenVonLidl
				<br/>	Version: "+(getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version"))+"
				<br/>
				<br/>	==============================================
				<br/>
				<br/>	Guerrillas of Liberation
				<br/>	Teamspeak: teamspeak.gol-clan.co.uk
				<br/>	Website: http://www.gol-clan.co.uk/
				<br/>	=============================================="
			]];
		}, []] call CBA_Fnc_execNextFrame;
	};
	if (isServer) then {
		[{
			LOG("Event settingsInitializedDelayed");
			["CBA_settingsInitializedDelayed", []] call CBA_fnc_localEvent;	// GW-Framework...
		}, [], 0.1] call CBA_fnc_waitAndExecute;
	};
}, []] call CBA_Fnc_execNextFrame;

[{(getClientStateNumber >= 10) || !isMultiplayer}, {
	[{
		LOG("Event missionStarted");
		[QGVARMAIN(missionStarted), []] call CBA_fnc_localEvent;

		if (isServer) then {
			LOG("Event serverReady");
			[QGVARMAIN(serverReady), []] call CBA_fnc_localEvent;

/*
			if !(dynamicSimulationSystemEnabled) then {
				enableDynamicSimulationSystem true;

				"Group" setDynamicSimulationDistance 350;
				"Vehicle" setDynamicSimulationDistance 500;
				"Prop" setDynamicSimulationDistance 50;
				"EmptyVehicle" setDynamicSimulationDistance 100;
				"IsMoving" setDynamicSimulationDistanceCoef 3;
			};
*/
		};

		if (hasInterface) then {
			if ((getPlayerUID player) in getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "AuthorUID")) then {
				[QGVARMAIN(AddAdmin), player] call CBA_fnc_localEvent;
			};
			player setVariable [QGVARMAIN(startLocation), (getPosASL player)];
			LOG("Event playerReady");
			[QGVARMAIN(playerReady), []] call CBA_fnc_localEvent;
		};

		if (CBA_isHeadlessClient) then {
			LOG("Event headlessReady");
			[QGVARMAIN(headlessReady), []] call CBA_fnc_localEvent;
		};
	}, [], 0.5] call CBA_fnc_waitAndExecute;
}, []] call CBA_fnc_waitUntilAndExecute;
