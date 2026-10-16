
_addEquipment = {

	private ["_equipment"];
	private _equipmentChoices = _this apply {[_x] call _removeUnsupportedGearCandidates};
	private _slotNames = ["Goggles", "Helmet", "Uniform", "Vest", "Backpack"];
	{
		if !(_x isEqualTo "") then {
			[_x, _slotNames select _forEachIndex] call _validateDlcCandidateGroup;
		};
	} forEach _equipmentChoices;
	if !((_equipmentChoices select 0) isEqualTo "") then {
		if((typeName (_equipmentChoices select 0)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_equipmentChoices select 0);
		} else {
			_equipment = (_equipmentChoices select 0);
		};
		_loadout set [7, _equipment];		// Goggles
	};
	if !((_equipmentChoices select 1) isEqualTo "") then {
		if((typeName (_equipmentChoices select 1)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_equipmentChoices select 1);
		} else {
			_equipment = (_equipmentChoices select 1);
		};		
		_loadout set [6, _equipment];		// Helmet
	};
	if !((_equipmentChoices select 2) isEqualTo "") then {
		if((typeName (_equipmentChoices select 2)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_equipmentChoices select 2);
		} else {
			_equipment = (_equipmentChoices select 2);
		};
		_loadout set [3, [_equipment,[]]];	// Uniform
	};
	if !((_equipmentChoices select 3) isEqualTo "") then {
		if((typeName (_equipmentChoices select 3)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_equipmentChoices select 3);
		} else {
			_equipment = (_equipmentChoices select 3);
		};
		_loadout set [4, [_equipment,[]]];	// Vest
	};
	if !((_equipmentChoices select 4) isEqualTo "") then {
		if((typeName (_equipmentChoices select 4)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_equipmentChoices select 4);
		} else {
			_equipment = (_equipmentChoices select 4);
		};
		_loadout set [5, [_equipment,[]]];	// Backpack
	};
};

