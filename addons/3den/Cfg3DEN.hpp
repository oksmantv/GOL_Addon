
class Cfg3DEN {
	class Group {
		class AttributeCategories {
			class State {
				class Attributes {
					delete Behaviour;
					delete CombatMode;
//					delete DeleteWhenEmpty;
//					delete DynamicSimulation;
					delete Formation;
					delete SpeedMode;
				};
			};
		};
	};

	class Attributes {
		class Combo;
		class Controls;
		class Default;
		class Value;
		class GarbageCollectorMode;
		class Title : Default {
			class Controls {
				class Title;
			};
		};
		class Toolbox;

		class GW_AutoTest_Box : Toolbox {
			attributeLoad = "_this call GW_3den_fnc_AutoTest";
//			attributeLoad = "_this call GW_fnc_AutoTest";
			attributeSave = "";
			w = (ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W;
			h = 23 * SIZE_M * GRID_H;
			class ScrollBar {
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
			};
			class Controls {
				class ActionListBackground : ctrlStatic {
					idc = -1;
					x = SIZE_M * GRID_H;
					y = GRID_H;
					w = ((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W)) * GRID_W;
					h = 23 * SIZE_M * GRID_H;
					colorBackground[] = {0.33,0.33,0.33,0.5};
				};
				class ActionList: ctrlListBox {
					idc = 15675;
					x = SIZE_M * GRID_H;
					y = GRID_H;
					w = ((ATTRIBUTE_TITLE_W + (ATTRIBUTE_CONTENT_W - 25))) * GRID_W;
					h = 23 * SIZE_M * GRID_H;
					columns[] = {0,0.05};
                    drawSideArrows = 0;
                    idcLeft = -1;
                    idcRight = -1;
					disableOverflow = 1;
//					onLBDblClick = "_this spawn GW_3den_fnc_AutoTest_Events; false";
					onLBSelChanged = "_this spawn {(_this select 0) lbSetCurSel -1}; false";
				};
				class ActionListButton: ctrlListBox {
					idc = 15676;
					x = (SIZE_M + 78) * GRID_H;
					y = GRID_H;
					w = "(45 * (pixelW * pixelGrid * 0.50))";
					h = 23 * SIZE_M * GRID_H;
					columns[] = {0,0.05};
                    drawSideArrows = 0;
                    idcLeft = -1;
                    idcRight = -1;
					disableOverflow = 1;
					onLBSelChanged = "_this spawn GW_3den_fnc_AutoTest_Events;";
				};
			};
		};

		class GW_SelectLoadout: Combo {
			class Controls: Controls {
				class Title: Title{};
				class Value: Value {
					class Items {
						class loadout_none {
							text = "NONE";
							data = "";
							default = 1;
						};
						class loadout_pl {
							text = "Platoon leader";
							data = "pl";
						};
						class loadout_fac {
							text = "Forward Air Controller";
							data = "fac";
						};
						class loadout_sl {
							text = "Squad Leader";
							data = "sl";
						};
						class loadout_sm {
							text = "Squad Medic";
							data = "sm";
						};
						class loadout_ftl {
							text = "Fire team leader";
							data = "ftl";
						};
						class loadout_r {
							text = "Rifleman";
							data = "r";
						};
						class loadout_g {
							text = "Grenadier";
							data = "g";
						};
						class loadout_ag {
							text = "Asst. Gunner";
							data = "ag";
						};
						class loadout_ar {
							text = "Automatic Rifleman";
							data = "ar";
						};
						class loadout_crew {
							text = "Crew Member";
							data = "crew";
						};
						class loadout_p {
							text = "Pilot";
							data = "p";
						};
					};
				};
			};
		};

		class GW_SelectColor: Combo {
			class Controls: Controls {
				class Title: Title{};
				class Value: Value {
					class Items {
						class gw_white {
							text = "White";
							data = "main";
							default = 1;
						};
						class gw_green {
							text = "Green";
							data = "green";
						};
						class gw_red {
							text = "Red";
							data = "red";
						};
						class gw_blue {
							text = "Blue";
							data = "blue";
						};
						class gw_yellow {
							text = "Yellow";
							data = "yellow";
						};
					};
				};
			};
		};

