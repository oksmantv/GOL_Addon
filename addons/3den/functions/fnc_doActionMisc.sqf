#include "script_component.hpp"
/*
	AUTHOR: GuzzenVonLidl

	Usage:
	[] call GW_3DEN_fnc_doActionMisc

	Parameters: None

	Return Value: No

	Public: NO
*/
#include "\a3\3DEN\UI\resincl.inc"

params ["_case", ["_value", 0]];
private _editorObject = ((get3DENSelected "object") select 0);

[(str _this),QFUNC(doActionMisc)] call FUNC(uiSaveFunction);

switch (_case) do {

	case 0: {
		if ((get3DENActionState "ToggleMap") isEqualTo 1) then {
			do3DENAction "ToggleMapIDs";
		} else {
			if ((get3DENActionState "ToggleMap") isEqualTo 0) then {
				(finddisplay IDD_DISPLAY3DEN displayctrl 10307) cbsetchecked ((get3DENActionState "ToggleMapIDs") isEqualTo 1);
			};
			["Map needs to be open to take effect", 1, 2, true] call BIS_fnc_3DENNotification;
		};
	};

	case 1: {	// Reset Toggle
		{
			if ((get3DENActionState _x) isEqualTo 1) then {
				do3DENAction _x;
			};
		} forEach ["MoveGridToggle","RotateGridToggle","ScaleGridToggle"];
	};

	case 2: {
		[] call BIS_fnc_diagFindMissingAuthors;
		["Export Missing Authors", 0, 10, true] call BIS_fnc_3DENNotification;
	};

	case 3: {
		[true] call BIS_fnc_diagMissionWeapons;
		["Export Weapons and Magazines used in mission", 0, 10, true] call BIS_fnc_3DENNotification;
	};

	default {
		systemChat "Error: No Action Found";
		["",QFUNC(doActionMisc)] call FUNC(uiSaveFunction);
	};
};

true
