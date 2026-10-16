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
private _loadoutRoles = [
	["<t color='#ffb400'>Officer</t>", "officer"],
	["<t color='#ffb400'>Actual</t>", "pl"],
	["<t color='#ffb400'>Platoon Medic</t>", "pm"],
	["<t color='#ffb400'>Forward Air Controller</t>", "fac"],
	["<t color='#2eff2e'>Squad Leader</t>", "sl"],
	["<t color='#2eff2e'>Squad Medic</t>", "sm"],
	["<t color='#2eff2e'>Fire Team Leader</t>", "ftl"],
	["<t color='#ff3737'>Rifleman</t>", "r"],
	["<t color='#ff3737'>Grenadier</t>", "g"],
	["<t color='#6a9fff'>Asst. Gunner</t>", "ag"],
	["<t color='#6a9fff'>Automatic Rifleman</t>", "ar"],
	["<t color='#6a9fff'>AR Ammo Bearer</t>", "ab"],
	["<t color='#6a9fff'>AT Ammo Bearer</t>", "atab"],
	["<t color='#FDF916'>Mortar Operator</t>", "lightdragon"],
	["<t color='#FDF916'>Asst. Medium Machine Gunner</t>", "ammg"],
	["<t color='#FDF916'>Medium Machine Gunner</t>", "mmg"],
	["<t color='#FDF916'>Dragon</t>", "dragon"],
	["<t color='#FDF916'>Anti-Air</t>", "aa"],
	["<t color='#FDF916'>Asst. Heavy AT</t>", "amat"],
	["<t color='#FDF916'>Heavy AT</t>", "mat"],
	["<t color='#c77dff'>Drone Operator</t>", "drone"],
	["<t color='#c77dff'>Engineer</t>", "engineer"],
	["<t color='#c77dff'>Light Rifleman</t>", "lr"],
	["<t color='#c77dff'>Marksman</t>", "marksman"],
	["<t color='#c77dff'>Vehicle Crew</t>", "crew"],
	["<t color='#c77dff'>Combat Diver</t>", "diver"],
	["<t color='#22B9FF'>Chopper Pilot</t>", "p"],
	["<t color='#22B9FF'>Para-Rescueman</t>", "pj"],
	["<t color='#22B9FF'>Jet Pilot</t>", "jetp"]
];
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
					"", "", "", -1, true, true
			],
			[
				"Disable Player Protection", {
					{
						if !(_x isKindOf "HeadlessClient_F") then {
							[QGVAR(disablePlayerProtection), [_x, true], _x] call CBA_fnc_targetEvent;
						};
					} forEach allPlayers;
				},
					"", "", "", -1, true, true
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
	private _selfLoadoutMenu = [];
	{
		_x params ["_name", "_role"];
		_selfLoadoutMenu pushBack [_name, compile format ["[player, '%1'] call GW_Gear_Fnc_Handler;", _role]];
	} forEach _loadoutRoles;
	_menus pushBack [["loadouts", "Loadouts", _menuRsc], _selfLoadoutMenu];
};

if (_menuName isEqualTo "target_loadouts") then {
	private _targetLoadoutMenu = [];
	{
		_x params ["_name", "_role"];
		_targetLoadoutMenu pushBack [_name, compile format ["private _unit = cursorObject; if (!isNull _unit && {alive _unit} && {_unit isKindOf 'CAManBase'} && {!(_unit isKindOf 'HeadlessClient_F')}) then {['%2', [_unit, '%1'], _unit] call CBA_fnc_targetEvent;};", _role, QGVAR(giveLoadout)]];
	} forEach _loadoutRoles;
	_menus pushBack [["target_loadouts", "Give Loadout", _menuRsc], _targetLoadoutMenu];
};

{
	if (((_x select 0) select 0) isEqualTo _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if ((count _menuDef) isEqualTo 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName isEqualTo "") then {_this}else{""},__FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};
_menuDef
