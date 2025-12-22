#include "script_component.hpp"

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
		["settings_main", "Settings Menu", _menuRsc],
		[
			[
				"View Distance >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_viewDistance", 1],
				-1,true,
				GVAR(viewDistance_Enabled)
			],
			[
				"Grass Settings >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_grass", 1],
				-1,true,
				GVAR(Grass_Enabled)
			],
			[
				"Hud Options >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_sthud", 1],
				-1, true,
				(GVAR(STHud_Enabled) || GVAR(STHud_EnabledOld))
			],
			[
				"Performance >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_performance", 1],
				-1, true,true
			],
			["Save Settings", { [QGVAR(settings), "save"] call CBA_fnc_localEvent; } ],
			["Load Settings", { [QGVAR(settings), "load"] call CBA_fnc_localEvent; } ]
		]
	]
];

if (_menuName isEqualTo "settings_viewDistance") then {
	_menus pushBack [
		["settings_viewDistance", format ["View Distance: %1", viewDistance], _menuRsc],
		[
			[
				"500",
				"setViewDistance 500; setObjectViewDistance 500;"
			],
			[
				"1000",
				"setViewDistance 1000; setObjectViewDistance 800;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 1000)
			],
			[
				"1200",
				"setViewDistance 1200; setObjectViewDistance 900;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 1200)
			],
			[
				"1500",
				"setViewDistance 1500; setObjectViewDistance 1050;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 1500)
			],
			[
				"2000",
				"setViewDistance 2000; setObjectViewDistance 1500;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 2000)
			],
			[
				"3000",
				"setViewDistance 3000; setObjectViewDistance 2500;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 3000)
			],
			[
				"4000",
				"setViewDistance 4000; setObjectViewDistance 3600;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 4000)
			],
			[
				"6000",
				"setViewDistance 6000; setObjectViewDistance 5400;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 6000)
			],
			[
				"8000",
				"setViewDistance 8000; setObjectViewDistance 7200;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 8000)
			],
			[
				"10000",
				"setViewDistance 10000; setObjectViewDistance 9000;",
				"","","",-1,true,
				(GVAR(viewDistance_Max) >= 10000)
			]
		]
	];
};

if (_menuName isEqualTo "settings_grass") then {
	_menus pushBack [
		["settings_grass","Grass Settings", _menuRsc],
		[
			[
				"None",
				"setTerrainGrid 50;",
				"","","",-1,true,
				GVAR(Grass_allowDisable)
			],
			[
				"Low",
				"setTerrainGrid 25;",
				"","","",-1,true,true
			],
			[
				"Medium",
				"setTerrainGrid 12.5;",
				"","","",-1,true,true
			],
			[
				"High",
				"setTerrainGrid 6.25;",
				"","","",-1,true,true
			]
		]
	];
};

