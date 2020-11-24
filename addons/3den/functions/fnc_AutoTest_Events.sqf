#include "script_Component.hpp"

params ["_control", ["_index", -1]];

if ((_index >= (count GVAR(AutoTestEvents))) || ((_control lbText _index) isEqualTo "")) exitWith {
	_control lbSetCurSel -1;
	false
};

(GVAR(AutoTestEvents) select _index) params [["_event", -1], ["_var", ""]];

switch (_event) do {
	case 1: {
		["Event: Mission Binarize", 0, 2, true] call BIS_fnc_3DENNotification;
		edit3DENMissionAttributes "Scenario";
	};
	case 2: {
		["Event: Time of day", 0, 2, true] call BIS_fnc_3DENNotification;
		edit3DENMissionAttributes "Intel";
	};
	case 3: {
		["Event: Move To Marker", 0, 2, true] call BIS_fnc_3DENNotification;
		collect3DENHistory {
			_pos = ((_var get3DENAttribute "position") select 0);
			move3DENCamera [[(_pos select 0), (_pos select 1), 10], true];
			if ((get3DENActionState "ToggleMap") isEqualTo 0) then {
				do3DENAction "ToggleMap";
			};
		};
	};
	case 4: {
		["Event: Focus on Object", 0, 2, true] call BIS_fnc_3DENNotification;
		_pos = ((_var get3DENAttribute "position") select 0);
		move3DENCamera [[(_pos select 0), (_pos select 1), (_pos select 2) + 5], true];
	};
	case 5: {
		do3DENAction "FolderMission";
	};
	case 6: {
		"GW_MissionPreferences" set3DENMissionAttribute ["GW_isConfigured", false];
		[] spawn {
			[] call FUNC(setFramework);
			sleep 0.1;
			edit3DENMissionAttributes 'GW_MissionPreferences';
		};
	};
	case 7: {
		_pos = (screenToWorld [0.5,0.5]);
		if ((_pos distance get3DENCamera) < 300) then {
			_logic = create3DENEntity ["Logic", "LocationRespawnPoint_F", (screenToWorld [0.5,0.5])];
			_logic set3DENAttribute ["init","this setVariable [""GW_isRespawnPos"", ""west"", true];"];
			edit3DENMissionAttributes 'GW_MissionPreferences';
		} else {
			["No Posible position found, Move camera and try again", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};
	case 8: {
		_pos = (screenToWorld [0.5,0.5]);
		if ((_pos distance get3DENCamera) < 300) then {
			_logic = create3DENEntity ["Logic", "LocationRespawnPoint_F", (screenToWorld [0.5,0.5])];
			_logic set3DENAttribute ["init","this setVariable [""GW_isRespawnPos"", ""east"", true];"];
			edit3DENMissionAttributes 'GW_MissionPreferences';
		} else {
			["No Posible position found, Move camera and try again", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};
	case 9: {
		_pos = (screenToWorld [0.5,0.5]);
		if ((_pos distance get3DENCamera) < 300) then {
			_logic = create3DENEntity ["Logic", "LocationRespawnPoint_F", (screenToWorld [0.5,0.5])];
			_logic set3DENAttribute ["init","this setVariable [""GW_isRespawnPos"", ""independent"", true];"];
			edit3DENMissionAttributes 'GW_MissionPreferences';
		} else {
			["No Posible position found, Move camera and try again", 1, 10, true] call BIS_fnc_3DENNotification;
		};
	};
};
