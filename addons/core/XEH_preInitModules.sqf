
LOG("Prepping modules");
#define CORE_Modules (missionConfigFile >> "gw_Modules")
private ["_Modules","_postLoad"];
_Modules = [];
GVARMAIN(logModules) = [];
GVARMAIN(postLoad) = [];
GVARMAIN(settingsLoad) = [];

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
		[] call compile preprocessFileLineNumbers ("Modules\" + configName(_x) + "\" + _preInit);
	};

	if !(_postInit isEqualTo "") then {
		GVARMAIN(postLoad) pushback [configName(_x), _postInit];
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
		GVARMAIN(settingsLoad) pushback (preprocessFile ("Modules\" + configName(_x) + "\cba_settings.sqf"));
	};

	GVARMAIN(logModules) pushback [_Name, _Authors, _Version, _Description];
	TRACE_3("Module Loaded", _Name, _Authors, _Version);
} forEach _Modules;

LOG(FORMAT_1("Modules Loaded: %1", (count GVARMAIN(logModules))));

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
