#define MENU(var1) DOUBLES(ADDON,var1)
#define MENU_SUB(var1,var2) TRIPLES(ADDON,var1,var2)
#define MENU_SUB_SUB(var1,var2) TRIPLES(ADDON,var1,var2)

class Display3DEN {
	class ContextMenu: ctrlMenuStrip {
		class Items {
			class Log {
				items[] += {"LogVectors"};
			};

			items[] += {"GW_GOL_EXPORTCACHE","GOL_FRAMEWORK_SCRIPTS","GW_GOL_CREATE_UNITS","GW_GOL_SPAWN_LISTS"};

			class LogVectors {
				action = "[] call GW_3DEN_fnc_logVector;";
				conditionShow = "selectedObject";
				data = "LogVectors";
				text = "Log Vector Up and Dir to Clipboard";
				value = 0;
			};

			class GOL_FRAMEWORK_SCRIPTS {
                text = "GW FRAMEWORK";
				picture = "\x\gw\addons\3den\data\gwlogo.paa";
                value = 0;
					items[] += {"GOL_FRAMEWORK_IMPORTCBA","GOL_FRAMEWORK_CONFIGURE_PLAYER_VEHICLES","GOL_FRAMEWORK_RESTORE_MISSING_ITEMS","GOL_FRAMEWORK_COPYROLE","GOL_FRAMEWORK_MARKER_OPTIONS","GOL_FRAMEWORK_MARKERS"};
            };

			class GOL_FRAMEWORK_CONFIGURE_PLAYER_VEHICLES {
				text = "Configure Player Vehicles";
				picture = "\a3\ui_f\data\igui\cfg\actions\unloadVehicle_ca.paa";
				action = "[] call GW_3DEN_fnc_configurePlayerVehicles;";
				conditionShow = "selectedObject";
			};

			class GOL_FRAMEWORK_RESTORE_MISSING_ITEMS {
				text = "Restore Missing Items";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\box_ca.paa";
				action = "[] call GW_3DEN_fnc_restoreMissingItems;";
				conditionShow = "1";
			};

			class GOL_FRAMEWORK_GLOBAL_SIDE {
				text = "Select Side";
				picture = "\a3\ui_f\data\Map\Markers\Military\flag_CA.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_GLOBAL_SIDE_WEST",
					"GOL_FRAMEWORK_GLOBAL_SIDE_EAST",
					"GOL_FRAMEWORK_GLOBAL_SIDE_INDEPENDENT"
				};
			};
			class GOL_FRAMEWORK_GLOBAL_SIDE_WEST {
				text = "WEST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				action = "uiNamespace setVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; systemChat 'GW Framework side set: WEST';";
			};
			class GOL_FRAMEWORK_GLOBAL_SIDE_EAST {
				text = "EAST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\o_inf.paa";
				action = "uiNamespace setVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; systemChat 'GW Framework side set: EAST';";
			};
			class GOL_FRAMEWORK_GLOBAL_SIDE_INDEPENDENT {
				text = "INDEPENDENT";
				picture = "\a3\ui_f\data\Map\Markers\NATO\n_inf.paa";
				action = "uiNamespace setVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'INDEPENDENT']; systemChat 'GW Framework side set: INDEPENDENT';";
			};

			class GW_GOL_EXPORTCACHE {
				text = "Export & Clear Cache";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\exit_ca.paa";
				action = "[] call OKS_fnc_EdenClipboardCacheExportClear;";
				conditionShow = "1";
				value = 0;
			};

			class GW_GOL_CREATE_UNITS {
				text = "Create Units";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {
					"GW_GOL_CREATE_UNITS_STATIC",
					"GW_GOL_CREATE_UNITS_GARRISON",
					"GW_GOL_CREATE_UNITS_PATROL",
					"GW_GOL_CREATE_UNITS_WAYPOINT_OPTIONS"
				};
			};

