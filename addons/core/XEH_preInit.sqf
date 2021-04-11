#include "script_component.hpp"
#include "XEH_PREP.sqf"

LOG("Prepping all main variables");
// Get addon/mod/dlc availability from the A3 config file and store them in easy to use variables
GVARMAIN(DLC_Bundle) 		= (isDLCAvailable 304400);
GVARMAIN(DLC_Heli) 			= (isDLCAvailable 304380);
GVARMAIN(DLC_Apex)	 		= (isDLCAvailable 395180);
GVARMAIN(DLC_Jets)	 		= (isDLCAvailable 601670);
GVARMAIN(DLC_Tanks) 		= (isDLCAvailable 798390);
//GVARMAIN(DLC_GM) 			= (isDLCAvailable 1042220);		//	Arma 3 Creator DLC: Global Mobilization - Cold War Germany
GVARMAIN(DLC_Contact) 		= (isDLCAvailable 1021790);

GVARMAIN(mod_ACE3) 			= isClass (configFile >> "CfgPatches" >> "ACE_Common");
GVARMAIN(mod_ACE3_Medical)	= isClass (configFile >> "CfgPatches" >> "ACE_Medical");
GVARMAIN(mod_ACE3_Med_New)	= isClass (configFile >> "CfgPatches" >> "ACE_medical_engine");
GVARMAIN(mod_ACRE) 			= isClass (configFile >> "CfgPatches" >> "ACRE_Main");
GVARMAIN(mod_AIA)	 		= isClass (configFile >> "CfgPatches" >> "AiA_Core");
GVARMAIN(mod_GW)			= isClass (configFile >> "CfgPatches" >> "GW_Main");
GVARMAIN(mod_CUP_TERRAINS)	= isClass (configFile >> "CfgPatches" >> "CUP_BaseConfigs");
GVARMAIN(mod_CUP_WEAPONS)	= isClass (configFile >> "CfgPatches" >> "CUP_BaseConfig_F");
GVARMAIN(mod_CUP_VEHICLES)	= isClass (configFile >> "CfgPatches" >> "CUP_TrackedVehicles_Core");
GVARMAIN(mod_CBA) 			= isClass (configFile >> "CfgPatches" >> "CBA_Main");
GVARMAIN(mod_CTAB) 			= isClass (configFile >> "CfgPatches" >> "cTab");
GVARMAIN(mod_RHS)	 		= isClass (configFile >> "CfgPatches" >> "rhsusf_main");
GVARMAIN(mod_TFAR) 			= isClass (configFile >> "CfgPatches" >> "Task_Force_Radio");
GVARMAIN(mod_TFAR_CORE) 	= isClass (configFile >> "CfgPatches" >> "TFAR_Core");

enableSaving [false, false];

if (isServer) then {
	private _LogicCenter = createCenter sideLogic;
	private _moduleGroup = createGroup _LogicCenter;

	GVARMAIN(Gamelogic) = true call CBA_fnc_createNamespace;
	publicVariable QGVARMAIN(Gamelogic);

	GVARMAIN(ZeuzModuleAdminLogged) = _moduleGroup createUnit ["ModuleCurator_F",[0,0,1000],[],0,"CAN_COLLIDE"];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Owner", "#adminLogged", true];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Name", "AdminZeusLogged", true];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Addons", 3, true];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Forced", 0, true];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["birdType", "", true];
	GVARMAIN(ZeuzModuleAdminLogged) setVariable ["showNotification", false, true];
	GVARMAIN(ZeuzModuleAdminLogged) setCuratorWaypointCost 0;
	{
		GVARMAIN(ZeuzModuleAdminLogged) setCuratorCoef [_x,0];
	} forEach ["place","edit","delete","destroy","group","synchronize"];

	publicVariable QGVARMAIN(ZeuzModuleAdminLogged);
};

if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};

if (VERSION >= 0.8) then {
	#include "XEH_preInitModules.sqf"
};
