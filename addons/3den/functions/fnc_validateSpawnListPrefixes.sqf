/*
	Author: GOL
	Checks the mission spawnList.sqf source for unsupported addon classname prefixes.
	The blocked-prefix setting is shared with the Gear DLC validation so export
	validation and runtime gear sanitization use the same policy.

	Return Value:
	ARRAY of [prefix, [lineNumber, ...]] entries <ARRAY>
*/
#include "script_Component.hpp"

private _spawnListPath = "spawnList.sqf";
if !(fileExists _spawnListPath) exitWith {[]};

private _blockedPrefixSetting = missionNamespace getVariable ["GW_Gear_DlcValidationBlockedPrefixes", "HLC_,LOP_"];
if !(_blockedPrefixSetting isEqualType "") then {
	_blockedPrefixSetting = "HLC_,LOP_";
};

private _blockedPrefixes = (_blockedPrefixSetting splitString ",;") apply {toLower _x};
_blockedPrefixes = _blockedPrefixes select {_x != ""};
if (_blockedPrefixes isEqualTo []) exitWith {[]};

private _source = loadFile _spawnListPath;
if (_source isEqualTo "") exitWith {[]};

private _findings = [];
private _inBlockComment = false;
{
	private _lineNumber = _forEachIndex + 1;
	private _line = _x;
	private _continueStripping = true;
	while {_continueStripping && {!(_line isEqualTo "")}} do {
		if (_inBlockComment) then {
			private _commentEnd = _line find "*/";
			if (_commentEnd isEqualTo -1) then {
				_line = "";
				_continueStripping = false;
			} else {
				_line = _line select [_commentEnd + 2];
				_inBlockComment = false;
			};
		} else {
			private _blockCommentStart = _line find "/*";
			private _lineCommentStart = _line find "//";
			if (_lineCommentStart > -1 && {(_blockCommentStart isEqualTo -1) || {_lineCommentStart < _blockCommentStart}}) then {
				_line = _line select [0, _lineCommentStart];
				_continueStripping = false;
			} else {
				if (_blockCommentStart isEqualTo -1) then {
					_continueStripping = false;
				} else {
					private _beforeComment = _line select [0, _blockCommentStart];
					private _afterCommentStart = _line select [_blockCommentStart + 2];
					private _commentEnd = _afterCommentStart find "*/";
					if (_commentEnd isEqualTo -1) then {
						_line = _beforeComment;
						_inBlockComment = true;
						_continueStripping = false;
					} else {
						_line = _beforeComment + (_afterCommentStart select [_commentEnd + 2]);
					};
				};
			};
		};
	};

	private _lineLower = toLower _line;
	{
		private _prefix = _x;
		if ((_lineLower find _prefix) > -1) then {
			private _findingIndex = _findings findIf {(_x select 0) isEqualTo _prefix};
			if (_findingIndex isEqualTo -1) then {
				_findings pushBack [_prefix, [_lineNumber]];
			} else {
				(_findings select _findingIndex select 1) pushBack _lineNumber;
			};
		};
	} forEach _blockedPrefixes;
} forEach (_source splitString toString [10, 13]);

_findings