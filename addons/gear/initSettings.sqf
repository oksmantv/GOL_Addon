
[
	QGVAR(UseLocalDefault), "CHECKBOX",
	["Use Local Default.sqf", "Use the mission's local Default.sqf for player loadouts instead of the addon's authoritative version. Enable when the mission has custom player kits."],
	[QUOTE(ADDON), "#0 General"],
	false,
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(UseLocalDefaultAI), "CHECKBOX",
	["Use Local Default_AI.sqf", "Use the mission's local Default_AI.sqf for AI loadouts instead of the addon's authoritative version. Enable when the mission has custom AI kits."],
	[QUOTE(ADDON), "#0 General"],
	false,
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(UseLocalHandler), "CHECKBOX",
	["Use Local Handler", "Use the mission's local fnc_Handler.sqf instead of the addon's standard version. Enable when the mission uses CUSTOM factions or has modified box contents."],
	[QUOTE(ADDON), "#0 General"],
	false,
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

// ── Faction selections ────────────────────────────────────────────────────────

private _factionValues = [
	"AAF-SF-W","AAF-W","AFGHAN-W","AFRICAN-ARMY","AUS-TAN","BAF-D","BAF-W","BAF-W-FALK",
	"CBRN-WINTER","CDF-W","CHDKZ-SF-W","CHINA","CSAT-H","CSAT-SF-W","CSAT-U","CSAT-W",
	"CTRG-D","CTRG-W","CUSTOM-E","CUSTOM-I","CUSTOM-W","CZECH-D","CZECH-SOVIET-W","CZECH-W",
	"FINLAND-W","FRANCE-D","FRANCE-W","GERMAN-D","GERMAN-W",
	"INSURGENT-AFRICA","INSURGENT-CHDKZ","INSURGENT-FIA","INSURGENT-MALDEN","INSURGENT-ME","INSURGENT-TANOA",
	"IRAQ-SF","IRISH-UN","ISLAMICSTATE","ISRAELI","LIVONIA-W","MALDEN-W","NATO-D","NATO-W","PMC",
	"RUSSIAN-SF-W","RUSSIAN-W","RWANDA-W","SOVIET-D","SOVIET-SF-D","SOVIET-W","SWEDISH",
	"SYRIA-W","TAKISTAN-D","TAKISTAN-SF-D","TANOA-ARMY","TANOA-SF","TURKEY-D","UKRAINE-W",
	"USA-CW-W","USA-D","USA-W","USMC-D","USMC-W"
];
private _factionLabels = [
	"AAF SF Woodland","AAF Woodland","Afghan National Army Woodland","African Army Desert","Austrian Tan",
	"British Armed Forces Desert","British Armed Forces Woodland","British Falklands Woodland","CBRN Winter",
	"Chernarussian Defence Force","ChDkz SF Woodland","Chinese Armed Forces","CSAT Hex","CSAT SF Woodland",
	"CSAT Urban","CSAT Woodland","CTRG Desert","CTRG Woodland","CUSTOM-East","CUSTOM-Independent","CUSTOM-West",
	"Czech Desert","Czech Soviet Woodland","Czech Woodland","Finnish Army Woodland",
	"French Army Desert","French Army Woodland","Bundeswehr Tropentarn","Bundeswehr Flecktarn",
	"INSURGENT African","INSURGENT ChDkz","INSURGENT FIA","INSURGENT Malden","INSURGENT Middle Eastern","INSURGENT Tanoan",
	"Iraqi Special Forces","Irish United Nations","Islamic State","Israeli Defence Force","Livonia Woodland",
	"Malden Defence Force Woodland","NATO Desert","NATO Woodland","PMC",
	"Russian SF Woodland","Russian Woodland","Rwanda Defence Force Woodland",
	"Soviet Desert","Soviet SF Desert","Soviet Woodland","Swedish Army",
	"Syrian Army Woodland","Takistani Desert","Takistani SF Desert","Tanoan Army","Tanoan Special Forces",
	"Turkish Army Desert","Ukrainian Army","US Army Cold War Woodland","US Army 2000 UCP","US Army 2010 MTP",
	"USMC Marpat Desert","USMC Marpat Woodland"
];

[
	QGVAR(Blufor), "LIST",
	["Loadout Blufor", "Loadout for Blufor units"],
	QUOTE(ADDON),
	[_factionValues, _factionLabels, 0],
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(Opfor), "LIST",
	["Loadout Opfor", "Loadout for Opfor units"],
	QUOTE(ADDON),
	[_factionValues, _factionLabels, 0],
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(Independent), "LIST",
	["Loadout Independent", "Loadout for Independent units"],
	QUOTE(ADDON),
	[_factionValues, _factionLabels, 0],
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[
	QGVAR(Civilian), "LIST",
	["Loadout Civilian", "Loadout for Civilian units"],
	QUOTE(ADDON),
	[["CIVI-ALTIS","CIVI-CHERNARUS","CIVI-TAKISTAN","CIVI-AFRICA"], ["ALTIS","CHERNARUS","TAKISTAN","AFRICAN"], 0],
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

// ── Behaviour ─────────────────────────────────────────────────────────────────

[
	QGVAR(Auto_Assign), "LIST",
	["Auto assign gear", "Automatically gives gear to spawned units"],
	QUOTE(ADDON),
	[[0,1,2,3], ["Disabled","All Units","Only Copied Units","Ignore Editor Placed"], 1],
	CBA_SERVEROVERWRITE
] call CBA_settings_fnc_init;

[QGVAR(randomGear), "CHECKBOX", ["Random Role", "Should units get random gear"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;
[QGVAR(extraGear), "CHECKBOX", ["Gives units extra loadout", "Medics get more supplies, AT gets more rockets etc"], QUOTE(ADDON), false, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;
[QGVAR(autoRemoveCargo), "CHECKBOX", ["Removes cargo for vehicles", "Automatically removes cargo"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;

// ── Stamina ───────────────────────────────────────────────────────────────────

[QGVAR(Stamina), "CHECKBOX", ["Enable stamina modifier", "Apply stamina load coefficient to players"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;
[QGVAR(StaminaCoef), "SLIDER", ["Stamina coefficient", "Load coefficient applied to player stamina (0 = none, 1 = full)"], QUOTE(ADDON), [0, 1, 0.5, 2], CBA_SERVEROVERWRITE] call CBA_settings_fnc_init;
