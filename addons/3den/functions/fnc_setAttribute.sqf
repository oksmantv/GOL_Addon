#include "script_component.hpp"
/*
	[] call GW_3DEN_fnc_setAttribute

	Used for quick actions in 3den, Not for spawnList
*/

params ["_case","_value"];

collect3DENHistory {
	if !((count (get3DENSelected "object")) isEqualTo 0) then {
		private _type = "";
		{
			switch (_case) do {
				case 1: {
					_x set3DENAttribute ["enableSimulation", _value];
					_type = "enableSimulation";
				};
				case 2: {
					_x set3DENAttribute ["allowDamage", _value];
					_type = "allowDamage";
				};
				case 3: {
					_x set3DENAttribute ["hideObject", _value];
					_type = "hideObject";
				};
				case 4: {
					_x set3DENAttribute ["objectIsSimple", _value];
					_type = "objectIsSimple";
				};
				case 5: {
					_x set3DENAttribute ["UnitPos", _value];
					_type = "UnitPos";
				};
				case 6: {
					_x set3DENAttribute ["dynamicSimulation", _value];
					_type = "dynamicSimulation";
				};
				default {
				};
			};
		} forEach (get3DENSelected "object");

		if (_type isEqualTo "UnitPos") then {
			private _stance = ["Up","Middle","Down","Auto"] select _value;
			systemChat format ["Command: %1 changed to %2", _type, _stance];
		};
	};
};

[(str _this),QFUNC(setAttribute)] call FUNC(uiSaveFunction);

true
