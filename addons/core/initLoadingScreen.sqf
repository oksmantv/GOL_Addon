#include "\A3\ui_f\hpp\defineCommonGrids.inc"
#include "script_Component.hpp"
/*
	Author: Commy2, Modified by GuzzenVonLidl
	Replaces the default loading screen to a full screen one, Note progress bar is not displayed
	This will only show when loading in to a mission, not out
	Only displayed if a picture is assigned

	Usage:
	[this] call _fnc_initLoadingScreen;

	Arguments:
	0: <Object> - Description

	Return Value:
	<Object> - Description

	Public:
*/

#define	GETCONFIG(Var1)	getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> Var1)

//if !(isClass(missionConfigFile >> "GW_FRAMEWORK")) exitWith {false};
//if (getNumber(missionconfigfile >> "GW_FRAMEWORK" >> "Core" >> "Version") < 0.8) exitWith {false};

if (is3DEN) exitWith {false};
if !(getNumber(missionconfigfile >> "GW_FRAMEWORK" >> "Naming" >> "Fullscreen") isEqualTo 1) exitWith {false};
if (GETCONFIG("Picture") isEqualTo "") exitWith {false};

params ["_display"];

private _background = _display ctrlCreate ["RscPicture", -1];

_background ctrlSetPosition [
	safezoneXAbs,
	safezoneY,
	safezoneWAbs,
	safezoneH
];
_background ctrlCommit 0;
_background ctrlSetText "#(rgb,8,8,3)color(0.0,0.0,0.0,1)";

private _size = 0.8;
private _width = _size * safezoneW;
private _height = (_size / 1.6) * safezoneH * (getResolution#4);

private _picture = _display ctrlCreate ["RscPictureKeepAspect", -1];

_picture ctrlSetPosition [
	0.5-_width/2,
	0.375-_height/2,
	_width, _height
];
_picture ctrlCommit 0;
_picture ctrlSetText GETCONFIG("Picture");
//_picture ctrlSetText "\x\gw\addons\3den\data\Logo_GOL_1.paa";
//_picture ctrlSetText "\a3\ui_f\data\GUI\Cfg\LoadingScreens\GC_wallpaper_06_co.paa";

private _size = 0.3;
private _width = (_size + 0.5) * safezoneW;
private _height = _size * safezoneH * (getResolution#4);

private _text = _display ctrlCreate ["RscLoadingText", -1];
_text ctrlSetPosition [
	0.5-_width/2,
	0.7,
	_width, _height
];

_text ctrlCommit 0;
_text ctrlSetText GETCONFIG("MissionName");	// 60
_text ctrlSetFontHeight 0.12;

private _text = _display ctrlCreate ["RscLoadingText", -1];
_text ctrlSetPosition [
	0.5-_width/2,
	0.775,
	_width, _height
];
_text ctrlCommit 0;
_text ctrlSetText GETCONFIG("Description");	// 145
_text ctrlSetFontHeight 0.05;
