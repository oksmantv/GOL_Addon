
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
				<br/>	Framework by: GuzzenVonLidl - Modified by Oksman for example
				<br/>	Version: "+(getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version"))+"
				<br/>
				<br/>	==============================================
				<br/>
				<br/>	Guerrillas of Liberation
				<br/>	Teamspeak: ts.gol-clan.com
				<br/>	Website: https://gol-clan.com/
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

// A dedicated server has no player-facing client state. Do not make the
// server lifecycle depend on getClientStateNumber, or serverReady can remain
// blocked forever while remote clients wait for their intro sequence.
if (isServer) then {
	[{
		LOG("Event missionLoaded (server)");
		[QGVARMAIN(missionLoaded), []] call CBA_fnc_localEvent;

		LOG("Event missionStarted (server)");
		[QGVARMAIN(missionStarted), []] call CBA_fnc_localEvent;

		LOG("Event serverReady");
		[QGVARMAIN(serverReady), []] call CBA_fnc_localEvent;
	}, [], 0.5] call CBA_fnc_waitAndExecute;
};

// Player clients need both a fully loaded mission and a real player object.
// Editor/singleplayer previews do not use the multiplayer client-state flow,
// so they retain the original !isMultiplayer readiness bypass.
// A hosted server already emitted missionLoaded/missionStarted above, so only
// remote clients emit those local lifecycle events here.
if (hasInterface) then {
	[{!isNull player && {!isMultiplayer || {getClientStateNumber >= 10}}}, {
		[{
			if (!isServer) then {
				LOG("Event missionLoaded (client)");
				[QGVARMAIN(missionLoaded), []] call CBA_fnc_localEvent;

				LOG("Event missionStarted (client)");
				[QGVARMAIN(missionStarted), []] call CBA_fnc_localEvent;
			};

			if ((getPlayerUID player) in getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "AuthorUID")) then {
				[QGVARMAIN(AddAdmin), player] call CBA_fnc_localEvent;
			};
			player setVariable [QGVARMAIN(startLocation), (getPosASL player)];
			LOG("Event playerReady");
			[QGVARMAIN(playerReady), []] call CBA_fnc_localEvent;
		}, [], 0.5] call CBA_fnc_waitAndExecute;
	}, []] call CBA_fnc_waitUntilAndExecute;
};

// Headless clients do not have an interface or a player object. Their
// lifecycle is independent from both the dedicated server and player clients.
if (CBA_isHeadlessClient) then {
	[{
		LOG("Event missionLoaded (headless)");
		[QGVARMAIN(missionLoaded), []] call CBA_fnc_localEvent;

		LOG("Event missionStarted (headless)");
		[QGVARMAIN(missionStarted), []] call CBA_fnc_localEvent;

		LOG("Event headlessReady");
		[QGVARMAIN(headlessReady), []] call CBA_fnc_localEvent;
	}, [], 0.5] call CBA_fnc_waitAndExecute;
};
