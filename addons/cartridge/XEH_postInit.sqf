// #define DEBUG_MODE_FULL
#include "script_component.hpp"

if (isServer && GVAR(enabled)) then {
	[{
		GVAR(CleanUp_PFH) = [{
			[] call FUNC(handler);
		}, 10, []] call CBA_fnc_addPerFrameHandler;

		["CAManBase", "Fired", {
			params ["_unit","_muzzle","_weapon","_type","_ammo"];
			private _isOnFoot = (isNull (objectParent _unit));
			if (GVAR(enabled) && _isOnFoot) then {
				if ((isPlayer _unit) || GVAR(allowAI)) then {
					_this call FUNC(fired);
				};
			};
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	}, []] call CBA_Fnc_execNextFrame;
};
