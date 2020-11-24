
[QGVAR(Simulation), "CHECKBOX", ["Disable spawnLag (Experimental)", "Stops simulation for spawned group for up to 5 sec, and then activates them to reduce lag spikes. NOTE: May cause visual glitches up to 7 sec after spawned"], QUOTE(ADDON), false, CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART] call CBA_settings_fnc_init;
[QGVAR(UnitEnabled), "CHECKBOX", ["Gear removal", "Remove all equipment from dead unit execpt for uniform, Note: This ignores dead players"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART] call CBA_settings_fnc_init;
//	[QGVAR(alwaysVehicles), "CHECKBOX", ["Always Render Aircrafts", "Always render aircrafts that are in object viewdistance, this will make it harder for vehicles to 'pop', only applies to vehicles with crew"], QUOTE(ADDON), false, CBA_CANOVERWRITE] call CBA_settings_fnc_init;


[QGVAR(Cleanup), "CHECKBOX", ["Enable Clean up", "Custom made Garbage Collector, for performance and immersion"], [QUOTE(ADDON), "Garbage Collector"], true, CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART] call CBA_settings_fnc_init;
[QGVAR(autoDelete), "CHECKBOX", ["Auto Delete Forgotten Units", "Automaticly deletes units and objects located at [0,0,0] after 10 seconds if not moved"], [QUOTE(ADDON), "Garbage Collector"], true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;
[QGVAR(deleteBuilding), "CHECKBOX", ["Delete items upon building destroyed", "on building destroyed, delete all objects inside of a building and kill units"], [QUOTE(ADDON), "Garbage Collector"], true, CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART] call CBA_settings_fnc_init;


[
	QGVAR(disableWakeUp), "LIST",
	["Disable Wake-Up for AI", "Disables AI being able to wake other AI while using BI's Dynamic Simulation"],
	[QUOTE(ADDON), "Dynamic Simulation"],
	[
		[0,1,2],
		["Disabled","All Units","Only Copied Units"],
		0
	], CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(autoCaching), "LIST",
	["Auto Caching", "Automaticly adds units to BI's Dynamic Simulation"],
	[QUOTE(ADDON), "Dynamic Simulation"],
	[
		[0,1,2,3],
		["Disabled","All Units","Only Copied Units","Only Static Units"],
		3
	], CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(autoHide), "LIST",
	["Hide upon Caching (Experimental)", "Automaticly hide objects once they are cached, and makes them visible once a player has activated them, this is to increase fps even further"],
	[QUOTE(ADDON), "Dynamic Simulation"],
	[
		[0,1],
		["Disabled","Only Units"],
		0
	], CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;
