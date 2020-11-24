#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		author = "GuzzenVonlidl";
		name = "GW - UI Component";
		url = "https://github.com/GuzzenVonLidl/";
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"GW_Common",
			"A3_UI_F"
		};
		version = VERSION;
		authors[] = {"GuzzenVonlidl"};
	};
};

#include "CfgActions.hpp"
#include "CfgDiary.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgInGameUI.hpp"
#include "CfgPostprocessTemplates.hpp"
#include "CfgUnitInsignia.hpp"
#include "RscMisc.hpp"

class CfgInventoryGlobalVariable {
	maxSoldierLoad = 1000;
};

class CfgLensFlare {
	flareSizeEye[] = {0.1};
	flareSizeEyeSun[] = {0.1};
};
class CfgIRLaserSettings {
	laserMaxRange = 150;
	maxNumberOfRays = 48;
	maxViewDistance = 2000;
};

class CfgMarkerColors {
	class Default;
	class ColorUNKNOWN: Default {
		color[] = {0.4,0,0.8,1};
	};
};

class cTab_settings {
	// define vehicle classes that are equipped with FBCB2 devices
	cTab_vehicleClass_has_FBCB2[] = {"MRAP_01_base_F","MRAP_02_base_F","MRAP_03_base_F","Wheeled_APC_F","Tank","Truck_01_base_F","Truck_03_base_F"};

	// define vehicle classes that are equipped with TAD devices
	cTab_vehicleClass_has_TAD[] = {"Helicopter","Plane"};

	// define helmet classes that are equipped with a helmet cam
	cTab_helmetClass_has_HCam[] = {};
};
class cTab_RscText {};
class cTab_RscText_TAD: cTab_RscText {};
class cTab_TAD_OSD_hookGrid: cTab_RscText_TAD {};
class cTab_RscMapControl {
	class LineMarker {
		lineWidthThin = 0.008;
		lineWidthThick = 0.014;
		lineLengthMin = 5;
		lineDistanceMin = 3e-005;
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	};
};
class cTab_TAD_OSD_hookElevation: cTab_TAD_OSD_hookGrid {
	w = "(((28) * 4) / 2048  *  (safezoneH * 0.8 * 3/4))";
};
class cTab_TAD_OSD_hookDir: cTab_TAD_OSD_hookGrid {
	w = "(((30) * 8) / 2048  *  (safezoneH * 0.8 * 3/4))";
};

class cTab_android_RscMapControl;
class cTab_Tablet_RscMapControl;

class cTab_Android_dlg {
	class controlsBackground {
		class screen: cTab_android_RscMapControl {
			widthRailWay = 1;
		};
		class screenTopo: screen {
			widthRailWay = 1;
		};
	};
};

class cTab_Tablet_dlg {
	class controlsBackground {
		class cTabUavMap: cTab_Tablet_RscMapControl {
			widthRailWay = 1;
		};
		class cTabHcamMap: cTabUavMap {
			widthRailWay = 1;
		};
		class screen: cTab_Tablet_RscMapControl {
			widthRailWay = 1;
		};
		class screenTopo: screen {
			widthRailWay = 1;
		};
	};
};

class cTab_FBCB2_dlg {
	class controlsBackground {
		class screen: cTab_RscMapControl {
			widthRailWay = 1;
		};
		class screenTopo: screen {
			widthRailWay = 1;
		};
	};
};

class RscTitles {
	class cTab_Android_dsp {
		class controlsBackground {
			class screen: cTab_android_RscMapControl {
				widthRailWay = 1;
			};
			class screenTopo: screen {
				widthRailWay = 1;
			};
		};
	};

	class cTab_mapSize_dsp {
		class controls {
			class mapSize: cTab_RscMapControl {
				widthRailWay = 1;
			};
		};
	};
	class STUI_Canvas {
		class controls {
			class canvas {
				widthRailWay = 1;
			};
		};
	};
	class ST_STHud_Rsc {
		class controls {
			class Minimap {
				widthRailWay = 1;
			};
		};
	};
};
