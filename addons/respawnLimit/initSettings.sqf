
[
	QGVAR(Mode), "LIST",
	["Respawn Type", "How respawns are handeled"],
	[QUOTE(ADDON), "General"],
	[[0,1,2], ["Normal (No limits)", "Player Tickets", "Team Tickets"], 0],
	CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);

[
	QGVAR(JIP), "LIST",
	["Join in progress", "Allow JIP to play or force in to spectator until given a life"],
	[QUOTE(ADDON), "General"],
	[[true,false], ["enabled","disabled"], 0],
	CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);

[
	QGVAR(Count), "LIST",
	["Player Respawns", "Amount of respawns each player gets"],
	[QUOTE(ADDON), "Individual Mode"],
	[[0,2,3,4,5,6,7,8], ["No Respawns","1","2","3","4","5","6","7"], 0],
	 CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);

[
	QGVAR(CountTeamWest), "LIST",
	["Team Respawns West", "Total amount of respawns allowed per side"],
	[QUOTE(ADDON), "Team Mode"],
	[[0,5,10,20,30,40,50,60,70,80,90,100], ["No Respawns","5","10","20","30","40","50","60","70","80","90","100"], 0],
	CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);

[
	QGVAR(CountTeamEast), "LIST",
	["Team Respawns East", "Total amount of respawns allowed per side"],
	[QUOTE(ADDON), "Team Mode"],
	[[0,5,10,20,30,40,50,60,70,80,90,100], ["No Respawns","5","10","20","30","40","50","60","70","80","90","100"], 0],
	CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);

[
	QGVAR(CountTeamIndependent), "LIST",
	["Team Respawns Independent", "Total amount of respawns allowed per side"],
	[QUOTE(ADDON), "Team Mode"],
	[[0,5,10,20,30,40,50,60,70,80,90,100], ["No Respawns","5","10","20","30","40","50","60","70","80","90","100"], 0],
	CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call FUNCMAIN(settingsInit);