if (GVAR(STHud_EnabledOld)) then {
	if (_menuName isEqualTo "settings_sthud") then {
		_menus pushBack [
			["settings_sthud","ST HUD", _menuRsc],
			[
				[
					"Display Mode >",
					"","","",
					[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_sthud_subMenu", 1]
				],
				["Toggle compass",{ST_STHud_ShowCompass = !ST_STHud_ShowCompass;}],
				["Restart HUD",{
					if (count (units (group player)) > 1) then {
						ST_STHud_ToRestart = true;
						call ST_STHud_Reload;
					};
				}]
			]
		];
	};

	if (_menuName isEqualTo "settings_sthud_subMenu") then {
		_menus pushBack [
			["settings_sthud_subMenu","Display Mode", _menuRsc],
			[
				["Normal",{
					3 call fn_sthud_usermenu_changeMode;
					player setVariable [QEGVAR(ui,STHUD_Mode), sthud_usermenu_uitypeInd];
				}],
				["HUD only",{
					1 call fn_sthud_usermenu_changeMode;
					player setVariable [QEGVAR(ui,STHUD_Mode), sthud_usermenu_uitypeInd];
				}],
				["Names only",{
					2 call fn_sthud_usermenu_changeMode;
					player setVariable [QEGVAR(ui,STHUD_Mode), sthud_usermenu_uitypeInd];
				}],
				["Off",{
					0 call fn_sthud_usermenu_changeMode;
					player setVariable [QEGVAR(ui,STHUD_Mode), sthud_usermenu_uitypeInd];
				}]
			]
		];
	};
};

if (GVAR(STHud_Enabled)) then {	// New
	if (_menuName isEqualTo "settings_sthud") then {
		_menus pushBack [
			["settings_sthud","ST HUD", _menuRsc],
			[
				[
					"Display Mode >",
					"","","",
					[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_sthud_subMenu", 1]
				],
				[
					"Toggle Compass",
					{[!GVAR(Toggle_STHud_Compass)] call FUNC(STHud_Toggle_Compass)},
					[GVAR(Toggle_STHud_Compass)] call FUNC(getCheckBoxIcon)
				],
				["Restart HUD",{
					STHUD_UIMode = 3;
					[true] call FUNC(STHud_Toggle_Compass);
				}]
			]
		];
	};

	if (_menuName isEqualTo "settings_sthud_subMenu") then {
		_menus pushBack [
			["settings_sthud_subMenu","Display Mode", _menuRsc],
			[
				["Normal", {
					STHUD_UIMode = 3;
					player setVariable [QEGVAR(ui,STHUD_Mode), STHUD_UIMode];
				}],
				["Names only", {
					STHUD_UIMode = 2;
					player setVariable [QEGVAR(ui,STHUD_Mode), STHUD_UIMode];
				}],
				["HUD only", {
					STHUD_UIMode = 1;
					player setVariable [QEGVAR(ui,STHUD_Mode), STHUD_UIMode];
				}],
				["Off", {
					STHUD_UIMode = 0;
					player setVariable [QEGVAR(ui,STHUD_Mode), STHUD_UIMode];
				}]
			]
		];
	};
};

if (_menuName isEqualTo "settings_performance") then {
	_menus pushBack [
		["settings_performance","Experimental", _menuRsc],
		[
/*
			[
				"Caching System",
				{[QGVAR(UnitCaching_enablePFH), true] call CBA_fnc_LocalEvent},
				[false] call FUNC(getCheckBoxIcon),
				"","",-1,true,
				!GVAR(UnitCaching_Enabled)
			],
			[
				"Caching System",
				{[QGVAR(UnitCaching_enablePFH), false] call CBA_fnc_LocalEvent},
				[true] call FUNC(getCheckBoxIcon),
				"","",-1,true,
				GVAR(UnitCaching_Enabled)
			],
*/
			[
				"Dynamic viewDistance (DVD)",
				{[true] call EFUNC(Performance,Handler_DynamicViewDistance)},
				[false] call FUNC(getCheckBoxIcon),
				"","",-1,true,
				!EGVAR(Performance,DynamicViewDistance_Enabled)
			],
			[
				"Dynamic viewDistance (DVD)",
				{[false] call EFUNC(Performance,Handler_DynamicViewDistance)},
				[true] call FUNC(getCheckBoxIcon),
				"","",-1,true,
				EGVAR(Performance,DynamicViewDistance_Enabled)
			],
			[
				"Target FPS for DVD >",
				"","","",
				[QUOTE(call FUNC(flexi_InteractSelf_Settings)),"settings_dvd_targetfps", 1]
			]
		]
	];
};

if (_menuName isEqualTo "settings_dvd_targetfps") then {
	_menus pushBack [
		["settings_dvd_targetfps","Target FPS", _menuRsc],
		[
			[
				"20",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 20; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 20] call FUNC(getCheckBoxIcon)
			],
			[
				"25",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 25; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 25] call FUNC(getCheckBoxIcon)
			],
			[
				"30",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 30; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 30] call FUNC(getCheckBoxIcon)
			],
			[
				"35",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 35; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 35] call FUNC(getCheckBoxIcon)
			],
			[
				"40",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 40; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 40] call FUNC(getCheckBoxIcon)
			],
			[
				"45",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 45; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 45] call FUNC(getCheckBoxIcon)
			],
			[
				"50",
				{ EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) = 50; },
				[EGVAR(Performance,DynamicViewDistance_AvgTargetDistance) isEqualTo 50] call FUNC(getCheckBoxIcon)
			]
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
