#include "script_component.hpp"

if !(ISADMIN) exitWith {
	[QGVAR(shameList), [2, player], ACTIVE_LIST] call CBA_fnc_targetEvent;
	false
};

_params = _this select 1;

_menuName = "";
_menuRsc = "popup";

if (typeName _params isEqualTo typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

private _menuDef = [];
private _protectedPlayers = allPlayers select {!(_x isKindOf "HeadlessClient_F")};
private _playerProtectionEnabled = (count _protectedPlayers > 0) && {
	(_protectedPlayers findIf {!(captive _x) || {isDamageAllowed _x}}) isEqualTo -1
};
private _cursorObject = cursorObject;
private _canHealCursorObject = !isNull _cursorObject && {
	alive _cursorObject && {
		!(_cursorObject isKindOf "HeadlessClient_F") && {
			_cursorObject isKindOf "CAManBase" || {_cursorObject isKindOf "AllVehicles"}
		}
	}
};
private _canGiveLoadout = _canHealCursorObject && {_cursorObject isKindOf "CAManBase"};
private _mobileHQ = missionNamespace getVariable ["Mobile_HQ", objNull];
private _canMoveMobileHQ = !isNull _mobileHQ && {
	alive _mobileHQ
};
private _healCaption = "Heal";
if (_canHealCursorObject) then {
	private _targetName = if (_cursorObject isKindOf "CAManBase") then {
		name _cursorObject
	} else {
		getText (configFile >> "CfgVehicles" >> typeOf _cursorObject >> "displayName")
	};
	if !(_targetName isEqualTo "") then {
		_healCaption = format ["Heal %1", _targetName];
	};
};
private _giveLoadoutCaption = "Give Loadout >";
if (_canGiveLoadout && {isPlayer _cursorObject}) then {
	_giveLoadoutCaption = format ["Give %1 Loadout >", name _cursorObject];
};
private _menus = [
	[
		["main", "Admin Menu", _menuRsc],
		[
			[
				"Actions >",
				"", "", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"actions", 1]
			],
			[
				"Debug >",
				"", "", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"debug", 1]
			],
			[
				"Player Options >",
				"", "", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"player", 1]
			],
			[
				"Spawn Menu >",
				"", "", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"spawn", 1]
			]
		]
	]
];

if (_menuName isEqualTo "actions") then {
	_menus pushBack [
		["actions","Actions Menu", _menuRsc],
		[
			[
				"Toggle Weapon Lock", {
					if (EGVAR(GameLoop,SafeMode_Enabled)) then {
						[QEGVAR(GameLoop,setSafetyMode), false] call CBA_fnc_globalEvent;
					} else {
						[QEGVAR(GameLoop,setSafetyMode), true] call CBA_fnc_globalEvent;
					};
				}, [EGVAR(GameLoop,SafeMode_Enabled)] call FUNC(getCheckBoxIcon),
				"", "", -1, true, true
			],
			[
				"Enable Player Protection", {
					{
						if !(_x isKindOf "HeadlessClient_F") then {
							[QGVAR(enablePlayerProtection), _x, _x] call CBA_fnc_targetEvent;
						};
					} forEach allPlayers;
				},
				[_playerProtectionEnabled] call FUNC(getCheckBoxIcon),
				"", "", -1, true,true
			],
			[
				_healCaption, {
					private _object = cursorObject;
					if (!isNull _object && {
						alive _object && {
							!(_object isKindOf "HeadlessClient_F") && {
								_object isKindOf "CAManBase" || {_object isKindOf "AllVehicles"}
							}
						}
					}) then {
						[QGVAR(healObject), _object, _object] call CBA_fnc_targetEvent;
					};
				},
				"\A3\ui_f\data\igui\cfg\actions\heal_ca.paa", "", "", -1, _canHealCursorObject, true
			],
			[
				"Heal All Players", {
					{
						[QGVAR(fullHeal), _x, _x] call CBA_fnc_targetEvent;
					} forEach allPlayers;
				},
				"\A3\ui_f\data\igui\cfg\actions\heal_ca.paa", "", "", -1, true,true
			],
			[
				"MHQ >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf)),"mhqlist", 1],
				-1, true,
				isClass(missionConfigFile >> "GW_Modules" >> "MHQ")
			],
			[
				"Move Mobile HQ", {
					private _mobileHQ = missionNamespace getVariable ["Mobile_HQ", objNull];
					if (!isNull _mobileHQ && {alive _mobileHQ}) then {
						[_mobileHQ, player, 5] call GW_Menu_fnc_MoveVehicle;
					};
				},
				"\A3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa", "", "", -1, _canMoveMobileHQ, true
			],
			[
				"Select Loadouts >",
				"", "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"loadouts", 1],
				-1, true, true
			],
			[
				_giveLoadoutCaption,
				"", "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts", 1],
				-1, _canGiveLoadout, true
			]
		]
	];
};

