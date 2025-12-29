#include "script_component.hpp"
/*
	Configure selected vehicles for GW Framework.

	- Renames vehicles to match GW preset naming conventions:
		vehicle_X: ground vehicles only (Car/Tank/Motorcycle)
		helicopter_X: helicopters
		jet_X: planes
	- Clears init field on all selected vehicles.

	Rules:
	- Uses next free index across the whole mission per prefix.
	- Leaves entities already matching prefix_# untouched.
*/

private _selectedVehicles = (get3DENSelected "object") select {
	(_x isKindOf "AllVehicles")
	&& !(_x isKindOf "CAManBase")
	&& !(_x isKindOf "StaticWeapon")
	&& (
		(_x isKindOf "Plane")
		|| (_x isKindOf "Helicopter")
		|| (_x isKindOf "Ship")
		|| (_x isKindOf "Car")
		|| (_x isKindOf "Tank")
		|| (_x isKindOf "Motorcycle")
	)
};

if (_selectedVehicles isEqualTo []) exitWith {
	["No vehicles selected", 1, 5, false] call BIS_fnc_3DENNotification;
	false
};

private _allObjects = [];
{
	if (_x isEqualType objNull) then {
		_allObjects pushBackUnique _x;
	};
} forEach (flatten all3DENEntities);

private _fnc_collectUsedIndices = {
	params ["_prefix", "_all"]; 
	private _used = [];
	private _p = toLower (_prefix + "_");
	private _pLen = count _p;
	{
		private _n = toLower ((_x get3DENAttribute "name") param [0, ""]);
		if ((_n find _p) == 0) then {
			private _rest = _n select [_pLen];
			private _num = parseNumber _rest;
			if (_num > 0) then {
				_used pushBackUnique _num;
			};
		};
	} forEach _all;
	_used
};

private _usedVehicle = ["vehicle", _allObjects] call _fnc_collectUsedIndices;
private _usedHelicopter = ["helicopter", _allObjects] call _fnc_collectUsedIndices;
private _usedJet = ["jet", _allObjects] call _fnc_collectUsedIndices;

private _fnc_hasCorrectName = {
	params ["_entity", "_prefix"]; 
	private _n = toLower ((_entity get3DENAttribute "name") param [0, ""]);
	private _p = toLower (_prefix + "_");
	if ((_n find _p) != 0) exitWith { false };
	private _rest = _n select [count _p];
	(parseNumber _rest) > 0
};

collect3DENHistory {
	private _renamed = 0;
	private _clearedInit = 0;
	private _skippedRename = 0;

	{
		private _currentName = toLower ((_x get3DENAttribute "name") param [0, ""]);
		private _isMHQ = (_currentName find "mhq_") == 0;

		private _currentInit = (_x get3DENAttribute "init") param [0, ""];
		if !(_currentInit isEqualTo "") then { _clearedInit = _clearedInit + 1; };
		_x set3DENAttribute ["init", ""];

		// Determine category and naming prefix.
		private _prefix = "";
		if (_x isKindOf "Plane") then {
			_prefix = "jet";
		} else {
			if (_x isKindOf "Helicopter") then {
				_prefix = "helicopter";
			} else {
				// Ground vehicles and boats.
				if ((_x isKindOf "Car") || (_x isKindOf "Tank") || (_x isKindOf "Motorcycle") || (_x isKindOf "Ship")) then {
					_prefix = "vehicle";
				};
			};
		};

		if (_isMHQ) then {
			// Legacy naming: keep MHQ_X intact, but still clear init.
			_skippedRename = _skippedRename + 1;
		} else {
		if (_prefix isEqualTo "") then {
			_skippedRename = _skippedRename + 1;
		} else {
			if !([_x, _prefix] call _fnc_hasCorrectName) then {
				private _idx = 1;
				switch (_prefix) do {
					case "vehicle": {
						while { _idx in _usedVehicle } do { _idx = _idx + 1; };
						_usedVehicle pushBack _idx;
					};
					case "helicopter": {
						while { _idx in _usedHelicopter } do { _idx = _idx + 1; };
						_usedHelicopter pushBack _idx;
					};
					case "jet": {
						while { _idx in _usedJet } do { _idx = _idx + 1; };
						_usedJet pushBack _idx;
					};
				};

				_x set3DENAttribute ["name", format ["%1_%2", _prefix, _idx]];
				_renamed = _renamed + 1;
			};
		};
		};
	} forEach _selectedVehicles;

	[format ["Configured %1 vehicles (renamed %2, cleared init %3, rename-skipped %4)", count _selectedVehicles, _renamed, _clearedInit, _skippedRename], 0, 6, true, 0.5] call BIS_fnc_3DENNotification;
};

[(str _this), QFUNC(configurePlayerVehicles)] call FUNC(uiSaveFunction);
true
