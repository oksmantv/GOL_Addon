#include "script_component.hpp"

GVAR(attachmentList) = [
	["acc_flashlight", "acc_pointer_IR"],
	["GW_X3000", "acc_pointer_IR"],
	["GVL_X2000_point", "GVL_X2000_wide", "acc_pointer_IR"]
];

#include "XEH_PREP.sqf"

[QGVARMAIN(playerReady), {
	["GW","GW_switchAttachment", "Toggle Flashlight", {_this spawn FUNC(switchAttachment)}, {}, [DIK_L, [true, false, false]]] call CBA_fnc_addKeybind;
}] call CBA_fnc_addEventHandler;