if (_menuName isEqualTo "debug") then {
	_menus pushBack [
		["debug","Debug Menu", _menuRsc],
		[
			["Simple Camera",{ [] call BIS_fnc_cameraOld; }],
			["Advanced Camera",{ [] call bis_fnc_camera; }],
			["Spectator Mode",{
				if ((["IsSpectating"] call BIS_fnc_EGSpectator)) then {
					(["Terminate"] call BIS_fnc_EGSpectator);
				} else {
					(["Initialize", [player, [], true]] call BIS_fnc_EGSpectator);
				};
			}],
			[
				"Server Monitor",
				{[] call EFUNC(MonitorServer,Toggle)},
				[EGVAR(MonitorServer,doRecive)] call FUNC(getCheckBoxIcon)
			],
			[
				"Map Monitor",
				{[] call EFUNC(MonitorMap,Handler)},
				[EGVAR(MonitorMap,Enabled)] call FUNC(getCheckBoxIcon)
			]
		]
	];
};

if (_menuName isEqualTo "player") then {
	_menus pushBack [
		["player","Player Menu", _menuRsc],
		[
			[
				"isActiveAdmin", {
					if (GVARMAIN(isActiveAdmin)) then {
						[QGVARMAIN(RemoveActiveAdmin), player] call CBA_fnc_localEvent;
					} else {
						[QGVARMAIN(AddActiveAdmin), player] call CBA_fnc_localEvent;
					};
				},
				[GVARMAIN(isActiveAdmin)] call FUNC(getCheckBoxIcon),
				"", "", -1, true, true
			],
			[
				"Toggle Godmode", {
					if (isDamageAllowed player) then {
						player allowDamage false; player setVariable ["ACE_Medical_allowDamage", false];
					} else {
						player allowDamage true; player setVariable ["ACE_Medical_allowDamage", true];
					};
				},
				[!(isDamageAllowed player)] call FUNC(getCheckBoxIcon),
				"", "", -1, (true), true
			],
			[
				"Toggle SetCaptive", {
					if (captive player) then {
						player setCaptive false;
					} else {
						player setCaptive true;
					};
				},
				[(captive player)] call FUNC(getCheckBoxIcon),
				"", "", -1, true, true
			],
			[
				"Create personal Zeus",
				{[QGVAR(createZeus), player] call CBA_fnc_serverEvent;},
				[false] call FUNC(getCheckBoxIcon),
				"", "", -1, true,
				isNull (getAssignedCuratorLogic player)
			],
			[
				"Remove Zeus",
				{[QGVAR(removeZeus), player] call CBA_fnc_serverEvent;},
				[true] call FUNC(getCheckBoxIcon),
				"", "", -1, (!(serverCommandAvailable "#kick") && (isMultiplayer)),
				!(isNull (getAssignedCuratorLogic player))
			],
			["Open ACE Arsenal", {[player, player, true] call ace_arsenal_fnc_openBox}]
		]
	];
};

