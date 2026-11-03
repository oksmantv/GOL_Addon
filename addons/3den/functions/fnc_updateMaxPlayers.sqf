#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Keeps the Multiplayer "MaxPlayers" attribute equal to the number of players the
	mission can hold at once. Hosting providers use this value to judge server usage,
	so it is owned by the addon, hard capped, and refreshed on load, save and autosave.
	It must not be edited by hand.
	Framework 4+ missions only. Framework 3.x missions are left untouched.

	Only one side is played at a time, so the value is
	(largest playable side: West / East / Independent / Civilian) + shared slots (headless, spectator).
	Limits: 38 slots per side, 40 total (hard cap).

	Usage:
	[] call GW_3DEN_fnc_updateMaxPlayers;

	Arguments: NO

	Return Value:
	<NUMBER> - MaxPlayers value, -1 if skipped

	Public: NO

*/

#define MAX_PLAYERS_CAP 40
#define MAX_SLOTS_PER_SIDE 38

if (!is3DEN) exitWith {-1};
if !([] call FUNC(isFW4)) exitWith {-1};

private _isPlayable = {
	((_x get3DENAttribute "ControlMP") select 0) || ((_x get3DENAttribute "ControlSP") select 0)
};

// West, East, Independent, Civilian
private _sideCount = [0, 0, 0, 0];
private _shared = 0;

{
	if (call _isPlayable) then {
		private _index = [west, east, independent, civilian] find (side _x);
		if (_index isEqualTo -1) then {
			_shared = _shared + 1;
		} else {
			_sideCount set [_index, (_sideCount select _index) + 1];
		};
	};
} forEach (all3DENEntities select 0);

// Logic entities (headless client, spectator) are shared between all sides
_shared = _shared + ({call _isPlayable} count (all3DENEntities select 3));

private _total = (selectMax _sideCount) + _shared;
private _value = _total min MAX_PLAYERS_CAP;

if (("Multiplayer" get3DENMissionAttribute "MaxPlayers") isNotEqualTo _value) then {
	"Multiplayer" set3DENMissionAttribute ["MaxPlayers", _value];
	LOG_1("MaxPlayers updated to %1", _value);
	[format ["GW: Max players updated to %1", _value], 0, 4, true] call BIS_fnc_3DENNotification;
};

if (_total > MAX_PLAYERS_CAP) then {
	[format ["GW: %1 playable slots exceeds the server limit of %2. Max players capped, remove slots before uploading", _total, MAX_PLAYERS_CAP], 1, 10, true] call BIS_fnc_3DENNotification;
};

{
	if (_x > MAX_SLOTS_PER_SIDE) then {
		[format ["GW: %1 has %2 slots, the limit is %3 per side", ["West", "East", "Independent", "Civilian"] select _forEachIndex, _x, MAX_SLOTS_PER_SIDE], 1, 10, true] call BIS_fnc_3DENNotification;
	};
} forEach _sideCount;

_value
