#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

#include "XEH_PREP.sqf"

GVAR(MissionMenu) = false;

GVAR(viewDistance_Enabled) = true;
GVAR(viewDistance_Default) = 0;
GVAR(viewObjectDistance_Default) = 0;
GVAR(viewDistance_Max) = 10000;
GVAR(Grass_Enabled) = true;
GVAR(Grass_allowDisable) = true;

GVAR(UnitCaching_Enabled) = false;
GVAR(UnitCaching_Objects) = [];

GVAR(ParadropHalo) = true;
GVAR(ParadropHaloHeight) = 150;
GVAR(ParadropStaticHeight) = 125;

GVAR(STHud_EnabledOld) = isClass(configFile >> "CfgPatches" >> "ST_STHud");
GVAR(STHud_Enabled) = isClass(configFile >> "CfgPatches" >> "STUI_Core");

if (GVAR(STHud_EnabledOld)) then {
	STGI_Update = (compileFinal "");
	STGI_Reload = (compileFinal "");
};

if (GVAR(STHud_Enabled)) then {
	STHUD_UIMode = 3;
	STHud_NoSquadBarMode = true; // Default: false
	STHud_ShowBearingInVehicle = true; // Default: true
	STUI_Occlusion = true; // Default: true
	STUI_RemoveDeadViaProximity = true; // Default: true

	STGI_Update = (compileFinal "");
	STGI_Reload = (compileFinal "");

	GVAR(Toggle_STHud_Compass) = true;
	STHud_Compass = FUNC(STHud_Compass);

	FUNC(STHud_Toggle_Compass) = {
		params ["_activate"];

		if (_activate) then {
			GVAR(Toggle_STHud_Compass) = true;
		} else {
			GVAR(Toggle_STHud_Compass) = false;
		};
	};
};
