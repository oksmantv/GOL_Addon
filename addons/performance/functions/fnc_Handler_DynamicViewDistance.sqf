#include "script_component.hpp"
/*
	Author: GuzzenVonLidl
	A performance handler that removes dead bodies, weaponholders and vehicles after some time

	Usage:
	[] call GW_Performance_Fnc_Handler_DynamicViewDistance;

	Arguments: NO

	Return Value: NO

	Public: NO
*/

if !(hasInterface) exitWith {false};
params ["_toggle"];
if (_toggle) then {
	setViewDistance 3000;
	if (isNil QGVAR(DynamicViewDistance_PFH)) then {
		GVAR(DynamicViewDistance_PFH) = [{
			if !(visibleMap) then {
				GVAR(DynamicViewDistance_getAvgFPS) pushBack diag_fps;
			};
		}, 0, []] call CBA_fnc_addPerFrameHandler;

		GVAR(DynamicViewDistance_Update) = [{
			if !(visibleMap) then {
				private _getAvg = (GVAR(DynamicViewDistance_getAvgFPS) call EFUNC(Common,findAverage));
				private _diff = 50;
				private _changeTo = 0;
				private _changeView = false;
				private _objectViewDistance = (getObjectViewDistance select 0);

				GVAR(DynamicViewDistance_getAvgFPS) = [];

				if ((_getAvg > (GVAR(DynamicViewDistance_AvgTargetDistance)) + 4) && (_objectViewDistance < 3000)) then {
					_changeView = true;
					_changeTo = (_objectViewDistance + _diff);
				};

				if ((_getAvg <= (GVAR(DynamicViewDistance_AvgTargetDistance) - 4)) && (_objectViewDistance > 300)) then {
					_changeView = true;
					_changeTo = (_objectViewDistance - _diff);
				};

				if (_changeView) then {
					setObjectViewDistance [_changeTo, 100];
					if (_changeTo < 500) then {
						if !(getTerrainGrid isEqualTo 50) then {
							setTerrainGrid 50;
						};
					} else {
						if !(getTerrainGrid isEqualTo 25) then {
							setTerrainGrid 25;
						};
					};
				};
				TRACE_3("Dynamic FPS", _getAvg, _changeView, _changeTo);
			};
		}, 1, []] call CBA_fnc_addPerFrameHandler;
	};
} else {
	if !(isNil QGVAR(DynamicViewDistance_PFH)) then {
		[GVAR(DynamicViewDistance_PFH)] call CBA_fnc_removePerFrameHandler;
		GVAR(DynamicViewDistance_PFH) = nil;
		[GVAR(DynamicViewDistance_Update)] call CBA_fnc_removePerFrameHandler;
		GVAR(DynamicViewDistance_Update) = nil;
	};
};
GVAR(DynamicViewDistance_Enabled) = _toggle;