		class GW_copyOnEmptyMode: GarbageCollectorMode {
			class Controls: Controls {
				class Title: Title{};
				class Value: Value {
					class Items {
						class Newest {
							text = "Framework (0.8 or higher)";
							data = "0.8";
							default = 1;
						};
						class legacy08 {
//							text = "Copy version 1.8";
							text = "Framework Legacy (0.6)";
							data = "0.6";
						};
						class legacy07 {
//							text = "Copy version 1.5";
							text = "Framework Legacy (0.5 or less)";
							data = "0.5";
						};
					};
				};
			};
		};
	};

	class Mission {
		class Multiplayer {
			class AttributeCategories {
				class Revive {
					collapsed = 1;
				};
			};
		};

		class GW_MissionPreferences {
			displayName = "Mission Settings";
			class AttributeCategories {
				class GW_Options {
					displayName = "General Settings";
					collapsed = 0;
					class Attributes {
						class GW_isConfigured {
							displayName = "is Auto Configured";
							tooltip = "Checks if mission is given default values, Uncheck this if you need to reset settings";
							property = "GW_isConfigured";
							value = 1;
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
						class GW_isConfigured_ACE {
							displayName = "is ACE Configured";
							tooltip = "Checks if mission is given default values, Uncheck this if you need to reset settings";
							property = "GW_isConfigured_ACE";
							value = 1;
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
						class GW_isDebug {
							displayName = "Enable Debug";
							tooltip = "";
							property = "GW_isDebug";
							value = 1;
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
					};
				};

				class GW_AutoTestFakeNameing {
					displayName = "AutoTest";
					collapsed = 0;
					class Attributes {
						class GW_AutoTest_Box {
							property = "GW_AutoTest_Box";
							control = "GW_AutoTest_Box";
							defaultValue = "true";
//							condition = "true";
						};
					};
				};
			};
		};

		class Preferences {
			class AttributeCategories {
				class Camera {
					collapsed = 1;
				};
				class Internal {
					collapsed = 1;
				};
				class Misc {
					collapsed = 1;
				};
				class Saving {
					collapsed = 1;
					class Attributes {
						class Binarize {
							value = 0;
						};
					};
				};

				class GW_Options {
					displayName = "GW Tools: General Settings";
					class Attributes {
						class GW_ShowMessage {
							displayName = "Show Warning Message";
							tooltip = "Shows warning message when using some of the actions";
							property = "GW_ShowMessage";
							control = "Checkbox";
							defaultValue = "true";
							expression = "true";
						};
						class GW_Show3DMessage {
							displayName = "Display 3D Text";
							tooltip = "Will only show 3d text on specific modules placed thought the menu";
							property = "GW_Show3DMessage";
							control = "Checkbox";
							defaultValue = "true";
							expression = "true";
						};
						class GW_GarrisonRadius {
							displayName = "Garrison Radius";
							tooltip = "Buildings to gather around unit clicked";
							property = "GW_GarrisonRadius";
							control = "EditShort";
							expression = "";
							defaultValue = "50";
							typeName = "NUMBER";
						};
						class GW_PatternOffset {
							displayName = "Pattern Radius";
							tooltip = "Offset for Linear and Circular offset";
							property = "GW_PatternOffset";
							control = "EditShort";
							expression = "";
							defaultValue = "5";
							typeName = "NUMBER";
						};
					};
				};

