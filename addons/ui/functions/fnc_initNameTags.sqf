#include "script_Component.hpp"
/*
	Author: GuzzenVonLidl
	Describe your function

	Usage:
	[] call GW_UI_fnc_initNameTags;

	Arguments: No

	Return Value: No

	Public: No
*/

if (missionNamespace getVariable ["NEKY_Medical_Enabled", false]) then {
	NEKY_Medical_HurtBlur_Strength = 0;
	NEKY_Medical_HurtBlur_Min = 0;
	GVAR(isTagsBlurred) = {((NEKY_Medical_HurtBlur_Strength + NEKY_Medical_HurtBlur_Min) != 0)};
};

if (isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
	GVAR(isTagsBlurred) = {(player getVariable ["ACE_Medical_pain", 0]) > 0.2};
};

if (isClass (configFile >> "CfgPatches" >> "ACE_medical_engine")) then {	// New system
};

if ((GVAR(nameTags) > 0) && (isNil QGVAR(frameHandler)) && (isNil QGVAR(drawHandler))) then {
	GVAR(frameHandler) = [{
		private _list = [];
		private _player = (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]);
		private _filtered = (((_player nearObjects ["CAManBase", GVAR(MaxDistance)]) - [_player]) select {
			(alive _x) &&
			((side _x) getFriend (side _player) > 0.6) &&
			{!isMultiplayer || ((isPlayer _x) && !((side _x) isEqualTo sideLogic))} &&
			{(lineIntersectsSurfaces [(AGLtoASL (positionCameraToWorld [0,0,0])), (eyePos _x), _player, _x, false, 1, "VIEW", "NONE"]) isEqualTo []} &&
			{!isObjectHidden _x}
		});

		{
			_worldScreen = (worldToScreen (_x modelToWorldVisual (_x selectionPosition "head")));
			if !(_worldScreen isEqualTo []) then {
				_dir = (1 - ((_worldScreen distance2D [0.5, 0.5]) / (safezoneW / 5)));
				if (_dir > -1) then {
					_list pushBack [_x, _dir];
				};
			};
		} forEach _filtered;

		GVAR(onScreenUnits) = _list;

		private _alpha = 1;
		private _mod = (diag_tickTime mod 1);
		if (call GVAR(isTagsBlurred)) then {	// isblurred
			if (GVAR(damageAlpha) > 0.1) then {
				_alpha = [((_mod * -1) + 1), 1] call BIS_fnc_cutDecimals;
			} else {
				_alpha = 0;
			};
			GVAR(damageAlpha) = _alpha;
		} else {
			if (GVAR(damageAlpha) < 0.8) then {
				_alpha = [_mod, 1] call BIS_fnc_cutDecimals;
				GVAR(damageAlpha) = _alpha;
			};

			GVAR(damageAlpha) = _alpha;
		};

		if ((currentVisionMode player) isEqualTo 0) then {
			_alpha = (_alpha - (((sunOrMoon * -1) + 1) min 0.75));
		};
		if ((currentVisionMode player) isEqualTo 2) then {
			_alpha = 0;
		};
		_alpha = (_alpha - (overcast * 0.2));

		GVAR(nameAlpha) = (_alpha max 0.13);
	}, 0.1, []] call CBA_fnc_addPerFrameHandler;

	GVAR(drawHandler) = addMissionEventHandler ["Draw3D", {
		if ((GVAR(nameTags) isEqualTo 1) || ((GVAR(nameTags) isEqualTo 2) && GVAR(showNameTags))) then {
			private _player = (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]);
			if ((alive _player) && ((call CBA_fnc_getActiveFeatureCamera) isEqualTo "")) then {
				_isZoomed = (((call CBA_fnc_getFov) select 1) > 1.5);
				_size = ((0.02 * ("number" call CBA_fnc_getAspectRatio)) * GVAR(nameSize));
				_shadow = GVAR(nameShadow);
				{
					_x params ["_target","_dir"];
					_arr = [_target, _player, _dir, _isZoomed] call FUNC(drawNameTags);
					if !(_arr isEqualTo []) then {
						drawIcon3D ["", (_arr select 0), (_arr select 1), 0, 0, 0, (name _target), _shadow, _size, "RobotoCondensed"];
					};
				} forEach GVAR(onScreenUnits);
			};
		};
	}];
} else {
	if (GVAR(nameTags) isEqualTo 0) then {
		if !(isNil QGVAR(frameHandler)) then {
			[GVAR(frameHandler)] call CBA_fnc_removePerFrameHandler;
			GVAR(frameHandler) = nil;
		};
		if !(isNil QGVAR(drawHandler)) then {
			removeMissionEventHandler ["Draw3D", GVAR(drawHandler)];
			GVAR(drawHandler) = nil;
		};
	};
};