_addPrimary = {
	private _weapon = (_this select 0) apply {[_x] call _removeUnsupportedGearCandidates};
	private _magazine = [_this select 1] call _removeUnsupportedGearCandidates;
	private _tracerMagazine = [_this select 2] call _removeUnsupportedGearCandidates;
	[_weapon select 0, "Primary weapon"] call _validateDlcCandidateGroup;
	{
		[_weapon select _x, "Primary weapon attachment"] call _validateDlcCandidateGroup;
	} forEach [1, 2, 3, 4];
	[_magazine, "Primary weapon magazine"] call _validateDlcCandidateGroup;
	[_tracerMagazine, "Primary weapon magazine"] call _validateDlcCandidateGroup;
	if !(_weapon select 0 isEqualTo "" || {_weapon select 0 isEqualTo []}) then {
		private _primaryClass = if (_weapon select 0 isEqualType []) then {selectRandom (_weapon select 0)} else {_weapon select 0};
		_loadout set [0, [_primaryClass, _weapon select 1, _weapon select 2, _weapon select 3, ADD_MAG(_magazine), ADD_MAG(_tracerMagazine), _weapon select 4]];
	};
};
_addLaunchers = {
	private _weapon = (_this select 0) apply {[_x] call _removeUnsupportedGearCandidates};
	private _magazine = [_this select 1] call _removeUnsupportedGearCandidates;
	private _tracerMagazine = [_this select 2] call _removeUnsupportedGearCandidates;
	[_weapon select 0, "Launcher"] call _validateDlcCandidateGroup;
	{
		[_weapon select _x, "Launcher attachment"] call _validateDlcCandidateGroup;
	} forEach [1, 2, 3, 4];
	[_magazine, "Launcher magazine"] call _validateDlcCandidateGroup;
	[_tracerMagazine, "Launcher magazine"] call _validateDlcCandidateGroup;
	if !(_weapon select 0 isEqualTo "" || {_weapon select 0 isEqualTo []}) then {
		private _launcherClass = if (_weapon select 0 isEqualType []) then {selectRandom (_weapon select 0)} else {_weapon select 0};
		_loadout set [1, [_launcherClass, _weapon select 1, _weapon select 2, _weapon select 3, ADD_MAG(_magazine), ADD_MAG(_tracerMagazine), _weapon select 4]];
	};
};
_addHandGun = {
	private _weapon = (_this select 0) apply {[_x] call _removeUnsupportedGearCandidates};
	private _magazine = [_this select 1] call _removeUnsupportedGearCandidates;
	private _tracerMagazine = [_this select 2] call _removeUnsupportedGearCandidates;
	[_weapon select 0, "Handgun"] call _validateDlcCandidateGroup;
	{
		[_weapon select _x, "Handgun attachment"] call _validateDlcCandidateGroup;
	} forEach [1, 2, 3, 4];
	[_magazine, "Handgun magazine"] call _validateDlcCandidateGroup;
	[_tracerMagazine, "Handgun magazine"] call _validateDlcCandidateGroup;
	if !(_weapon select 0 isEqualTo "" || {_weapon select 0 isEqualTo []}) then {
		private _handgunClass = if (_weapon select 0 isEqualType []) then {selectRandom (_weapon select 0)} else {_weapon select 0};
		_loadout set [2, [_handgunClass, _weapon select 1, _weapon select 2, _weapon select 3, ADD_MAG(_magazine), ADD_MAG(_tracerMagazine), _weapon select 4]];
	};
};
_addToUniform = {
	if !(count (_loadout select 3) isEqualTo 0) then {
		{
			private _item = [_x select 0] call _removeUnsupportedGearCandidates;
			[_item, "Uniform cargo"] call _validateDlcCandidateGroup;
			if !(_item isEqualTo "") then {
				if (ISMAG(_item)) then {
					((_loadout select 3) select 1) append [COUNT_MAGS(_item,(_x select 1))];
				} else {
					((_loadout select 3) select 1) append [[_item, _x select 1]];
				};
			};
		} forEach _this;
	};
};
_addToVest = {
	if !(count (_loadout select 4) isEqualTo 0) then {
		{
			private _item = [_x select 0] call _removeUnsupportedGearCandidates;
			[_item, "Vest cargo"] call _validateDlcCandidateGroup;
			if !(_item isEqualTo "") then {
				if (ISMAG(_item)) then {
					((_loadout select 4) select 1) append [COUNT_MAGS(_item,(_x select 1))];
				} else {
					((_loadout select 4) select 1) append [[_item, _x select 1]];
				};
			};
		} forEach _this;
	};
};
_addToBackPack = {
	if !(count (_loadout select 5) isEqualTo 0) then {
		{
			private _item = [_x select 0] call _removeUnsupportedGearCandidates;
			[_item, "Backpack cargo"] call _validateDlcCandidateGroup;
			if !(_item isEqualTo "") then {
				if (ISMAG(_item)) then {
					((_loadout select 5) select 1) append [COUNT_MAGS(_item,(_x select 1))];
				} else {
					((_loadout select 5) select 1) append [[_item, _x select 1]];
				};
			};
		} forEach _this;
	};
};
_addBino = {
	private _bino = [_this] call _removeUnsupportedGearCandidates;
	[_bino, "Binocular"] call _validateDlcCandidateGroup;
	if !(_bino isEqualTo "") then {
		_loadout set [8, [_bino,"","","",[],[],""]];
	};
};
_addNVG = {
	private _nvg = [_this] call _removeUnsupportedGearCandidates;
	[_nvg, "Night-vision device"] call _validateDlcCandidateGroup;
	if !(_nvg isEqualTo "") then {
		(_loadout select 9) set [5, _nvg];
	};
};
_addLinkedItems = {
	private _slotNames = ["Map", "GPS", "Radio", "Compass", "Watch", "Night-vision device"];
	private _linkedItems = _this apply {[_x] call _removeUnsupportedGearCandidates};
	{
		[_x, _slotNames select _forEachIndex] call _validateDlcCandidateGroup;
	} forEach _linkedItems;
	_loadout set [9, _linkedItems]
};

_fnc_AddObjectsCargo = {
	params [["_unit", objNull, [objNull]],["_item", "", [""]],["_number", 1, [0]]];
	_item = [_item] call _removeUnsupportedGearCandidates;

	if !(_item isEqualTo "") then {
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
			_unit addMagazineCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
			if (_item isEqualTo "HandGrenade") then {
				_unit addMagazineCargoGlobal [_item, _number];
			} else {
				_unit addWeaponCargoGlobal [_item, _number];
			};

		};
	};
};