				class GW_Options_Copy {
					displayName = "GW Tools: Copy Settings";
					class Attributes {
						class GW_DeleteOnCopy {
							displayName = "Delete on copy";
							tooltip = "Delete all selected things successful upon copying";
							property = "GW_DeleteOnCopy";
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
						class GW_CopyToClipboard {
							displayName = "Copy code to Clipboard";
							tooltip = "(WARNING: Advenced Users Only)";
							property = "GW_CopyToClipboard";
							control = "Checkbox";
							defaultValue = "true";
							expression = "true";
						};
						class GW_PrintToConsoleLog {
							displayName = "Print to Remote Debug Console";
							tooltip = "Opens a remote console to display all code copied, Perfect for multi-monitor";
							property = "GW_PrintToConsoleLog";
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
						class GW_PrintToConsoleFile {
							displayName = "Print to File";
							tooltip = "Prints copied code to arma3/debug_console_#DATE#.txt";
							property = "GW_PrintToConsoleFile";
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
/*
						class GW_useNewCopy {
							displayName = "Autodetect New Copy";
							tooltip = "DO NOT CHANGE THIS MANUALLY";
							property = "GW_useNewCopy";
							control = "Checkbox";
							defaultValue = "false";
							expression = "true";
						};
*/
						class GW_copyOnEmpty {
							displayName = "Copy Mode on empty mission";
							tooltip = "";
							property = "GW_copyOnEmpty";
							control = "GW_copyOnEmptyMode";
							defaultValue = "0";
							value = 0;
						};
					};
				};

				class GW_Options_Waypoint {
					displayName = "GW Tools: Generate Waypoint";
					class Attributes {
						class GW_WaypointRadius {
							displayName = "Waypoint Radius";
							tooltip = "Places waypoints in a radius around right clicked";
							property = "GW_WaypointRadius";
							control = "EditShort";
							expression = "";
							defaultValue = "150";
							typeName = "NUMBER";
						};
						class GW_WaypointCount {
							displayName = "Waypoint Count";
							tooltip = "Amount of waypoints to be placed";
							property = "GW_WaypointCount";
							control = "EditShort";
							expression = "";
							defaultValue = "7";
							typeName = "NUMBER";
						};
					};
				};
			};
		};
	};

	class Object {
		class AttributeCategories {
			delete Identity;
			class Inventory {
				collapsed = 1;
				class Attributes {
					class AmmoBox {
					};
				};
			};
			class Control {
				collapsed = 1;
				class Attributes {
					class GW_TeamColor {
						displayName = "Team Color";
						tooltip = "Sets current team color";
						property = "GW_TeamColor";
						control = "GW_SelectColor";
						expression = "_this setVariable ['GW_Common_GroupColor', _value, true];";
//						expression = "if (isPlayer _this) then {_this setVariable ['GW_Common_GroupColor', _value, true];};";
						condition = "objectBrain";
					};
				};
			};
			class State {
				collapsed = 1;
				class Attributes {
					class allowDamage {
						property = "allowDamage";
						control = "Checkbox";
						displayName = "$STR_3DEN_Object_Attribute_AllowDamage_displayName";
						tooltip = "$STR_3DEN_Object_Attribute_AllowDamage_tooltip";
						expression = "_this allowdamage _value;";
						defaultValue = "true";
						wikiType = "[[Bool]]";
					};
					class enableSimulation {
						data = "enableSimulation";
						control = "Checkbox";
						displayName = "$STR_3DEN_Object_Attribute_EnableSimulation_displayName";
						tooltip = "$STR_3DEN_Object_Attribute_EnableSimulation_tooltip";
						wikiType = "[[Bool]]";
					};
					class enableStamina {
						property = "enableStamina";
						control = "Checkbox";
						displayName = "$STR_3DEN_Object_Attribute_EnableStamina_displayName";
						tooltip = "$STR_3DEN_Object_Attribute_EnableStamina_tooltip";
						expression = "_this enablestamina _value;";
						defaultValue = "true";
						condition = "objectBrain";
						wikiType = "[[Bool]]";
					};
					class hideObject {
						property = "hideObject";
						control = "CheckboxReversed";
						displayName = "$STR_3DEN_Object_Attribute_HideObject_displayName";
						tooltip = "$STR_3DEN_Object_Attribute_HideObject_tooltip";
						expression = "if !(is3DEN) then {_this hideobjectglobal _value;};";
						defaultValue = "false";
						wikiType = "[[Bool]]";
					};
				};
			};

