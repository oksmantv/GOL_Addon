
[
	QEGVAR(settings_ACE,medical_level), "LIST",
	["Medical Level", "Configures ACE Medical with GOL settings"],
	["GW_Common", "#1 ACE"],
	[
		[
			1,
			2
		],
		[
			"Basic",
			"Advanced"
		],
		0
	], CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call CBA_settings_fnc_init;

[
	QGVAR(unconscious), "LIST",
	["Ragdoll", "Upon unconscious unit goes ragdoll"],
	["GW_Common", "#1 ACE"],
	[[0,1,2], ["Disabled","Enabled","Only players"], 0], CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

/*
// Wait for new medical
[
	QEGVAR(settings_ACE,revive), "LIST",
	["Enable Revive", "Configures ACE Revive with GOL settings"],
	QUOTE(ADDON),
	[
		[
			0,
			1,
			2
		],
		[
			"Disabled",
			"Enabled",
			"Enabled (One Life)"
		],
		0
	], CBA_SERVEROVERWRITE, {}, CBA_NEEDRESTART
] call CBA_settings_fnc_init;
*/
