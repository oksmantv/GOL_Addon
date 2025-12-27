#include "script_component.hpp"


#include "XEH_PREP.sqf"

if !(is3DEN) exitWith {false};
clearRadio;

// Default per-session marker options.
if (isNil { uiNamespace getVariable "GW_FRAMEWORK_MARKER_ADD_FLAG" }) then {
	uiNamespace setVariable ["GW_FRAMEWORK_MARKER_ADD_FLAG", false];
};

// Default the per-session "Global Side" selector from GW Common's configured AI spawn side (if present).
// Falls back to EAST if the setting is unavailable.
if (isNil { uiNamespace getVariable "GW_FRAMEWORK_GLOBAL_SIDE" }) then {
	private _enemySideSetting = "";
	private _src = "";

	// Preferred: pull from CBA settings system (addon options)
	private _cbaGetterName = "CBA" + "_settings_fnc_get";
	private _cbaGet = missionNamespace getVariable [_cbaGetterName, objNull];
	if (_cbaGet isEqualType {}) then {
		private _vCBA = ["GW_Common_Faction"] call _cbaGet;
		if (_vCBA isEqualType "") then {
			_enemySideSetting = _vCBA;
			_src = "missionNamespace." + _cbaGetterName;
		};
	};

	// Canonical (CBA) setting name in GW: GW_Common_Faction
	if (_enemySideSetting isEqualTo "") then {
		private _v2 = missionNamespace getVariable ["GW_Common_Faction", ""];
		if (_v2 isEqualType "") then {
			_enemySideSetting = _v2;
			_src = "missionNamespace.GW_Common_Faction";
		};
	};

	// Backwards compatibility fallback
	if (_enemySideSetting isEqualTo "") then {
		private _v1 = missionNamespace getVariable ["gw_common_faction", ""];
		if (_v1 isEqualType "") then {
			_enemySideSetting = _v1;
			_src = "missionNamespace.gw_common_faction";
		};
	};

	private _k = toUpper _enemySideSetting;
	private _defaultGlobal = switch (_k) do {
		case "WEST": { "WEST" };
		case "EAST": { "EAST" };
		case "INDEPENDENT": { "INDEPENDENT" };
		case "GUER": { "INDEPENDENT" };
		default { "EAST" };
	};

	uiNamespace setVariable ["GW_FRAMEWORK_GLOBAL_SIDE", _defaultGlobal];
	diag_log format ["[GW][3DEN][GlobalSide] default set | src=%1 value=%2 => GW_FRAMEWORK_GLOBAL_SIDE=%3", _src, _enemySideSetting, _defaultGlobal];
};

// Auto-renumber pasted OKS Frontline Node logics so copy/paste creates next nodes.
add3DENEventHandler ["OnPaste", {
	private _dbg = uiNamespace getVariable ["OKS_3DEN_DEBUG_FRONTLINE", true];
	if (_dbg) then { diag_log format ["[GW][3DEN][FrontlineNodes][OnPaste] fired | this=%1", _this]; };
	if (!isNil "OKS_fnc_EdenFrontlineNodeOnPasteRenumber") then {
		if (_dbg) then { diag_log "[GW][3DEN][FrontlineNodes][OnPaste] calling OKS_fnc_EdenFrontlineNodeOnPasteRenumber"; };
		_this call OKS_fnc_EdenFrontlineNodeOnPasteRenumber;
	} else {
		if (_dbg) then { diag_log "[GW][3DEN][FrontlineNodes][OnPaste] OKS_fnc_EdenFrontlineNodeOnPasteRenumber is NIL"; };
	};
}];

GVAR(AutoTestEvents) = [];
GVAR(ExportErrorCount) = 0;
GVAR(hiddenTriggers) = [];
GVAR(MHQ_Object) = objNull;

1 call FUNC(doActionMisc);
'init' call bis_fnc_3DENStatusBar;

if ("Preferences" get3DENMissionAttribute "Binarize") then {
	("Preferences" set3DENMissionAttribute ["Binarize", false]);
};

/*
[] spawn {
	disableSerialization;
	uiSleep 0.5;
	_tutorial = ((findDisplay 313) createDisplay "Display3DENTutorial");
};
*/

addMissionEventHandler ["Draw3D", {
	if ("Preferences" get3DENMissionAttribute "GW_Show3DMessage") then {
		//	Hide Object Triggers
		_allLayers = ((all3DENEntities select 6) select {((_x get3DENAttribute "name") select 0) isEqualTo "Triggers (Hide)"});
		{
			_trigger = _x;
			{
				if (_trigger in (get3DENLayerEntities _x)) then {
					_size = linearConversion [75, 500, (get3DENCamera distance _trigger), 0.041, 0.044, true];
					drawIcon3D ["", [1,0,0,1], _trigger, 0, 0, 0, "Logic: HideTerrainTrigger", 1, _size, "PuristaMedium"];
				};
			} forEach (_allLayers select {(((_x get3DENAttribute "Visibility") select 0) && ((_x get3DENAttribute "Transformation") select 0))});
		} forEach (GVAR(hiddenTriggers) select {((get3DENCamera distance _x) < 300)});


		//	Respawn Objects
		{
			_x params ["_object"];
			_init = (toLower((_object get3DENAttribute "init") select 0));
			_strArr = (_init splitString "[],");
			_index = ((_strArr find """gw_isrespawnpos""") + 1);
			_sideArr = ((_strArr select _index) splitString """");
			_alpha = linearConversion [250, 150, (get3DENCamera distance _object), 0, 1, true];
			{
				if (_x isEqualTo "east") then {
					drawIcon3D ["", [1,0,0,_alpha], _object, 0, -3, 0, "Respawn: Opfor", 1, 0.043, "PuristaMedium"];
				};

				if (_x isEqualTo "west") then {
					drawIcon3D ["", [0,0,1,_alpha], _object, 0, -3, 0, "Respawn: Blufor", 1, 0.043, "PuristaMedium"];
				};

				if (_x isEqualTo "independent") then {
					drawIcon3D ["", [0,1,0,_alpha], _object, 0, -3, 0, "Respawn: Independent", 1, 0.043, "PuristaMedium"];
				};
			} forEach _sideArr;
		} forEach (((all3DENEntities select 3) select {((typeOf _x) isEqualTo "LocationRespawnPoint_F")}) select {((get3DENCamera distance _x) < 250)});
	};
}];

{	// On Load
	_radius = ((_x get3DENAttribute "size3") select 0);
	_objects = (nearestTerrainObjects [_x, HIDEOBJECTFILTER, (selectMax _radius), false]);

	{
		if !(isObjectHidden _x) then {
			_x hideObjectGlobal true;
		};
	} forEach (_objects inAreaArray _x);
} forEach ((all3DENEntities select 2) select {(((_x get3DENAttribute "text") select 0) isEqualTo "HideTrigger")});

[] spawn {
	while {is3DEN} do {
		for "_i" from 0 to 9 step 1 do {
			[] call FUNC(showStats);
			uiSleep 0.1;
		};
		{
			[_x] spawn FUNC(perFrame);
			GVAR(hiddenTriggers) pushBackUnique _x;
		} forEach ((all3DENEntities select 2) select {(((_x get3DENAttribute "text") select 0) isEqualTo "HideTrigger") && !(_x in GVAR(hiddenTriggers))});
	};
};
