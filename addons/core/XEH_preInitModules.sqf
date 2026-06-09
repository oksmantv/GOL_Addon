
LOG("Prepping modules");
#define CORE_Modules (missionConfigFile >> "gw_Modules")
private ["_Modules","_postLoad"];
_Modules = [];
GVARMAIN(logModules) = [];
GVARMAIN(postLoad) = [];
GVARMAIN(settingsLoad) = [];

LOG(FORMAT_1("Mission module definitions found: %1", (count CORE_Modules)));
if ((count CORE_Modules) isEqualTo 0) then {
	ERROR("No gw_Modules entries found in mission Description.ext");
};

for "_i" from 0 to ((count CORE_Modules) - 1) step 1 do {
	_Modules pushBack (CORE_Modules select _i);
};

{
	private ["_config","_Name","_Authors","_Version","_preInit","_postInit","_Description","_requiredModules"];
	_config = (missionConfigFile >> "gw_Modules" >> configName(_x));
	_Name = getText( _config >> "name");
	_Authors = getArray( _config >> "authors");
	_Version = getNumber( _config >> "version");
	_preInit = getText( _config >> "preInit");
	_postInit = getText( _config >> "postInit");
	_Description = getText( _config >> "description");
	_requiredModules = getArray( _config >> "requiredModules");
	_requiredAddon = getArray( _config >> "requiredAddon");
	_hasSetting = getNumber( _config >> "hasSettings");

	// FW4: modules may declare a root-level folder instead of living under Modules\
	private _folder = getText( _config >> "folder");
	private _moduleRoot = if (_folder isEqualTo "") then { "Modules\" + configName(_x) + "\" } else { _folder + "\" };

	diag_log format ["[GW][Modules] START %1", configName(_x)];
	LOG(FORMAT_4("Module defined: %1 | preInit=%2 | postInit=%3 | folder=%4", configName(_x), _preInit, _postInit, _moduleRoot));

	{
		if !(isClass ((missionConfigFile >> "GW_Modules" >> _x))) then {
			_preInit = "";
			_postInit = "";
			ERROR(FORMAT_2("Warning! %1 is Missing Module: %2",_Name, _x));
		};
	} forEach _requiredModules;

	{
		if !(isClass (configFile >> "CfgPatches" >> _x)) then {
			_preInit = "";
			_postInit = "";
			ERROR(FORMAT_2("Warning! %1 is Missing Addon: %2",_Name, _x));
		};
	} forEach _requiredAddon;

	if !(_preInit isEqualTo "") then {
		diag_log format ["[GW][Modules] PreInit executing: %1%2", _moduleRoot, _preInit];
		[] call compile preprocessFileLineNumbers (_moduleRoot + _preInit);
		diag_log format ["[GW][Modules] PreInit complete: %1", configName(_x)];
	};

	if !(_postInit isEqualTo "") then {
		if (fileExists (_moduleRoot + _postInit)) then {
			diag_log format ["[GW][Modules] PostInit queued: %1%2", _moduleRoot, _postInit];
			GVARMAIN(postLoad) pushback [configName(_x), _postInit, _moduleRoot];
		} else {
			diag_log format ["[GW][Modules] PostInit missing; skipping queue: %1%2", _moduleRoot, _postInit];
		};
	};

	if ((count _Authors) isEqualTo 1) then {
		_Authors = format ["%1", (_Authors select 0)];
	} else {
		private _str = "";
		{
			if (_forEachIndex isEqualTo 0) then {
				_str = format ["%1", _x];
			} else {
				_str = (_str + (format [", %1", _x]));
			};
		} forEach _Authors;
		_Authors = _str;
	};

	if (_hasSetting isEqualTo 1) then {
		diag_log format ["[GW][Modules] Settings queued: %1cba_settings.sqf", _moduleRoot];
		GVARMAIN(settingsLoad) pushback (preprocessFile (_moduleRoot + "cba_settings.sqf"));
	};

	GVARMAIN(logModules) pushback [_Name, _Authors, _Version, _Description];
	TRACE_3("Module Loaded", _Name, _Authors, _Version);
} forEach _Modules;

// FW4: Gear module lives at mission root — call preInit directly if present
if (fileExists "Gear\preInit.sqf") then {
	diag_log "[GW][Modules] FW4 Gear\preInit.sqf detected and running";
	[] call compile preprocessFileLineNumbers "Gear\preInit.sqf";
	if (fileExists "Gear\postInit.sqf") then {
		GVARMAIN(postLoad) pushBack ["Gear_FW4", "postInit.sqf", "Gear\"];
	} else {
		diag_log "[GW][Modules] FW4 Gear\postInit.sqf not found; skipping postInit queue";
	};
};

LOG(FORMAT_1("Modules Loaded: %1", (count GVARMAIN(logModules))));
diag_log format ["[GW][Modules] Loaded entries: %1", (count GVARMAIN(logModules))];

"CBA_settings_refreshAllSettings" call CBA_fnc_localEvent;

if (is3DEN) then {
	if (FILE_EXISTS("spawnList.sqf")) then {
		LOG("SpawnList Loaded");
		PREPMISSIONFOLDER(spawnList);
	} else {
		LOG("SpawnList FAILED");
		["Framework is corupt                           Missing file spawnList.sqf","WARNING"] spawn BIS_fnc_3DENShowMessage;
	};

	if (FILE_EXISTS("Custom_Init.sqf")) then {
		LOG("Custom Init Started");
		[] call (compile preprocessFileLineNumbers "Custom_Init.sqf");
	} else {
		LOG("Custom Init FAILED");
		["Framework is corupt                           Missing file Custom_Init.sqf","WARNING"] spawn BIS_fnc_3DENShowMessage;
	};
} else {	// Assume problem is fixed when its play/testing time
	PREPMISSIONFOLDER(spawnList);
	LOG("SpawnList Loaded");

	[] call (compile preprocessFileLineNumbers "Custom_Init.sqf");
	LOG("Custom Init Started");
};