			class GW_GOL_SPAWN_LISTS {
				text = "Spawn Lists";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\box_ca.paa";
				value = 0;
				items[] = {
					"GW_GOL_SPAWN_LISTS_CREATE_SPAWN_TRIGGER",
					"GW_GOL_SPAWN_LISTS_CREATE_REACTION_TRIGGER",
					"GW_GOL_SPAWN_LISTS_PLACE_DYNAMIC_ZONE"
				};
			};
			class GW_GOL_SPAWN_LISTS_CREATE_SPAWN_TRIGGER {
				text = "Create Spawn Trigger";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\attack_ca.paa";
				action = "[(uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call GW_3DEN_fnc_createSpawnTrigger;";
				conditionShow = "1";
			};
			class GW_GOL_SPAWN_LISTS_CREATE_REACTION_TRIGGER {
				text = "Create Reaction Trigger";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\defend_ca.paa";
				action = "[(uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call GW_3DEN_fnc_createReactionTrigger;";
				conditionShow = "1";
			};
			class GW_GOL_SPAWN_LISTS_PLACE_DYNAMIC_ZONE {
				text = "Place Dynamic Zone";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				action = "[(uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call GW_3DEN_fnc_placeDynamicZone;";
				conditionShow = "1";
			};

			class GW_GOL_CREATE_UNITS_STATIC {
				text = "Static Units";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_STATIC_2","GW_GOL_CREATE_UNITS_STATIC_6","GW_GOL_CREATE_UNITS_STATIC_10"};
			};
			class GW_GOL_CREATE_UNITS_STATIC_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 2] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 6] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 10] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_WEST {
				text = "WEST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_STATIC_WEST_2","GW_GOL_CREATE_UNITS_STATIC_WEST_6","GW_GOL_CREATE_UNITS_STATIC_WEST_10"};
			};
			class GW_GOL_CREATE_UNITS_STATIC_WEST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 2] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_WEST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 6] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_WEST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 10] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_EAST {
				text = "EAST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\o_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_STATIC_EAST_2","GW_GOL_CREATE_UNITS_STATIC_EAST_6","GW_GOL_CREATE_UNITS_STATIC_EAST_10"};
			};
			class GW_GOL_CREATE_UNITS_STATIC_EAST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 2] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_EAST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 6] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_EAST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 10] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_INDEP {
				text = "INDEPENDENT";
				picture = "\a3\ui_f\data\Map\Markers\NATO\n_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_STATIC_INDEP_2","GW_GOL_CREATE_UNITS_STATIC_INDEP_6","GW_GOL_CREATE_UNITS_STATIC_INDEP_10"};
			};
			class GW_GOL_CREATE_UNITS_STATIC_INDEP_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 2] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_INDEP_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 6] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_STATIC_INDEP_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 10] call OKS_fnc_EdenTemplateStaticUnits;";
				conditionShow = "1";
			};

			class GW_GOL_CREATE_UNITS_GARRISON {
				text = "Static Garrison";
				picture = "\a3\3den\Data\CfgWaypoints\guard_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_GARRISON_2","GW_GOL_CREATE_UNITS_GARRISON_6","GW_GOL_CREATE_UNITS_GARRISON_10"};
			};
			class GW_GOL_CREATE_UNITS_GARRISON_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 2] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 6] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 10] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_WEST {
				text = "WEST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_GARRISON_WEST_2","GW_GOL_CREATE_UNITS_GARRISON_WEST_6","GW_GOL_CREATE_UNITS_GARRISON_WEST_10"};
			};
			class GW_GOL_CREATE_UNITS_GARRISON_WEST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 2] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_WEST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 6] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_WEST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 10] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_EAST {
				text = "EAST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\o_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_GARRISON_EAST_2","GW_GOL_CREATE_UNITS_GARRISON_EAST_6","GW_GOL_CREATE_UNITS_GARRISON_EAST_10"};
			};
			class GW_GOL_CREATE_UNITS_GARRISON_EAST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 2] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_EAST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 6] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_EAST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 10] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_INDEP {
				text = "INDEPENDENT";
				picture = "\a3\ui_f\data\Map\Markers\NATO\n_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_GARRISON_INDEP_2","GW_GOL_CREATE_UNITS_GARRISON_INDEP_6","GW_GOL_CREATE_UNITS_GARRISON_INDEP_10"};
			};
			class GW_GOL_CREATE_UNITS_GARRISON_INDEP_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 2] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_INDEP_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 6] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_GARRISON_INDEP_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 10] call OKS_fnc_EdenTemplateStaticGarrison;";
				conditionShow = "1";
			};

			class GW_GOL_CREATE_UNITS_PATROL {
				text = "Patrol";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_PATROL_2","GW_GOL_CREATE_UNITS_PATROL_6","GW_GOL_CREATE_UNITS_PATROL_10"};
			};
			class GW_GOL_CREATE_UNITS_PATROL_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 2] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 6] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "private _s = toUpper (uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']); private _side = switch (_s) do { case 'EAST': { east }; case 'INDEPENDENT': { independent }; case 'GUER': { independent }; default { west }; }; [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side, 10] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_WEST {
				text = "WEST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_PATROL_WEST_2","GW_GOL_CREATE_UNITS_PATROL_WEST_6","GW_GOL_CREATE_UNITS_PATROL_WEST_10"};
			};
			class GW_GOL_CREATE_UNITS_PATROL_WEST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 2] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_WEST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 6] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_WEST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), west, 10] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_EAST {
				text = "EAST";
				picture = "\a3\ui_f\data\Map\Markers\NATO\o_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_PATROL_EAST_2","GW_GOL_CREATE_UNITS_PATROL_EAST_6","GW_GOL_CREATE_UNITS_PATROL_EAST_10"};
			};
			class GW_GOL_CREATE_UNITS_PATROL_EAST_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 2] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_EAST_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 6] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_EAST_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), east, 10] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_INDEP {
				text = "INDEPENDENT";
				picture = "\a3\ui_f\data\Map\Markers\NATO\n_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_PATROL_INDEP_2","GW_GOL_CREATE_UNITS_PATROL_INDEP_6","GW_GOL_CREATE_UNITS_PATROL_INDEP_10"};
			};
			class GW_GOL_CREATE_UNITS_PATROL_INDEP_2 {
				text = "2 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 2] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_INDEP_6 {
				text = "6 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 6] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};
			class GW_GOL_CREATE_UNITS_PATROL_INDEP_10 {
				text = "10 MAN";
				picture = "\a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
				action = "[(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), independent, 10] call OKS_fnc_EdenTemplatePatrol;";
				conditionShow = "1";
			};

			class GW_GOL_CREATE_UNITS_WAYPOINT_OPTIONS {
				text = "Waypoint Options";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_WP_PATTERN","GW_GOL_CREATE_UNITS_WP_RADIUS","GW_GOL_CREATE_UNITS_WP_COUNT"};
			};

			class GW_GOL_CREATE_UNITS_WP_PATTERN {
				text = "Waypoint Pattern";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_WP_PATTERN_CIRCLE","GW_GOL_CREATE_UNITS_WP_PATTERN_TRIANGLE","GW_GOL_CREATE_UNITS_WP_PATTERN_RECTANGLE","GW_GOL_CREATE_UNITS_WP_PATTERN_COLUMN"};
			};
			class GW_GOL_CREATE_UNITS_WP_PATTERN_CIRCLE {
				text = "Circle";
				picture = "\a3\3den\Data\CfgWaypoints\cycle_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointPattern','CIRCLE']]; systemChat 'Waypoint Pattern: CIRCLE'; ['Waypoint Pattern set: Circle', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_PATTERN_TRIANGLE {
				text = "Triangle";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointPattern','TRIANGLE']]; systemChat 'Waypoint Pattern: TRIANGLE'; ['Waypoint Pattern set: Triangle', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_PATTERN_RECTANGLE {
				text = "Rectangle";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointPattern','RECTANGLE']]; systemChat 'Waypoint Pattern: RECTANGLE'; ['Waypoint Pattern set: Rectangle', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_PATTERN_COLUMN {
				text = "Column (Back-and-forth)";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointPattern','COLUMN']]; systemChat 'Waypoint Pattern: COLUMN'; ['Waypoint Pattern set: Column', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};

			class GW_GOL_CREATE_UNITS_WP_RADIUS {
				text = "Waypoint Radius";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_WP_RADIUS_25","GW_GOL_CREATE_UNITS_WP_RADIUS_50","GW_GOL_CREATE_UNITS_WP_RADIUS_75","GW_GOL_CREATE_UNITS_WP_RADIUS_100","GW_GOL_CREATE_UNITS_WP_RADIUS_150","GW_GOL_CREATE_UNITS_WP_RADIUS_200"};
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_25 {
				text = "25m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',25]]; systemChat 'Waypoint Radius: 25'; ['Waypoint Radius set: 25m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_50 {
				text = "50m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',50]]; systemChat 'Waypoint Radius: 50'; ['Waypoint Radius set: 50m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_75 {
				text = "75m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',75]]; systemChat 'Waypoint Radius: 75'; ['Waypoint Radius set: 75m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_100 {
				text = "100m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',100]]; systemChat 'Waypoint Radius: 100'; ['Waypoint Radius set: 100m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_150 {
				text = "150m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',150]]; systemChat 'Waypoint Radius: 150'; ['Waypoint Radius set: 150m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_RADIUS_200 {
				text = "200m";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointRadius',200]]; systemChat 'Waypoint Radius: 200'; ['Waypoint Radius set: 200m', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};

			class GW_GOL_CREATE_UNITS_WP_COUNT {
				text = "Waypoint Count";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_WP_COUNT_4","GW_GOL_CREATE_UNITS_WP_COUNT_6","GW_GOL_CREATE_UNITS_WP_COUNT_8","GW_GOL_CREATE_UNITS_WP_COUNT_10","GW_GOL_CREATE_UNITS_WP_COUNT_12","GW_GOL_CREATE_UNITS_WP_COUNT_16"};
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_4 {
				text = "4";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',4]]; systemChat 'Waypoint Count: 4'; ['Waypoint Count set: 4', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_6 {
				text = "6";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',6]]; systemChat 'Waypoint Count: 6'; ['Waypoint Count set: 6', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_8 {
				text = "8";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',8]]; systemChat 'Waypoint Count: 8'; ['Waypoint Count set: 8', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_10 {
				text = "10";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',10]]; systemChat 'Waypoint Count: 10'; ['Waypoint Count set: 10', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_12 {
				text = "12";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',12]]; systemChat 'Waypoint Count: 12'; ['Waypoint Count set: 12', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GW_GOL_CREATE_UNITS_WP_COUNT_16 {
				text = "16";
				picture = "\a3\3den\Data\CfgWaypoints\move_ca.paa";
				action = "set3DENMissionAttributes [['Preferences','GW_WaypointCount',16]]; systemChat 'Waypoint Count: 16'; ['Waypoint Count set: 16', 0, 4, true, 0.5] call BIS_fnc_3DENNotification;";
			};
            class GOL_FRAMEWORK_COPYROLE {
                text = "Copy Options";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa";
                value = 0;
				items[] = {"GOL_FRAMEWORK_GLOBAL_SIDE","GOL_FRAMEWORK_COPYROLE_ON","GOL_FRAMEWORK_COPYROLE_OFF","GOL_FRAMEWORK_DELETEONCOPY_ON","GOL_FRAMEWORK_DELETEONCOPY_OFF"};
            };
            class GOL_FRAMEWORK_COPYROLE_ON {
                text = "Copy Roles: On";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa";
				action = "set3DENMissionAttributes [['Preferences', 'GW_CopyRoles', true]]; uiNamespace setVariable ['GW_CopyRoles', true]; systemChat 'Copy Roles: Enabled'; ['Copy Static/Group: Role copying enabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
            };            
            class GOL_FRAMEWORK_COPYROLE_OFF {
                text = "Copy Roles: Off";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\exit_ca.paa";
				action = "set3DENMissionAttributes [['Preferences', 'GW_CopyRoles', false]]; uiNamespace setVariable ['GW_CopyRoles', false]; systemChat 'Copy Roles: Disabled'; ['Copy Static/Group: Role copying disabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
            };
			class GOL_FRAMEWORK_DELETEONCOPY_ON {
				text = "Delete on Copy: On";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\exit_ca.paa";
				action = "set3DENMissionAttributes [['Preferences', 'GW_DeleteOnCopy', true]]; uiNamespace setVariable ['GW_DeleteOnCopy', true]; systemChat 'Delete on Copy: Enabled'; ['Copy Static/Group: Delete-on-copy enabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GOL_FRAMEWORK_DELETEONCOPY_OFF {
				text = "Delete on Copy: Off";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\exit_ca.paa";
				action = "set3DENMissionAttributes [['Preferences', 'GW_DeleteOnCopy', false]]; uiNamespace setVariable ['GW_DeleteOnCopy', false]; systemChat 'Delete on Copy: Disabled'; ['Copy Static/Group: Delete-on-copy disabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
			};
            class GOL_FRAMEWORK_IMPORTCBA {
                text = "Configure Framework";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa";
                action = "set3DENMissionAttributes [['GW_MissionPreferences', 'GW_isConfigured', false]]; [] call GW_3DEN_fnc_setFramework;";
            };

			class GOL_FRAMEWORK_MARKER_OPTIONS {
				text = "Marker Options";
				picture = "\a3\ui_f\data\Map\Markers\Military\flag_CA.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_OPTIONS_FLAG_ON",
					"GOL_FRAMEWORK_MARKER_OPTIONS_FLAG_OFF"
				};
			};
			class GOL_FRAMEWORK_MARKER_OPTIONS_FLAG_ON {
				text = "Flags: On";
				picture = "\a3\ui_f\data\Map\Markers\Military\flag_CA.paa";
				action = "uiNamespace setVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', true]; systemChat 'GW Marker Options: Flags ON';";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_OPTIONS_FLAG_OFF {
				text = "Flags: Off";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\exit_ca.paa";
				action = "uiNamespace setVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; systemChat 'GW Marker Options: Flags OFF';";
				conditionShow = "1";
			};

			class GOL_FRAMEWORK_MARKERS {
				text = "Markers";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_FRONTLINE_UNITS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_UNITS",
					"GOL_FRAMEWORK_MARKER_FRONTLINE_NODES"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH {
				text = "Organisation Strength";
				picture = "\a3\ui_f\data\Map\Markers\Military\flag_CA.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_FRONTLINE_UNITS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_UNITS"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_FRONTLINE_UNITS {
				text = "Front line units";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_UNITS {
				text = "Support units";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_support.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY {
				text = "Artillery";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_art.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS {
				text = "Mortars";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_mortar.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE {
				text = "Service";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_service.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL {
				text = "Naval";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_naval.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION {
				text = "Installation";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_installation.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS {
				text = "Logistics";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_service.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL {
				text = "Medical";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_med.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON {
				text = "Recon";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_recon.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA {
				text = "AA";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_antiair.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER {
				text = "Engineer";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_maint.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARTILLERY_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'ARTILLERY', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MORTARS_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'MORTARS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SERVICE_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'SERVICE', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_NAVAL_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'NAVAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INSTALLATION_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'INSTALLATION', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_LOGISTICS_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'LOGISTICS', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MEDICAL_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'MEDICAL', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_RECON_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'RECON', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AA_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'AA', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_0', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_1', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_2', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_3', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_4', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_5', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_6', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_7', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_8', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_9', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_10', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ENGINEER_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'EAST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'OPFOR' }; }; ['group_11', _addFlag, _f, 'ENGINEER', (uiNamespace getVariable ['BIS_fnc_3DENEntityMenu_data', []])] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY {
				text = "Infantry";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED {
				text = "Motorised";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_motor_inf.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED {
				text = "Mechanized";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_mech_inf.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED {
				text = "Armored";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_armor.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR {
				text = "Air";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_plane.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER {
				text = "Helicopter";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_air.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_ARMYGROUP"
				};
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT {
				text = "Support";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_support.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_FIRETEAM {
				text = "Fire Team";
				action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_INFANTRY_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'INFANTRY'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MOTORISED_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'MOTORISED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_MECHANIZED_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'MECHANIZED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_ARMORED_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'ARMORED'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_AIR_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'AIR'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_HELICOPTER_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'HELICOPTER'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_FIRETEAM { text = "Fire Team"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_SQUAD { text = "Squad"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_SECTION { text = "Section"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_PLATOON { text = "Platoon"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_COMPANY { text = "Company"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_BATTALION { text = "Battalion"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_REGIMENT { text = "Regiment"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_BRIGADE { text = "Brigade"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_DIVISION { text = "Division"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_CORPS { text = "Corps"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_ARMY { text = "Army"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_SUPPORT_ARMYGROUP { text = "Army Group"; action = "private _addFlag = uiNamespace getVariable ['GW_FRAMEWORK_MARKER_ADD_FLAG', false]; private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', _addFlag, _f, 'SUPPORT'] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG {
				text = "With Flag";
				picture = "\a3\ui_f\data\Map\Markers\Military\flag_CA.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_FIRETEAM {
				text = "Fire Team";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_0', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_SQUAD {
				text = "Squad";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_1', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_SECTION {
				text = "Section";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_2', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_PLATOON {
				text = "Platoon";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_3', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_COMPANY {
				text = "Company";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_4', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BATTALION {
				text = "Battalion";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_5', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_REGIMENT {
				text = "Regiment";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_6', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BRIGADE {
				text = "Brigade";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_7', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_DIVISION {
				text = "Division";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_8', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_CORPS {
				text = "Corps";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_9', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_ARMY {
				text = "Army";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_10', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_ARMYGROUP {
				text = "Army Group";
				action = "private _s = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; private _f = switch (toUpper _s) do { case 'WEST': { 'BLUFOR' }; case 'EAST': { 'OPFOR' }; case 'GUER': { 'INDEP' }; case 'INDEPENDENT': { 'INDEP' }; default { 'BLUFOR' }; }; ['group_11', true, _f] call OKS_fnc_EdenMarkOrgStrength;";
				conditionShow = "1";
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR {
				text = "BLUFOR";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR {
				text = "OPFOR";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP {
				text = "INDEPENDENT";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG {
				text = "Without Flag";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_FIRETEAM",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_SQUAD",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_SECTION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_PLATOON",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_COMPANY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_BATTALION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_REGIMENT",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_BRIGADE",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_DIVISION",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_CORPS",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_ARMY",
					"GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_ARMYGROUP"
				};
			};

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_FIRETEAM { text = "Fire Team"; action = "[""group_0"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_SQUAD { text = "Squad"; action = "[""group_1"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_SECTION { text = "Section"; action = "[""group_2"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_PLATOON { text = "Platoon"; action = "[""group_3"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_COMPANY { text = "Company"; action = "[""group_4"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_BATTALION { text = "Battalion"; action = "[""group_5"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_REGIMENT { text = "Regiment"; action = "[""group_6"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_BRIGADE { text = "Brigade"; action = "[""group_7"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_DIVISION { text = "Division"; action = "[""group_8"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_CORPS { text = "Corps"; action = "[""group_9"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_ARMY { text = "Army"; action = "[""group_10"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_BLUFOR_ARMYGROUP { text = "Army Group"; action = "[""group_11"", true, ""BLUFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_FIRETEAM { text = "Fire Team"; action = "[""group_0"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_SQUAD { text = "Squad"; action = "[""group_1"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_SECTION { text = "Section"; action = "[""group_2"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_PLATOON { text = "Platoon"; action = "[""group_3"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_COMPANY { text = "Company"; action = "[""group_4"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_BATTALION { text = "Battalion"; action = "[""group_5"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_REGIMENT { text = "Regiment"; action = "[""group_6"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_BRIGADE { text = "Brigade"; action = "[""group_7"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_DIVISION { text = "Division"; action = "[""group_8"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_CORPS { text = "Corps"; action = "[""group_9"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_ARMY { text = "Army"; action = "[""group_10"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_OPFOR_ARMYGROUP { text = "Army Group"; action = "[""group_11"", true, ""OPFOR""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_FIRETEAM { text = "Fire Team"; action = "[""group_0"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_SQUAD { text = "Squad"; action = "[""group_1"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_SECTION { text = "Section"; action = "[""group_2"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_PLATOON { text = "Platoon"; action = "[""group_3"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_COMPANY { text = "Company"; action = "[""group_4"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_BATTALION { text = "Battalion"; action = "[""group_5"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_REGIMENT { text = "Regiment"; action = "[""group_6"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_BRIGADE { text = "Brigade"; action = "[""group_7"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_DIVISION { text = "Division"; action = "[""group_8"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_CORPS { text = "Corps"; action = "[""group_9"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_ARMY { text = "Army"; action = "[""group_10"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHFLAG_INDEP_ARMYGROUP { text = "Army Group"; action = "[""group_11"", true, ""INDEP""] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_FIRETEAM { text = "Fire Team"; action = "[""group_0"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_SQUAD { text = "Squad"; action = "[""group_1"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_SECTION { text = "Section"; action = "[""group_2"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_PLATOON { text = "Platoon"; action = "[""group_3"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_COMPANY { text = "Company"; action = "[""group_4"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_BATTALION { text = "Battalion"; action = "[""group_5"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_REGIMENT { text = "Regiment"; action = "[""group_6"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_BRIGADE { text = "Brigade"; action = "[""group_7"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_DIVISION { text = "Division"; action = "[""group_8"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_CORPS { text = "Corps"; action = "[""group_9"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_ARMY { text = "Army"; action = "[""group_10"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };
			class GOL_FRAMEWORK_MARKER_ORGSTRENGTH_WITHOUTFLAG_ARMYGROUP { text = "Army Group"; action = "[""group_11"", false] call OKS_fnc_EdenMarkOrgStrength;"; conditionShow = "1"; };

			class GOL_FRAMEWORK_MARKER_FRONTLINE_NODES {
				text = "Frontline Nodes";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				value = 0;
				items[] = {
					"GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_PLACE",
					"GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_CREATE_ROUNDED",
					"GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_CREATE_SHARP"
				};
			};

			class GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_PLACE {
				text = "Place Node";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move_ca.paa";
				action = "private _side = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; if (isNil 'OKS_fnc_EdenFrontlineNodePlace') then { systemChat 'Frontline Nodes: function NIL (OKS mod not loaded?)'; } else { [(uiNamespace getVariable 'BIS_fnc_3DENEntityMenu_data'), _side] call OKS_fnc_EdenFrontlineNodePlace; };";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_CREATE_ROUNDED {
				text = "Create Frontlines (Rounded)";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				action = "private _side = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; if (isNil 'OKS_fnc_EdenFrontlineCreateFromNodes') then { systemChat 'Frontline Nodes: function NIL (OKS mod not loaded?)'; } else { [_side, true, 30, 3] call OKS_fnc_EdenFrontlineCreateFromNodes; };";
				conditionShow = "1";
			};
			class GOL_FRAMEWORK_MARKER_FRONTLINE_NODES_CREATE_SHARP {
				text = "Create Frontlines (Sharp)";
				picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\map_ca.paa";
				action = "private _side = uiNamespace getVariable ['GW_FRAMEWORK_GLOBAL_SIDE', 'WEST']; if (isNil 'OKS_fnc_EdenFrontlineCreateFromNodes') then { systemChat 'Frontline Nodes: function NIL (OKS mod not loaded?)'; } else { [_side, false] call OKS_fnc_EdenFrontlineCreateFromNodes; };";
				conditionShow = "1";
			};
		};
	};

	class Controls {
		class ButtonPlay: ctrlShortcutButton {
			shortcuts[]= {};
		};

		class MenuStrip: ctrlMenuStrip {
			class Items {
				items[] += {QUOTE(MENU(Copy)),"GW_Menu"};
				class ViewRandom {
					shortcuts[] = {};
				};
				class GW_Menu {
					text = "GW Tools";
					items[] = {
						MENU(doActions),
						MENU(set3DENAttributes),
						MENU(Misc),
						"Separator",
						MENU(OpenSettingsMenu),
						MENU(getVersionMenu),
						"Separator",
						MENU(Extra),
						MENU(About)
					};
				};

				class MENU(Copy) {
					text = "Copy Selected";
					items[] = {
						MENU_SUB(Copy,Group),
						MENU_SUB(Copy,OnlyMen),
						MENU_SUB(Copy,AllObjects),
						MENU_SUB(Copy,Loadout),
						"Separator",
						MENU_SUB(Copy,prefabMHQ),
						MENU_SUB(Copy,relativeObjects),
						"Separator",
						MENU_SUB(Copy,Export)
					};
				};

				class MENU(doActions) {
					text = "Placement Tools";
					items[] = {
						MENU_SUB(doActions,GarrisonBuildings),
						MENU_SUB(doActions,createWaypoints),
						MENU_SUB(doActions,createWaypointsFast),
						"Separator",
						MENU_SUB(doActions,ToggleTerrain),
						MENU_SUB(doActions,pattern_Line),
						MENU_SUB(doActions,pattern_Circular),
						MENU_SUB(doActions,pattern_offset),
						"Separator",
						MENU_SUB(doActions,Help)
					};
				};

				class MENU(set3DENAttributes) {
					text = "Attributes";
					items[] = {
						MENU_SUB(set3DENAttributes,unitStance),
						MENU_SUB(set3DENAttributes,simpleObject),
						MENU_SUB(set3DENAttributes,enableSimulation),
						MENU_SUB(set3DENAttributes,dynamicSim),
						MENU_SUB(set3DENAttributes,allowDamage),
						"Separator",
						MENU_SUB(set3DENAttributes,Help)
					};
				};

				class MENU(Misc) {
					text = "Miscellaneous";
					items[] = {
						MENU_SUB(Misc,addUnitToProjectileTracker),
						MENU_SUB(Misc,exportMissingAuthors),
						MENU_SUB(Misc,exportWeapons),
						MENU_SUB(Misc,Utilities),
						"Separator",
						MENU_SUB(Misc,Help)
					};
				};

				class MENU(OpenSettingsMenu) {
					text = "Open Framework Settings...";
					action = "edit3DENMissionAttributes 'GW_MissionPreferences';";
					shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_K};
				};

				class MENU(getVersionMenu) {
					text = "Check Version...";
//					text = "Get Versions Menu...";
					action = "[] call GW_3den_fnc_getVersion;";
				};

				class MENU(Extra) {
					text = "Extra";
					items[] = {
						MENU(DebugConsole),
						"LogFolder",
						MENU(ClearServerSettings),
						MENU(ClearChat),
						MENU_SUB(Extra,Help)
					};
				};

				class MENU(About) {
					text = "About";
					items[] = {
						"HelpTutorials",
						"GW_Addon_Github",
						"GW_Github"
//						"GW_MissionRequirements",	// Legacy
//						"GOL_Wiki"
					};
				};

				#include "display3DEN\_about.hpp"			// About
				#include "display3DEN\_copy.hpp"			// Copy Selected
				#include "display3DEN\_doActions.hpp"		// Placement Tools
				#include "display3DEN\_extra.hpp"			// Extra
				#include "display3DEN\_misc.hpp"			// Misc
				#include "display3DEN\_setAttributes.hpp"	// Attributes

				class MENU(Actions) {
					text = "Repeat Action";
					action = QUOTE(call FUNC(uiCallFunction));
					shortcuts[] = {INPUT_SHIFT_OFFSET + DIK_5};
				};

				class MissionPreviewSP {
					shortcuts[]={};
				};
				class MissionPreviewSPBriefing {
					shortcuts[]={};
				};
				class MissionPreviewCamera {
					shortcuts[]={};
				};
				class MissionPreviewSpectator {
					shortcuts[]={};
				};
				class MissionPreviewMP {
					shortcuts[]={};
				};
			};
		};

		class StatusBar: ctrlControlsGroupNoScrollbars {
			class Controls {
				class ValueX;
				class TextX;
				class GW_session_Text: TextX {
					text = "\a3\Ui_f\data\GUI\RscCommon\RscDebugConsole\performance_ca.paa";
					colorBackground[] = {0,0,0,0};
					x = "(5 * (	3 + 16 + 4)) * (pixelW * pixelGrid * 0.50)";
				};
				class GW_session_Value: ValueX {
					tooltip = "Mission Status";
					idc = 10540;
					w = "90 * (pixelW * pixelGrid * 0.50)";
					x = "(5 * (	3 + 16 + 4) + 3) * (pixelW * pixelGrid * 0.50)";
				};
			};
		};

		class Toolbar: ctrlControlsGroupNoScrollbars {
			class Controls {
				class Mission: ctrlControlsGroupNoScrollbars {
					w = "11 * (5 * (pixelW * pixelGrid * 0.50))";
					class Controls {
						class Map;
						class MapID: Map {
							idc = 10307;
							action = "";
							onCheckedChanged = QUOTE(0 call FUNC(doActionMisc));
							onLoad = "";
							tooltip = "Map ID";
							textureChecked = QPATHTOF(Data\icon_ID_on_ca.paa);
							textureUnchecked = QPATHTOF(Data\icon_ID_off_ca.paa);
							textureFocusedChecked = QPATHTOF(Data\icon_ID_on_ca.paa);
							textureFocusedUnchecked = QPATHTOF(Data\icon_ID_off_ca.paa);
							textureHoverChecked = QPATHTOF(Data\icon_ID_on_ca.paa);
							textureHoverUnchecked = QPATHTOF(Data\icon_ID_off_ca.paa);
							texturePressedChecked = QPATHTOF(Data\icon_ID_on_ca.paa);
							texturePressedUnchecked = QPATHTOF(Data\icon_ID_off_ca.paa);
							textureDisabledChecked = QPATHTOF(Data\icon_ID_on_ca.paa);
							textureDisabledUnchecked = QPATHTOF(Data\icon_ID_off_ca.paa);
							x = "4 * (5 * (pixelW * pixelGrid * 0.50))";
						};
						class Workspace: ctrlCombo {
							x = "5.5 * (5 * (pixelW * pixelGrid * 0.50))";
						};
					};
				};
				class Separator6: Separator1 {
					x = "35 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
				};
				class GW_Toolbar_Controls: ctrlControlsGroupNoScrollbars {
					idc = 100001;
					h = "(	5 * (pixelH * pixelGrid * 	0.50))";
					w = "5 * (5 * (pixelW * pixelGrid * 0.50))";
					x = "34.5 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
					y = "1 * (pixelH * pixelGrid * 	0.50)";
					class Controls {
						class QuickAction: ctrlButtonToolbar {
							idc = 100002;
							action = "[] call GW_3DEN_fnc_uiCallFunction";
							tooltip = "GW Tools: Repeat Last Action Used";
							text = "\a3\3DEN\Data\Attributes\NameSound\special_ca.paa";
							h = "(	5 * (pixelH * pixelGrid * 	0.50))";
							w = "(	5 * (pixelW * pixelGrid * 	0.50))";
							x = "1 * 	(	5 * (pixelW * pixelGrid * 	0.50))";
							y = 0;
						};
					};
				};
			};
		};
	};
};