			class StateSpecial {
				class Attributes {
					delete allowDamage;
					delete enableRevive;
					delete enableSimulation;
					delete enableStamina;
					delete hideObject;
/*
					class AddToDynSimGrid {
//						delete data;
						data = "";
						displayName = "Wake-Up Dynamic Simulation";
						tooltip = "Controls unit capability to activate dynamically simulated entities.";
						property = "addToDynSimGrid";
						control = "Checkbox";
						expression = "_this triggerDynamicSimulation _value";
						defaultValue = "false";
						condition = "objectBrain";
					};
*/
					class GW_DisableHC {
						displayName = "Disable HC Transfer";
						tooltip = "Disables Auto Transfer Group to Headless Client   (Requires GW Framework)";
						property = "GW_DisableHC";
						control = "Checkbox";
						expression = "(group _this) setVariable ['GW_HeadlessController_BlackList', _value, true]; (group _this) setVariable ['acex_headless_blacklist', _value, true];";
						defaultValue = "false";
						condition = "objectBrain";
					};
					class GW_DisableGearInit {
						displayName = "Disable Auto Gear";
						tooltip = "Disables Auto Gear Select for Group (Requires GW Framework)";
						property = "GW_DisableGearInit";
						control = "Checkbox";
						expression = "_this setVariable ['GW_Gear_BlackList', _value, false];";
						defaultValue = "false";
						condition = "objectBrain";
					};
					class GW_DisableSkill {
						displayName = "Disable Auto Skill";
						tooltip = "Disables Auto setSkill (Requires GW Framework)";
						property = "GW_DisableSkill";
						control = "Checkbox";
						expression = "_this setVariable ['GW_SetDifficulty_BlackList', _value, false];";
						defaultValue = "false";
						condition = "objectBrain";
					};
					class GW_LoadoutSelector {
						displayName = "Loadout Selector";
						tooltip = "Force a unit to be a specific role, This by passes the 'Auto Gear' (Requires GW Framework)";
						property = "GW_LoadoutSelector";
						control = "GW_SelectLoadout";
						expression = "_this setVariable ['GW_Gear_Loadout', _value, true];";
						condition = "objectBrain";
					};
				};
			};
		};
	};

	class EventHandlers {
		class GW {
			OnMessage = QUOTE(call FUNC(addEH_onMessage));
			onMissionLoad = QUOTE(call FUNC(addEH_onMessage));
			onMissionNew = QUOTE(call FUNC(addEH_onMessage));
			onMissionPreviewEnd = QUOTE(call FUNC(addEH_onMessage));
			onTerrainNew = QUOTE(call FUNC(addEH_onMessage));
		};
	};

	class Tutorials {
		class GW_Help_Editing {
			displayName = "GW Framework";
			class Sections {
				class GW_Help_firstTime {
					displayName = "First Time Setup";
					class Steps {
						class GW_Help_firstTime_1 {
							text = "First Time Setup: <br/>New Framework, New Copy functions. As of 0.9.0 - September 2019 you have the option to select version from the 'Preferences'";
						};
						class GW_Help_firstTime_2 {
							text = "The version you select is only used when no framework is found in mission folder. Otherwise it will automaticly use the correct version";
						};
					};
				};
				class GW_Help_doActions {
					displayName = "Do Actions";
					class Steps {
						class GW_Help_doActions_SelectPosition {
							text = "Advanced Actions: <br/>Some actions may sometimes require a location and they are highlighted with a ""*"" in the end of its action";
						};
						class GW_Help_doActions_SelectPosition_2 {
							text = "Step 1: <br/>To mark the location simply right click to open a menu and it will automaticly store its position in the memory";
						};
						class GW_Help_doActions_SelectPosition_3 {
							text = "Step 2: <br/>Select the advanced action that you desire";
						};
					};
				};
				class GW_Help_Composition {
					displayName = "Create A Composition";
					class Steps {
						class GW_Help_Composition_1 {
							text = "Step 1: <br/>Select the objects you want to be copied";
						};
						class GW_Help_Composition_2 {
							text = "Step 2: <br/>All objects will be copied from the location of where the player is located";
						};
						class GW_Help_Composition_3 {
							text = "Step 3: <br/>Copy the composition from GW Tools and store it in a external text document and then later it can be added to the addon";
						};
					};
				};
			};
		};
	};
};
