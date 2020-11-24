#include "script_Component.hpp"

private _output = [];
private _approved = 0;
private _warning = 1;
private _error = 2;
private _legacyVersion = ((getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version")) < 0.8);

if (call EFUNC(Common,isDevBuild)) then {
	_output pushBack [_warning,"Debug mode is enabled", "", [-1]];
};

if ("Scenario" get3DENMissionAttribute "SaveBinarized") then {
	_output pushBack [_warning, "Mission is set to Binarized, please make sure this is the final export", "", [1], "General Attributes"];
};

if (("Intel" get3DENMissionAttribute "IntelTime") isEqualTo 12) then {
	_output pushBack [_warning, "Please consider changing the time of day, Currently set to 12:00", "Please also consider changin the weather from default", [2], "Environment Attributes"];
};

/*
if ((west getFriend independent) isEqualTo 1) then {
	_output pushBack [_warning,"Independent is friendly to BLUFOR", "", [1], "General Attributes"];
};
if ((east getFriend independent) isEqualTo 1) then {
	_output pushBack [_warning,"Independent is friendly to OPFOR", "", [1], "General Attributes"];
};
*/

_allPlayable = ((all3DENEntities select 0) select {((_x get3DENAttribute "ControlMP") select 0) || ((_x get3DENAttribute "ControlSP") select 0)});
_west = (_allPlayable select {(side _x) isEqualTo blufor});
_east = (_allPlayable select {(side _x) isEqualTo opfor});
_indep = (_allPlayable select {(side _x) isEqualTo independent});

if (_legacyVersion) then {
	if !((count _west) isEqualTo 0) then {
		_respawn = ((all3DENEntities select 5) select {!((_x find "respawn_west") isEqualTo -1)});
		if ((count _respawn) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn marker found for BLUFOR", "If this is not fixed BLUFOR can not respawn!, Either consider adding the marker or removing any playable units on this side", [-1]];
		} else {
			if ((count _respawn) > 1) then {
				_output pushBack [_warning, "Multiple Respawn markers found for BLUFOR", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_west select 0);
				_distance = (_unit distance2D (((_respawn select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["BLUFOR Respawn marker is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawn select 0)], "Move To .."];
				};
			};
		};
	};

	if !((count _east) isEqualTo 0) then {
		_respawn = ((all3DENEntities select 5) select {!((_x find "respawn_east") isEqualTo -1)});
		if ((count _respawn) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn marker found for OPFOR", "If this is not fixed OPFOR can not respawn!, Either consider adding the marker or removing any playable units on this side", [-1]];
		} else {
			if ((count _respawn) > 1) then {
				_output pushBack [_warning, "Multiple Respawn markers found for OPFOR", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_east select 0);
				_distance = (_unit distance2D (((_respawn select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["OPFOR Respawn marker is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawn select 0)], "Move To .."];
				};
			};
		};
	};

	if !((count _indep) isEqualTo 0) then {
		_respawn = ((all3DENEntities select 5) select {!((_x find "respawn_resistance") isEqualTo -1)});
		if ((count _respawn) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn marker found for INDEPENDENT", "If this is not fixed INDEPENDENT can not respawn!, Either consider adding the marker or removing any playable units on this side", [-1]];
		} else {
			if ((count _respawn) > 1) then {
				_output pushBack [_warning, "Multiple Respawn markers found for INDEPENDENT", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_indep select 0);
				_distance = (_unit distance2D (((_respawn select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["INDEPENDENT Respawn marker is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawn select 0)], "Move To .."];
				};
			};
		};
	};
} else {
	_respawneast = [];
	_respawnwest = [];
	_respawnindep = [];

	{
		_x params ["_object"];
		_init = (toLower((_object get3DENAttribute "init") select 0));
		_strArr = (_init splitString "[],");
		_index = ((_strArr find """gw_isrespawnpos""") + 1);
		_sideArr = ((_strArr select _index) splitString """");
		{
			if (_x isEqualTo "east") then {
				_respawneast pushBack _object;
			};
			if (_x isEqualTo "west") then {
				_respawnwest pushBack _object;
			};
			if (_x isEqualTo "independent") then {
				_respawnindep pushBack _object;
			};
		} forEach _sideArr;
	} forEach ((all3DENEntities select 3) select {((typeOf _x) isEqualTo "LocationRespawnPoint_F")});


	if ((count _west) > 0) then {
		if ((count _respawnwest) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn object found for BLUFOR", "If this is not fixed BLUFOR will respawn at starting location", [7]];
		} else {
			if ((count _respawnwest) > 1) then {
				_output pushBack [_warning, "Multiple Respawn objects found for BLUFOR", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_west select 0);
				_distance = (_unit distance2D (((_respawnwest select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["BLUFOR Respawn is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawnwest select 0)], "Move To .."];
				};
			};
		};
	};
	if ((count _east) > 0) then {
		if ((count _respawneast) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn object found for OPFOR", "If this is not fixed OPFOR will respawn at starting location", [8]];
		} else {
			if ((count _respawneast) > 1) then {
				_output pushBack [_warning, "Multiple Respawn objects found for OPFOR", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_east select 0);
				_distance = (_unit distance2D (((_respawneast select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["OPFOR Respawn is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawneast select 0)], "Move To .."];
				};
			};
		};
	};
	if ((count _indep) > 0) then {
		if ((count _respawnindep) isEqualTo 0) then {
			_output pushBack [_error,"No Respawn object found for INDEPENDENT", "If this is not fixed INDEPENDENT will respawn at starting location", [9]];
		} else {
			if ((count _respawnindep) > 1) then {
				_output pushBack [_warning, "Multiple Respawn objects found for INDEPENDENT", "If there is more then one, players will randomly spawn at one of them", [-1]];
			} else {
				_unit = (_indep select 0);
				_distance = (_unit distance2D (((_respawnindep select 0) get3DENAttribute "position") select 0));
				if (_distance >= 100) then {
					_output pushBack [_warning, format ["INDEPENDENT Respawn is %2m from %1.", ((_unit get3DENAttribute "description") select 0), round(_distance)], "", [4, (_respawnindep select 0)], "Move To .."];
				};
			};
		};
	};
};

if (isClass(missionConfigFile >> "GW_Modules" >> "Respawn")) then {
	if !("spectator" in (all3DENEntities select 5)) then {
		_output pushBack [_error,"Spectator marker is missing, Create a new marker and name it 'spectator', place it on land and out of AO", "", [-1]];
	};
};

if (isClass(missionConfigFile >> "GW_Modules" >> "MHQ")) then {
	_MHQs = ((all3DENEntities select 0) select {((((_x get3DENAttribute "name") select 0) find "mhq") isEqualTo 0)});
	_mhqCount = (count _MHQs);
//	_mhqCount = ({!((toLower((_x get3DENAttribute "name") select 0) find "mhq") isEqualTo -1)} count (all3DENEntities select 0));

	if (_mhqCount isEqualTo 0) then {
			_output pushBack [_warning,"No MHQ detected, Make sure this is not a mistake", "", [-1]];
	} else {
		_mhqError = false;
		_output pushBack [_warning,format ["%1 MHQ Vehicle(s) found, Confirm this is by design", _mhqCount], "", [-1]];

		{
			if ((((_x get3DENAttribute "name") select 0) find "mhq") isEqualTo 0) then {
				if !((([configfile >> "CfgVehicles" >> ((_x get3DENAttribute "ItemClass") select 0), true] call BIS_fnc_returnParents) find "Kart_01_Base_F") isEqualTo -1) then {
					_mhqError = true;
					_output pushBack [_error,"MHQ is currently a GO-Kart, Please change this so it wont break immersion", "", [4, _x], "Move To .."];
				};
			};
		} forEach _MHQs;

		if (_mhqError) then {
		};
	};
};

_aiCount = (count (allUnits - playableUnits - switchableUnits - [player]));
if (_aiCount > 100) then {
	if (_aiCount > 150) then {
		_output pushBack [_warning,format["You have placed %1 AI. You may wish to consider the performance impact.",_aiCount], "", [-1]];
	} else {
		_output pushBack [_error,format["%1 Units placed in the senario. You may wish to consider the performance impact.",_aiCount], "", [-1]];
	};
};

{
	if !((toLower((_x get3DENAttribute "onActivation") select 0) find "gw_fnc_spawnlist") isEqualTo -1) then {
		if !(_x get3DENAttribute "isServerOnly" select 0) then {
			_output pushBack [_error,"Spawn Trigger is not set to serverOnly!", "", [4, _x], "Move To .."];
		};
	};
} forEach (all3DENEntities select 2);

if !(((CBA_Settings_mission getVariable ["GW_UI_NameTags", [0,0]]) select 1) isEqualTo 0) then {
	_output pushBack [_error,"GW NameTags is currently forced in mission settings","This is a Client setting, please leave it as so", [-1], ""];
	CBA_Settings_mission setVariable ["GW_UI_NameTags", [((CBA_Settings_mission getVariable "GW_UI_NameTags") select 0),0]];
};

if (GVARMAIN(mod_ACE3)) then {
	if !(((CBA_Settings_mission getVariable ["ace_medical_painEffectType", [0,0]]) select 1) isEqualTo 0) then {
		_output pushBack [_error,"ACE Pain Effect is currently forced in mission settings","This is a Client setting, please leave it as so", [-1], ""];
		CBA_Settings_mission setVariable ["ace_medical_painEffectType", [((CBA_Settings_mission getVariable "ace_medical_painEffectType") select 0),0]];
	};
	if !(((CBA_Settings_mission getVariable ["ace_medical_menuTypeStyle", [0,0]]) select 1) isEqualTo 0) then {
		_output pushBack [_error,"ACE Pain Effect is currently forced in mission settings","This is a Client setting, please leave it as so", [-1], ""];
		CBA_Settings_mission setVariable ["ace_medical_menuTypeStyle", [((CBA_Settings_mission getVariable "ace_medical_painEffectType") select 0),0]];
	};
};

/*
if !(isNil QEGVAR(Common,Faction)) then {
	switch (EGVAR(Common,Faction)) do {
		case "west": {
			if !((count _west) isEqualTo 0) then {
				_output pushBack [_warning,"AI spawn side set to West, West Players Detected", "", [-1]];
			};
		};
		case "east": {
			if !((count _east) isEqualTo 0) then {
				_output pushBack [_warning,"AI spawn side set to East, East Players Detected", "", [-1]];
			};
		};
		case "independent": {
			if !((count _indep) isEqualTo 0) then {
				_output pushBack [_warning,"AI spawn side set to Independent, Independent Players Detected", "", [-1]];
			};
		};
	};
};
*/

_output
