#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_doAction

	Parameters: None

	Return Value: No

	Public: NO
*/

params ["_case","_value"];

[(str _this),QFUNC(doAction)] call FUNC(uiSaveFunction);

switch (_case) do {

	case 0: { // Get relative location of obj 2 from obj 1
		if (count (get3DENSelected "object") isEqualTo 2) then {
			_editorObject = (get3DENSelected "object");
			_type = (_editorObject select 0) worldToModel (position (_editorObject select 0));

			["Position copied relative from 1st Selected", 0, 5, true] call BIS_fnc_3DENNotification;
			copyToClipboard str _type;
		} else {
			["Selection error, Make sure you only select 2 Objects!", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};

	case 1: {
		if (isNull GVAR(MHQ_Object)) then {
			if !(count (get3DENSelected "object") isEqualTo 1) then {
				["Invalid amount of objects selected, Only select 1 and try again", 1, 15, true] call BIS_fnc_3DENNotification;
			} else {
				["First object copied as a reference", 0, 5, true] call BIS_fnc_3DENNotification;
				GVAR(MHQ_Object) = ((get3DENSelected "object") select 0);
			};
		} else {
			private _CopyObjects = [];
			if (count (get3DENSelected "object") isEqualTo 0) then {
				["No objects selected", 1, 10, true] call BIS_fnc_3DENNotification;
			} else {
				{
					if (!(_x isKindOf "CAManBase") && !(_x isEqualTo GVAR(MHQ_Object))) then {	// Exclude Center Object
						_pos = GVAR(MHQ_Object) worldToModel (position _x);
						_CopyObjects pushBack [(typeOf _x), round(getDir _x), _pos];
					};
				} forEach (get3DENSelected "object");

			//	copyToClipboard str(_CopyObjects);
				copyToClipboard (("_return = ") + str(_CopyObjects) + (";"));

				[format ["%1 Objects copied relative to First Object", (count _CopyObjects)], 0, 5, true] call BIS_fnc_3DENNotification;
				_CopyObjects
			};
		};
	};

	case 2: {
		if (count (get3DENSelected "object") > 0) then {
			["Unit added to Projectile Tracker", 0, 5, true] call BIS_fnc_3DENNotification;
			collect3DENHistory {
				{
					if (_x isKindOf "CAManBase") then {
						_initCurrent = ((_x get3DENAttribute "init") select 0);
	//					_initAdd = "[this] call BIS_fnc_diagBulletCam;";
						_initAdd = "[this] call CBA_fnc_addUnitTrackProjectiles;";
						_x set3DENAttribute ["init", _initCurrent + _initAdd];
					};
				} forEach (get3DENSelected "object");
			};
		} else {
			["No Units Selected", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};

	case 3: {
		("Preferences" set3DENMissionAttribute ["GW_PatternOffset", _value]);
	};

	case 4: {
		if ((({(((_x get3DENAttribute "text") select 0) isEqualTo "HideTrigger")} count (all3DENEntities select 2)) isEqualTo 0) && ("Preferences" get3DENMissionAttribute "GW_ShowMessage")) then {
			_text = "No previus 'HideTerrainTrigger' found, Move, Rotate and Scale the trigger infront of you as it desired and change the condition if required, NOTE: Overlap triggers can cause unexpected results";
			[_text, 0, 15, true] call BIS_fnc_3DENNotification;
		};
		_pos = (screenToWorld [0.5,0.5]);
		if ((_pos distance get3DENCamera) < 300) then {
			_tool = create3DENEntity ["Trigger","EmptyDetector", _pos];
			_tool set3DENAttribute ["IsRectangle","Ellipse"];
			_tool set3DENAttribute ["size3",[5,5,5]];
	//		_tool set3DENAttribute ["name", QGVAR(Logic_HideObjects)];
			_tool set3DENAttribute ["text", "HideTrigger"];
			_tool set3DENAttribute ["Condition","true"];
			_tool set3DENAttribute ["isServerOnly",true];
			_tool set3DENAttribute ["onActivation","[thisTrigger, true, []] call GW_Common_fnc_setHideTerrainObjects"];
			[_tool] spawn FUNC(perFrame);

			_layer = ((all3DENEntities select 6) select {((_x get3DENAttribute "name") select 0) isEqualTo "Triggers (Hide)"});
			if (_layer isEqualTo []) then {
				_layer = [(-1 add3DENLayer "Triggers (Hide)")];
			};
			_tool set3DENLayer (_layer select 0);
		} else {
			["No Posible position found, Move camera and try again", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};

	case 5: {
		[getpos (selectRandom(get3DENSelected "object"))] call FUNC(setUnitGarrison);
	};

	case 6: {	//	MissionExportMP
		edit3DENMissionAttributes 'GW_MissionPreferences';
		["Mission Exported: Errors needs to be fixed before uploading this mission", 1, 5, true] call BIS_fnc_3DENNotification;
		if (GVAR(ExportErrorCount) isEqualTo 0) then {
			do3DENAction "MissionExportMP";
		};
	};

	default {
		systemChat "Error: No Action Found";
		["",QFUNC(doAction)] call FUNC(uiSaveFunction);
	};
};

true
