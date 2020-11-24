#include "script_Component.hpp"
#define	SETTING(Var1)	getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> Var1)

private _output = [];
private _approved = 0;
private _warning = 1;
private _error = 2;

if !(isClass(missionconfigfile >> "GW_Modules" >> "Settings_ACE")) then {
	if (!("GW_MissionPreferences" get3DENMissionAttribute "GW_isConfigured") || (({((_x get3DENAttribute "ControlMP") select 0) || ((_x get3DENAttribute "ControlSP") select 0)} count ((all3DENEntities select 0) + (all3DENEntities select 3))) < ("Multiplayer" get3DENMissionAttribute "MaxPlayers"))) then {
		_output pushBack [_error, "Mission configuration issues", "This sould be a one time thing that set does a few background settings", [6], "First time configure", "Configure >"];
	} else {
		_output pushBack [_approved,"First Time setup Complete"];
	};

	if (GVARMAIN(mod_ACE3) && !("GW_MissionPreferences" get3DENMissionAttribute "GW_isConfigured_ACE")) then {
		_output pushBack [_error, "Auto Configure - ACE", "This sould be a one time thing that set does a few background settings", [6], "First time configure", "Configure >"];
	} else {
		_output pushBack [_approved,"Auto Configure Complete - ACE"];
	};
};

if !((str missionConfigFile) isEqualTo "") then {
	_arr = (toArray (str missionConfigFile));
	_arr resize (count _arr - 15);
	_list = ((toString _arr) splitString "\");
	if ((((toLower(_list select ((count _list) - 1))) find "gw") isEqualTo 0)) then {
		_output pushBack [_error, "Mission Folder Name Invalid", "", [5], "Opens Description.ext", "Folder >"];
	};
};

if (isClass(missionConfigFile >> "GW_FRAMEWORK")) then {
	if (toUpper(SETTING("GameMode")) isEqualTo "GW") then {
		_output pushBack [_error, "GameMode Invalid", "If this is not fixed it will be harder to find it, Make sure you edit this in the description.ext", [5], "Opens Description.ext", "Folder >"];
	} else {
		_output pushBack [_approved,"GameMode"];
	};

	if !((toLower(getText(missionConfigFile >> "briefingName")) find "framework") isEqualTo -1) then {
		_output pushBack [_error,"Mission has no name or is named framework", "Without a name you cant select the mission! Make sure you edit this in the description.ext", [5], "Opens Description.ext", "Folder >"];
	} else {
		_output pushBack [_approved,"Name Okay"];
	};

	if (((SETTING("Author")) isEqualTo "") || (toLower(SETTING("Author")) isEqualTo "guzzenvonlidl")) then {
		_output pushBack [_error,"Author not configured", "Make sure you edit this in the description.ext", [5], "Opens Description.ext", "Folder >"];
	} else {
		_output pushBack [_approved,"Author Configured"];
	};

	if (((SETTING("Picture")) isEqualTo "") || ((SETTING("Picture")) isEqualTo "\x\gw\addons\3den\data\Logo_GOL_1.paa")) then {
		_output pushBack [_warning,"No Picture Found or default loaded", "Make sure you edit this in the description.ext", [5], "Opens Description.ext", "Folder >"];
	} else {
		_output pushBack [_approved,"Usage Of Picture"];
	};

	if ((count (getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "AuthorUID") - ["_SP_PLAYER_"])) isEqualTo 0) then {
		_output pushBack [_warning,"No Admins Configured", "Info about this on GW-Framework Wiki", [5], "Opens Description.ext", "Folder >"];
	} else {
		_output pushBack [_approved,format ["Admins Configured: %1", (count (getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "AuthorUID") - ["_SP_PLAYER_"]))]];
	};

	_required = (missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "requireAddonVersion");
	if (((getNumber(configfile >> "CfgPatches" >> "GW_Main" >> "Version")) < (getNumber _required)) && !(isNull _required)) then {
		_output pushBack [_error,"Framework requires a newer version of @GW Addon to properly function", "", [-1]];
	};

	if (isNull _required) then {
		_output pushBack [_warning,"You are using a legacy version of GW-Framework", "Use latest version or things might not work as intended", [-1]];
	};

	if ((getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "legacyRespawn")) isEqualTo 1) then {
		_output pushBack [_warning,"Legacy Respawn Mode is Active", "Respawn at Logic is not being used, Will revert back to marker if found", [-1]];
	};
} else {
	_output pushBack [_error,"NO Framework detected in mission", "", [-1]];
};

_folderName = (missionName splitString "@");
if ((count _folderName) >= 2) then {
	if ((_folderName select 0) == "GW") then {
		_output pushBack [_error,"Mission Folder > is not named correctly", "Change the GW to game type!", [5], "Opens Description.ext", "Folder >"];
	};
};

_output
