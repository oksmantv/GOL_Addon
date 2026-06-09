#include "script_component.hpp"

diag_log "[GW][Radios] XEH_postInit started";

if (false) then {
};

if (true) then {
	[QGVARMAIN(missionLoaded), {
		private _group = (group player);
		_group setVariable ["TF_sw_frequency", TF_freq_west];
		_group setVariable ["TF_dd_frequency", TF_freq_west];
		_group setVariable ["TF_lr_frequency", TF_freq_west_lr];
	}] call CBA_fnc_addEventHandler;

	[QGVARMAIN(playerReady), {
		player setVariable ["TF_receivingDistanceMultiplicator", 1];
		player setVariable ["TF_sendingDistanceMultiplicator", 0.7];
		player setVariable [QGVAR(receiving), (player getVariable "TF_receivingDistanceMultiplicator")];

		private _group = (group player);
		if !((_group getVariable "TF_lr_frequency") isEqualTo TF_freq_west_lr) then {
			_group setVariable ["TF_sw_frequency", TF_freq_west];
			_group setVariable ["TF_dd_frequency", TF_freq_west];
			_group setVariable ["TF_lr_frequency", TF_freq_west_lr];
			ERROR("Radio frequency failed, launching backup");
		};

		[player] spawn FUNC(interference);
	}] call CBA_fnc_addEventHandler;

	[QGVAR(setRadioLoss), {
		params ["_unit","_radioLossReceiving"];
		_unit setVariable ["TF_receivingDistanceMultiplicator", _radioLossReceiving];
	}] call CBA_fnc_addEventHandler;
};

diag_log "[GW][Radios] XEH_postInit finished";
