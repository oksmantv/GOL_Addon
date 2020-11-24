#include "script_Component.hpp"
disableSerialization;
#define	SETTING(Var1)	getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> Var1)

private _output = [];
private _events = [];
private _errorCount = 0;
private _ctrlListbox = (_this controlsGroupCtrl 15675);
private _ctrlListButton = (_this controlsGroupCtrl 15676);

_output append (_this call FUNC(AutoTest_Mission));

_output pushBack [-1,""];
_output pushBack [-1,"========================================================================"];	// Seperator
_output pushBack [-1,""];

_output append (_this call FUNC(AutoTest_Common));

{
	_x params ["_img", "_message", ["_tooltip", "", [""]], ["_eventCase", [-1]], ["_eventTooltip", "", [""]], ["_eventText", "Action >", [""]]];
	_index = _ctrlListbox lbAdd _message;
	_events pushBack _eventCase;

	if ((_eventCase select 0) isEqualTo -1) then {
		_ctrlListButton lbAdd "";
	} else {
		_eventIndex = _ctrlListButton lbAdd _eventText;
		if !(_eventTooltip isEqualTo "") then {
			_ctrlListButton lbSetTooltip [_eventIndex, _eventTooltip];
		};
	};

	if !(_tooltip isEqualTo "") then {
		_ctrlListbox lbSetTooltip [_index, _tooltip];
	};

	if (_img isEqualTo 0) then {
		_ctrlListbox lbSetPicture [_index, QPATHTOF(Data\_Approved.paa)];
	};
	if (_img isEqualTo 1) then {
		_ctrlListbox lbSetPicture [_index, QPATHTOF(Data\_warning.paa)];
	};
	if (_img isEqualTo 2) then {
		_ctrlListbox lbSetPicture [_index, QPATHTOF(Data\_Error.paa)];
		_errorCount = _errorCount + 1;
	};
} forEach _output;

_ctrlListbox setVariable [QGVAR(AutoTestEvents), _events];

if (_errorCount > 0) then {
	_index = _ctrlListbox lbAdd "";
	_index = _ctrlListbox lbAdd "========================================================================";
	_index = _ctrlListbox lbAdd "";
	_index = _ctrlListbox lbAdd format ["%1 Errors found, Mission is NOT ready to play", _errorCount];
	_ctrlListbox lbSetTooltip [_index, "Fix current errors and try again"];
	_ctrlListbox lbSetPicture [_index, QPATHTOF(Data\_Error.paa)];

	_ctrlListButton lbAdd "";
	_ctrlListButton lbAdd "";
	_ctrlListButton lbAdd "";
	_ctrlListButton lbAdd "";
};

GVAR(ExportErrorCount) = _errorCount;
GVAR(AutoTestEvents) = _events;

uiNamespace setVariable [QGVARMAIN(ctrlListbox), _ctrlListbox];
uiNamespace setVariable [QGVARMAIN(ctrlListButton), _ctrlListButton];
