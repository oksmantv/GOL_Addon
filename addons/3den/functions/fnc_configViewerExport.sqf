#include "script_Component.hpp"
/*

	Author: DreadedEntity, Simplified by GuzzenVonLidl
	Outputs a full class definition, even returning subclasses and their attributes
	This function should not be called manually, and only from the config viewer screen

	Usage:
	[] call GW_3den_fnc_configViewerExport;

	Arguments: NO

	Return Value: YES <CONFIG>

	Public: NO
*/

disableSerialization;
_cfgViewer = findDisplay 2928;
_ed_config = _cfgViewer displayCtrl 1400;
_btn_export = _cfgViewer displayCtrl 7301;
_curCfgArr = call compile (ctrltext _ed_config);

_fnc_copyConfigClass = {
	if (!isClass (_this select 0)) exitWith {"noClass"};
	params ["_class", ["_numTabs", 0, [0]], ["_output", "", [""]]];

	private _list = [];
	private _params = [];
	private _newLine = toString [13, 10];
	private _parents = (_class call BIS_fnc_returnParents);

	private _MAKE_TABS = {
		_tabs = "";
		for "_t" from 1 to _this do {
			_tabs = _tabs + (toString [9]);
		};
		_tabs;
	};
	private _output = _output + (_numTabs call _MAKE_TABS) + "class " + (configName (_this select 0)) + " {" + _newline;

	{
		for "_i" from 0 to ((count _x) - 1) do {
			_list pushBack (configName (_x select _i));
		};
	} forEach _parents;

	_list sort true;

	{
		private _param = _x;
		private _newConfig = (_this select 0) >> _param;
		private _listLower = (_params apply {toLower _x});
		if (isClass _newConfig) then {
			_output = [_newConfig, _numTabs + 1, _output] call _fnc_copyConfigClass;
		} else {
			_newParam = _param;
			_data = nil;
			switch (true) do {
				case (isNumber _newConfig): {
					_data = (getNumber _newConfig);
				};
				case (isText _newConfig): {
					_data = str(getText _newConfig);
				};
				case (isArray _newConfig): {
					_newParam = _newParam + "[]";
					_data = str(getArray _newConfig);
					_data = "{" + (_data select [1, (count _data) - 2]) + "}";
				};
			};
			if ((_listLower find toLower(_param)) == -1) then {
				_output = _output + ((_numTabs + 1) call _MAKE_TABS) + format["%1 = %2;%3", _newParam, _data, _newLine];
				_params pushBack _param;
			};
		};
	} forEach _list;

	_output = _output + (_numTabs call _MAKE_TABS) + "};" + _newline;
	copyToClipboard _output;
	_output
};

[_curCfgArr] call _fnc_copyConfigClass;		// (configfile >> "CfgMagazines" >> "UGL_FlareWhite_F")
