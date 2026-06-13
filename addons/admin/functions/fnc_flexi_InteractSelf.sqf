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
				"Modules >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf)),"modules", 1],
				-1, true,true
			],
			[
				"MHQ >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf)),"mhqlist", 1],
				-1, true,
				isClass(missionConfigFile >> "GW_Modules" >> "MHQ")
			]
		]
	];
};

if (_menuName isEqualTo "mhqlist") then {
	private _mhqMenu = [];
	{
		if (!isNil{(_x getVariable QEGVAR(MHQ,Info))}) then {
			if (_x getVariable QEGVAR(MHQ,Active)) then {
				_mhqMenu pushBack [(format ["Deactivate %1", _x]), (compile format ["['GW_MHQ_Enabled', [%1, false, str([player] call GW_Common_fnc_getSide)]] call CBA_fnc_serverEvent", _x])];
			} else {
				_mhqMenu pushBack [(format ["Move %1", _x]), (compile format ["[%1, player, 5] call GW_Menu_fnc_MoveVehicle;", _x])];
				_mhqMenu pushBack [(format ["Activate %1", _x]), (compile format ["['GW_MHQ_Enabled', [%1, true, str([player] call GW_Common_fnc_getSide)]] call CBA_fnc_serverEvent", _x])];
			};
		};
	} forEach (vehicles select {alive _x});
	_menus pushBack [["mhqlist", "MHQ List", _menuRsc],_mhqMenu];
};
if (_menuName isEqualTo "modules") then {
	_menus pushBack [
		["modules","Modules Menu", _menuRsc],
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
				"Heal All Players", {
					{
						[QGVAR(fullHeal), _x, _x] call CBA_fnc_targetEvent;
					} forEach allPlayers;
				},
				"","", "", -1, true,true
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
			[
				"Loadouts - Squad >",
				"", "", "",
				[QUOTE(call FUNC(flexi_InteractSelf)),"loadouts", 1]
			],
			["Gear Box",{[QGVAR(spawnBox), ["GOL_GearBox_", player]] call CBA_fnc_serverEvent;}],
			["Support Box",{[QGVAR(spawnBox), ["GOL_SupportBox_", player]] call CBA_fnc_serverEvent;}],	
			["Ammo Box - Team",{[QGVAR(spawnBox), ["GOL_TeamResupplybox_", player]] call CBA_fnc_serverEvent;}],
			["Ammo Box - Heavy Team",{[QGVAR(spawnBox), ["GOL_SpecialistResupplybox_", player]] call CBA_fnc_serverEvent;}],
			["Ammo Box - Squad",{[QGVAR(spawnBox), ["GOL_SquadResupplybox_", player]] call CBA_fnc_serverEvent;}],
			["Medical Box",{[QGVAR(spawnBox), ["GOL_MedicalResupply_", player]] call CBA_fnc_serverEvent;}],
			["Service Station",{[QGVAR(spawnBox), ["GOL_MobileServiceStation", player]] call CBA_fnc_serverEvent;}]
		]
	];
};

if (_menuName isEqualTo "loadouts") then {
		_menus pushBack [
			["loadouts","Loadouts", _menuRsc],
			[
				[
					"Infantry >",
					"", "", "",
					[QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_infantry", 1]
				],
				[
					"Support >",
					"", "", "",
					[QUOTE(call FUNC(flexi_InteractSelf)),"loadouts_support", 1]
				]
			]
		];
};

if (_menuName isEqualTo "loadouts_infantry") then {
		_menus pushBack [
			["loadouts_infantry","Loadouts - Infantry", _menuRsc],
			[
				["<t color='#ffb400'>Actual</t>",{[player,'pl'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ffb400'>Platoon Medic</t>",{[player,'pm'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ffb400'>Forward Air Controller</t>",{[player,'fac'] call GW_Gear_Fnc_Handler; }],
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

if (_menuName isEqualTo "loadouts_support") then {
		_menus pushBack [
			["loadouts_support","Loadouts - Support", _menuRsc],
			[
				["<t color='#ffb400'>Drone Operator</t>",{[player,'drone'] call GW_Gear_Fnc_Handler; }],
				["<t color='#ffb400'>Mortar Operator</t>",{[player,'lightdragon'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Vehicle Crew</t>",{[player,'crew'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Asst. Medium Machine Gunner</t>",{[player,'ammg'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Medium Machine Gunner</t>",{[player,'mmg'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Dragon</t>",{[player,'dragon'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Engineer</t>",{[player,'engineer'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Light Rifleman</t>",{[player,'lr'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Anti-Air</t>",{[player,'aa'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Asst. Heavy AT</t>",{[player,'amat'] call GW_Gear_Fnc_Handler; }],
				["<t color='#FDF916'>Heavy AT</t>",{[player,'mat'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Chopper Pilot</t>",{[player,'p'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Para-Rescueman</t>",{[player,'pj'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Jet Pilot</t>",{[player,'jetp'] call GW_Gear_Fnc_Handler; }],
				["<t color='#22B9FF'>Marksman</t>",{[player,'marksman'] call GW_Gear_Fnc_Handler; }]
			]
		];
};

{
	if (((_x select 0) select 0) isEqualTo _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if ((count _menuDef) isEqualTo 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName isEqualTo "") then {_this}else{""},__FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};
_menuDef
