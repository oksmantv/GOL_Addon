#define MENU(var1) DOUBLES(ADDON,var1)
#define MENU_SUB(var1,var2) TRIPLES(ADDON,var1,var2)
#define MENU_SUB_SUB(var1,var2) TRIPLES(ADDON,var1,var2)

class Display3DEN {
	class ContextMenu: ctrlMenuStrip {
		class Items {
			class Log {
				items[] += {"LogVectors"};
			};

			items[] += {"GW_GOL_EXPORTCACHE","GOL_FRAMEWORK_SCRIPTS","GW_GOL_CREATE_UNITS"};

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
				items[] += {"GOL_FRAMEWORK_COPYROLE","GOL_FRAMEWORK_IMPORTCBA"};
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
					"GW_GOL_CREATE_UNITS_PATROL"
				};
			};

			class GW_GOL_CREATE_UNITS_STATIC {
				text = "Static Units";
				picture = "\a3\ui_f\data\Map\Markers\NATO\b_inf.paa";
				value = 0;
				items[] = {"GW_GOL_CREATE_UNITS_STATIC_WEST","GW_GOL_CREATE_UNITS_STATIC_EAST","GW_GOL_CREATE_UNITS_STATIC_INDEP"};
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
				items[] = {"GW_GOL_CREATE_UNITS_GARRISON_WEST","GW_GOL_CREATE_UNITS_GARRISON_EAST","GW_GOL_CREATE_UNITS_GARRISON_INDEP"};
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
				items[] = {"GW_GOL_CREATE_UNITS_PATROL_WEST","GW_GOL_CREATE_UNITS_PATROL_EAST","GW_GOL_CREATE_UNITS_PATROL_INDEP"};
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
            class GOL_FRAMEWORK_COPYROLE {
                text = "Copy Options";
                value = 0;
				items[] = {"GOL_FRAMEWORK_COPYROLE_ON","GOL_FRAMEWORK_COPYROLE_OFF","GOL_FRAMEWORK_DELETEONCOPY_ON","GOL_FRAMEWORK_DELETEONCOPY_OFF"};
            };
            class GOL_FRAMEWORK_COPYROLE_ON {
                text = "Copy Roles: On";
				action = "set3DENMissionAttributes [['Preferences', 'GW_CopyRoles', true]]; uiNamespace setVariable ['GW_CopyRoles', true]; systemChat 'Copy Roles: Enabled'; ['Copy Static/Group: Role copying enabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
            };            
            class GOL_FRAMEWORK_COPYROLE_OFF {
                text = "Copy Roles: Off";
				action = "set3DENMissionAttributes [['Preferences', 'GW_CopyRoles', false]]; uiNamespace setVariable ['GW_CopyRoles', false]; systemChat 'Copy Roles: Disabled'; ['Copy Static/Group: Role copying disabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
            };
			class GOL_FRAMEWORK_DELETEONCOPY_ON {
				text = "Delete on Copy: On";
				action = "set3DENMissionAttributes [['Preferences', 'GW_DeleteOnCopy', true]]; uiNamespace setVariable ['GW_DeleteOnCopy', true]; systemChat 'Delete on Copy: Enabled'; ['Copy Static/Group: Delete-on-copy enabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
			};
			class GOL_FRAMEWORK_DELETEONCOPY_OFF {
				text = "Delete on Copy: Off";
				action = "set3DENMissionAttributes [['Preferences', 'GW_DeleteOnCopy', false]]; uiNamespace setVariable ['GW_DeleteOnCopy', false]; systemChat 'Delete on Copy: Disabled'; ['Copy Static/Group: Delete-on-copy disabled', 0, 5, true, 0.5] call BIS_fnc_3DENNotification;";
			};
            class GOL_FRAMEWORK_IMPORTCBA {
                text = "Configure Framework";
                action = "set3DENMissionAttributes [['GW_MissionPreferences', 'GW_isConfigured', false]]; [] call GW_3DEN_fnc_setFramework;";
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
