#include "script_component.hpp"
/*
	Creates a server-only Reaction SpawnList trigger at the current 3DEN mouse/map position.
	- Trigger name: SpawnTrigger_X (X enumerated)
	- Trigger text: Reaction Trigger X
	- Activation: ANY PRESENT
	- Condition: at least one player inside + no awake enemy units in thisList
	- OnAct: call{null = [X] spawn GW_Fnc_spawnList;}
	- Timeout: [5,5,5] interruptable

	Supports OKS_fnc_EdenRepeatLastAction by accepting menuData as param 0.
*/

if (!is3DEN) exitWith { false };

disableSerialization;

private _menuData = _this param [0, []];

private _pos = [];

// Prefer passed menuData click position (when available)
if (_menuData isEqualType []) then {
	private _md0 = _menuData param [0, []];
	if (_md0 isEqualType [] && { (count _md0) >= 2 }) then {
		_pos = [_md0 select 0, _md0 select 1, 0];
	} else {
		if ((count _menuData) >= 2 && { (_menuData select 0) isEqualType 0 }) then {
			_pos = [_menuData select 0, _menuData select 1, 0];
		};
	};
};

// Prefer Eden map cursor position when a map control is shown.
if (_pos isEqualTo []) then {
	private _disp3DEN = findDisplay 313;
	if (!isNull _disp3DEN) then {
		private _mapCtrls = (allControls _disp3DEN) select { (ctrlType _x) == 101 && { ctrlShown _x } };
		private _mapCtrl = _mapCtrls param [0, controlNull];
		if (!isNull _mapCtrl) then {
			private _mapPos2D = _mapCtrl ctrlMapScreenToWorld getMousePosition;
			if (_mapPos2D isEqualType [] && { (count _mapPos2D) >= 2 }) then {
				_pos = [_mapPos2D select 0, _mapPos2D select 1, 0];
			};
		};
	};
};

// Fallback: screen-to-world under cursor.
if (_pos isEqualTo []) then {
	private _stw = screenToWorld getMousePosition;
	if (_stw isEqualType [] && { (count _stw) >= 2 }) then {
		_pos = [_stw select 0, _stw select 1, 0];
	};
};

if (_pos isEqualTo []) exitWith {
	["Spawn Lists: Invalid position", 1, 6, true] call BIS_fnc_3DENNotification;
	false
};

_pos set [2, 0];

private _trg = objNull;
private _varName = "";
private _layerName = "Spawn Lists";
private _layer = objNull;

collect3DENHistory {
	_trg = create3DENEntity ["Trigger", "EmptyDetector", _pos];
	if (isNull _trg) exitWith {};

	// Use OKS naming helper (prefix_X) to get the next available SpawnTrigger_X.
	_varName = ["SpawnTrigger"] call OKS_fnc_next3DENName;
	_trg set3DENAttribute ["name", _varName];
};

if (isNull _trg || {_varName isEqualTo ""}) exitWith {
	["Spawn Lists: Failed to create trigger", 1, 6, true] call BIS_fnc_3DENNotification;
	false
};

private _parts = _varName splitString "_";
private _xNum = parseNumber (_parts select ((count _parts) - 1));
if (_xNum <= 0) then { _xNum = 1; };

private _condition = "call{
	if (!isServer) exitWith {false};
	private _players = thisList select {isPlayer _x};
	if (_players isEqualTo []) exitWith {false};
	private _ps = side group (_players # 0);
	({ ((side group _x) getFriend _ps) < 0.6 && {[_x] call ace_common_fnc_isAwake} } count thisList) == 0
}";

private _onActivation = format ["call{null = [%1] spawn GW_Fnc_spawnList;}", _xNum];

collect3DENHistory {
	_trg set3DENAttribute ["text", format ["Reaction Trigger %1", _xNum]];
	_trg set3DENAttribute ["size3", [100, 100, 25]];
	_trg set3DENAttribute ["IsRectangle", false];

	_trg set3DENAttribute ["activationBy", "ANY"];
	_trg set3DENAttribute ["activationType", "PRESENT"];
	_trg set3DENAttribute ["repeatable", false];
	_trg set3DENAttribute ["repeating", false];

	_trg set3DENAttribute ["isServerOnly", true];
	_trg set3DENAttribute ["condition", _condition];
	_trg set3DENAttribute ["onActivation", _onActivation];

	_trg set3DENAttribute ["timeout", [5, 5, 5]];
	_trg set3DENAttribute ["interuptable", true];
};

// Place into a dedicated layer for Spawn List triggers.
if (!isNil "OKS_fnc_EdenGetOrCreateLayer" && {!isNil "OKS_fnc_EdenSetLayerSafe"}) then {
	_layer = [_layerName] call OKS_fnc_EdenGetOrCreateLayer;
	[_trg, _layer] call OKS_fnc_EdenSetLayerSafe;
};

if (!isNil "OKS_fnc_EdenRememberLastAction") then {
	["GW_3DEN_fnc_createReactionTrigger", [], []] call OKS_fnc_EdenRememberLastAction;
};

[format ["Spawn Lists: Created %1 (X=%2)", _varName, _xNum], 0, 6, true] call BIS_fnc_3DENNotification;
true