if (_menuName isEqualTo "spawn") then {
	_menus pushBack [
		["spawn","Spawn Menu", _menuRsc],
		[
			["Gear Box",{[QGVAR(spawnBox), ["GOL_GearBox_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa"],
			["Support Box",{[QGVAR(spawnBox), ["GOL_SupportBox_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\Map\VehicleIcons\iconCrateAmmo_ca.paa"],
			["Team Resupply Box",{[QGVAR(spawnBox), ["GOL_TeamResupplybox_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\reload_ca.paa"],
			["Specialist Resupply Box",{[QGVAR(spawnBox), ["GOL_SpecialistResupplybox_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\reload_ca.paa"],
			["Squad Resupply Box",{[QGVAR(spawnBox), ["GOL_SquadResupplybox_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\reload_ca.paa"],
			["Medical Box",{[QGVAR(spawnBox), ["GOL_MedicalResupply_", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa"],
			["Service Station",{[QGVAR(spawnBox), ["GOL_MobileServiceStation", player]] call CBA_fnc_serverEvent;}, "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa"]
		]
	];
};

if (_menuName isEqualTo "loadouts") then {
		_menus pushBack [
			["loadouts","Loadouts", _menuRsc],
			[
				["Command &amp; Coordination >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_command", 1], -1, true, true],
				["Squad Roles >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_squad", 1], -1, true, true],
				["Heavy Weapons >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_heavy", 1], -1, true, true],
				["Specialists >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_specialists", 1], -1, true, true],
				["Aviation >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_aviation", 1], -1, true, true]
			]
		];
};

if (_menuName isEqualTo "loadouts_command") then {
		_menus pushBack [
			["loadouts_command","Loadouts - Command & Coordination", _menuRsc],
			[
				["<t color='#ffb400'>Officer</t>",{[player,'officer'] call GW_Gear_Fnc_Handler;}],
				["<t color='#ffb400'>Actual</t>",{[player,'pl'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ffb400'>Platoon Medic</t>",{[player,'pm'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ffb400'>Forward Air Controller</t>",{[player,'fac'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

if (_menuName isEqualTo "loadouts_squad") then {
		_menus pushBack [
			["loadouts_squad","Loadouts - Squad Roles", _menuRsc],
			[
				["<t color='#2eff2e'>Squad Leader</t>",{[player,'sl'] call GW_Gear_Fnc_Handler; }],
				["<t color='#2eff2e'>Squad Medic</t>",{[player,'sm'] call GW_Gear_Fnc_Handler; }],
				["<t color='#2eff2e'>Fire Team Leader</t>",{[player,'ftl'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ff3737'>Rifleman</t>",{[player,'r'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ff3737'>Grenadier</t>",{[player,'g'] call GW_Gear_Fnc_Handler; }],
				["<t color='#6a9fff'>Asst. Gunner</t>",{[player,'ag'] call GW_Gear_Fnc_Handler; }],
				["<t color='#6a9fff'>Automatic Rifleman</t>",{[player,'ar'] call GW_Gear_Fnc_Handler; }],
				["<t color='#6a9fff'>AR Ammo Bearer</t>",{[player,'ab'] call GW_Gear_Fnc_Handler; }],
				["<t color='#6a9fff'>AT Ammo Bearer</t>",{[player,'atab'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

if (_menuName isEqualTo "loadouts_heavy") then {
		_menus pushBack [
			["loadouts_heavy","Loadouts - Heavy Weapons", _menuRsc],
			[
				["<t color='#FDF916'>Mortar Operator</t>",{[player,'lightdragon'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Asst. Medium Machine Gunner</t>",{[player,'ammg'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Medium Machine Gunner</t>",{[player,'mmg'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Dragon</t>",{[player,'dragon'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Anti-Air</t>",{[player,'aa'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Asst. Heavy AT</t>",{[player,'amat'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Heavy AT</t>",{[player,'mat'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

if (_menuName isEqualTo "loadouts_specialists") then {
		_menus pushBack [
			["loadouts_specialists","Loadouts - Specialists", _menuRsc],
			[
				["<t color='#c77dff'>Drone Operator</t>",{[player,'drone'] call GW_Gear_Fnc_Handler; }],
				["<t color='#c77dff'>Engineer</t>",{[player,'engineer'] call GW_Gear_Fnc_Handler; }],
				["<t color='#c77dff'>Light Rifleman</t>",{[player,'lr'] call GW_Gear_Fnc_Handler; }],
				["<t color='#c77dff'>Marksman</t>",{[player,'marksman'] call GW_Gear_Fnc_Handler; }],
				["<t color='#c77dff'>Vehicle Crew</t>",{[player,'crew'] call GW_Gear_Fnc_Handler; }],
				["<t color='#c77dff'>Combat Diver</t>",{[player,'diver'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

if (_menuName isEqualTo "loadouts_aviation") then {
		_menus pushBack [
			["loadouts_aviation","Loadouts - Aviation", _menuRsc],
			[
				["<t color='#22B9FF'>Chopper Pilot</t>",{[player,'p'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Para-Rescueman</t>",{[player,'pj'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Jet Pilot</t>",{[player,'jetp'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

if (_menuName isEqualTo "target_loadouts") then {
	_menus pushBack [["target_loadouts","Give Loadout", _menuRsc], [
		["Command &amp; Coordination >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts_command", 1], -1, true, true],
		["Squad Roles >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts_squad", 1], -1, true, true],
		["Heavy Weapons >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts_heavy", 1], -1, true, true],
		["Specialists >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts_specialists", 1], -1, true, true],
		["Aviation >", "", "", "", [QUOTE(call FUNC(flexi_InteractSelf)),"target_loadouts_aviation", 1], -1, true, true]
	]];
};

if ((_menuName find "target_loadouts_") isEqualTo 0) then {
	private _targetLoadoutRoles = switch (_menuName) do {
		case "target_loadouts_command": {[["<t color='#ffb400'>Officer</t>", "officer"], ["<t color='#ffb400'>Actual</t>", "pl"], ["<t color='#ffb400'>Platoon Medic</t>", "pm"], ["<t color='#ffb400'>Forward Air Controller</t>", "fac"]]};
		case "target_loadouts_squad": {[["<t color='#2eff2e'>Squad Leader</t>", "sl"], ["<t color='#2eff2e'>Squad Medic</t>", "sm"], ["<t color='#2eff2e'>Fire Team Leader</t>", "ftl"], ["<t color='#ff3737'>Rifleman</t>", "r"], ["<t color='#ff3737'>Grenadier</t>", "g"], ["<t color='#6a9fff'>Asst. Gunner</t>", "ag"], ["<t color='#6a9fff'>Automatic Rifleman</t>", "ar"], ["<t color='#6a9fff'>AR Ammo Bearer</t>", "ab"], ["<t color='#6a9fff'>AT Ammo Bearer</t>", "atab"]]};
		case "target_loadouts_heavy": {[["<t color='#FDF916'>Mortar Operator</t>", "lightdragon"], ["<t color='#FDF916'>Asst. Medium Machine Gunner</t>", "ammg"], ["<t color='#FDF916'>Medium Machine Gunner</t>", "mmg"], ["<t color='#FDF916'>Dragon</t>", "dragon"], ["<t color='#FDF916'>Anti-Air</t>", "aa"], ["<t color='#FDF916'>Asst. Heavy AT</t>", "amat"], ["<t color='#FDF916'>Heavy AT</t>", "mat"]]};
		case "target_loadouts_specialists": {[["<t color='#c77dff'>Drone Operator</t>", "drone"], ["<t color='#c77dff'>Engineer</t>", "engineer"], ["<t color='#c77dff'>Light Rifleman</t>", "lr"], ["<t color='#c77dff'>Marksman</t>", "marksman"], ["<t color='#c77dff'>Vehicle Crew</t>", "crew"], ["<t color='#c77dff'>Combat Diver</t>", "diver"]]};
		case "target_loadouts_aviation": {[["<t color='#22B9FF'>Chopper Pilot</t>", "p"], ["<t color='#22B9FF'>Para-Rescueman</t>", "pj"], ["<t color='#22B9FF'>Jet Pilot</t>", "jetp"]]};
		default {[]};
	};
	private _targetLoadoutMenu = [];
	{
		_x params ["_name", "_role"];
		_targetLoadoutMenu pushBack [_name, compile format ["private _unit = cursorObject; if (!isNull _unit && {alive _unit} && {_unit isKindOf 'CAManBase'} && {!(_unit isKindOf 'HeadlessClient_F')}) then {['%2', [_unit, '%1'], _unit] call CBA_fnc_targetEvent;};", _role, QGVAR(giveLoadout)]];
	} forEach _targetLoadoutRoles;
	_menus pushBack [[_menuName, "Give Loadout", _menuRsc], _targetLoadoutMenu];
};

{
	if (((_x select 0) select 0) isEqualTo _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if ((count _menuDef) isEqualTo 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName isEqualTo "") then {_this}else{""},__FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};
_menuDef
