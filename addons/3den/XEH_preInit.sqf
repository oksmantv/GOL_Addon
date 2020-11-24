#include "script_component.hpp"


#include "XEH_PREP.sqf"

if !(is3DEN) exitWith {false};
clearRadio;

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
