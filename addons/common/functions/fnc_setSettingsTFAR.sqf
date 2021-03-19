
if (isNil "TF_freq_west") then {
	TF_freq_west = [0 ,TF_Default_RadioVolume, ["10","20","30","40","50.1","50.2","50.3","50.5"],0, nil, -1, 0];
};
if (isNil "TF_freq_west_lr") then {
	TF_freq_west_lr = [4 ,TF_Default_RadioVolume, ["10","20","30","40","50.1","50.2","50.3","50.4","50.5"],0, nil, -1, 0];
};
if (isNil "TF_freq_west_dd") then {
	tf_freq_west_dd  =   TF_freq_west;
};

if (isNil "TF_freq_east") then {
	TF_freq_east  =   TF_freq_west;
};
if (isNil "TF_freq_east_lr") then {
	TF_freq_east_lr = TF_freq_west_lr;
};
if (isNil "TF_freq_east_dd") then {
	tf_freq_east_dd  =   TF_freq_west;
};

if (isNil "TF_freq_guer") then {
	TF_freq_guer  =   TF_freq_west;
};
if (isNil "TF_freq_guer_lr") then {
	TF_freq_guer_lr = TF_freq_west_lr;
};
if (isNil "TF_freq_guer_dd") then {
	tf_freq_guer_dd  =   TF_freq_west;
};

{
	_group_freq = (_x getVariable "tf_sw_frequency");
	if (isNil "_group_freq") then {
		if !(tf_same_sw_frequencies_for_side) then {
			_x setVariable ["tf_sw_frequency", call TFAR_fnc_generateSrSettings, true];
		} else {
			switch (side _x) do {
				case west: {
					_x setVariable ["tf_sw_frequency", tf_freq_west, true];
				};
				case east: {
					_x setVariable ["tf_sw_frequency", tf_freq_east, true];
				};
				default {
					_x setVariable ["tf_sw_frequency", tf_freq_guer, true];
				};
			};
		};
	};
	_group_freq = _x getVariable "tf_dd_frequency";
	if (isNil "_group_freq") then {
		if !(tf_same_dd_frequencies_for_side) then {
			_x setVariable ["tf_dd_frequency", call TFAR_fnc_generateDDFreq, true];
		} else {
			switch (side _x) do {
				case west: {
					_x setVariable ["tf_dd_frequency", tf_freq_west_dd, true];
				};
				case east: {
					_x setVariable ["tf_dd_frequency", tf_freq_east_dd, true];
				};
				default {
					_x setVariable ["tf_dd_frequency", tf_freq_guer_dd, true];
				};
			};
		};
	};
	_group_freq = _x getVariable "tf_lr_frequency";
	if (isNil "_group_freq") then {
		if !(tf_same_lr_frequencies_for_side) then {
			_x setVariable ["tf_lr_frequency", call TFAR_fnc_generateLrSettings, true];
		} else {
			switch (side _x) do {
				case west: {
					_x setVariable ["tf_lr_frequency", tf_freq_west_lr, true];
				};
				case east: {
					_x setVariable ["tf_lr_frequency", tf_freq_east_lr, true];
				};
				default {
					_x setVariable ["tf_lr_frequency", tf_freq_guer_lr, true];
				};
			};
		};
	};
	true;
} count allGroups;
