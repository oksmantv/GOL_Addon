
class RscObject;
class RscCompass : RscObject {
	scale = 0.8;
};
class RscControlsGroup;
class RscText;
class RscPicture;
class RscProgress;
class RscVignette {
	colorText[] = {0, 0, 0, 0};
};

class GW_loadingScreen {
	idd = -1;
	class controlsBackground {
		class Background : RscText {
			colorBackground[] = {0,0,0,1};
			colorText[] = {0,0,0,0};
			h = safezoneH;
			text = "";
			w = safezoneW;
			x = safezoneX;
			y = safezoneY;
		};
		class Picture : RscPicture {
			h = 1.0;
			style = 48 + 0x800;
			text = "\x\gw\addons\3den\data\Logo_Type_1.paa";
			w = 1.0;
			x = (safezoneX + safezoneW/2 - 0.5);
			y = (safezoneY + safezoneH/2 - 0.5);
		};
	};
	class controls {
		class CA_Progress : RscProgress {
			h = 0.025;
			idc = 104;
			style = 0;
			type = 8;
			w = 1.0;
			x = (safezoneX + safezoneW/2 - 0.5);
			y = (safezoneY + safezoneH - 0.4);
		};
	};
};

// Desync
class RscPendingInvitation {
	textureConnectionQualityPoor = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureConnectionQualityBad = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureDesyncLow = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureDesyncHigh = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	color[] = {1,1,1,1};
	x = 0.939;
	y = 0.852;
	w = 0.054;
	h = 0.072;
	timeout = 10;
	blinkingPeriod = 2;
};
class RscPendingInvitationInGame {
	textureConnectionQualityPoor = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureConnectionQualityBad = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureDesyncLow = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	textureDesyncHigh = "\A3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa";
	color[] = {1,1,1,1};
	x = 0.939;
	y = 0.852;
	w = 0.054;
	h = 0.072;
	timeout = 10;
	blinkingPeriod = 2;
};

// New map look
class RscMapControl {
	maxSatelliteAlpha = 0.6;

	sizeExLevel = 0.022;

	colorBackground[] = {0.99, 0.99 0.99, 1};
	colorCountlines[] = {0.65, 0.33, 0.2, 0.5};
	colorMainCountlines[] = {0.6, 0.3, 0.2, 0.99};
	colorLevels[] = {0.2, 0.2, 0.1, 0.9};
	colorTracks[] = {1.0, 0.0, 0.0, 0.5};
	colorTracksFill[] = {0.8, 0.7, 0.6, 0.7};
	colorRoads[] = {0.0, 0.0, 0.0, 0.7};
	colorRoadsFill[] = {1, 1, 0, 0.8};
	colorMainRoads[] = {0.0, 0.0, 0.0, 0.7};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 0.7};

	ptsPerSquareSea = 8;
	ptsPerSquareTxt = 8;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor =5;
	ptsPerSquareForEdge = 5;
	ptsPerSquareRoad = 3;
	ptsPerSquareObj = 8;
};

class RscActiveText;
class RscStandardDisplay;
class RscDisplayMultiplayerSetup: RscStandardDisplay {
	class controls {
		class CA_B_West: RscActiveText {
			sizeEx = "(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			x = "0.4 * 1.45 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (SafezoneX)";
			y = "7 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY)";
			w = "1.6 * 3 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.6 * 1.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CA_B_East: CA_B_West {
			sizeEx = "(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.1)";
			x = "0.4 * 1.45 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (SafezoneX)";
			y = "1.08 * 8.7 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY)";
			w = "1.6 * 3 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.6 * 1.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CA_B_Guerrila: CA_B_West {
			sizeEx = "(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			x = "0.4 * 1.45 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (SafezoneX)";
			y = "1.16 * 10.4 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY)";
			w = "1.6 * 3 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.6 * 1.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CA_B_Civilian: CA_B_West {
			sizeEx = "(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			x = "0.4 * 1.45 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (SafezoneX)";
			y = "1.24 * 12.1 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY)";
			w = "1.6 * 3 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.6 * 1.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class CA_B_Virtual: CA_B_West {
			sizeEx = "(   (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
			x = "0.4 * 1.45 *      (   ((safezoneW / safezoneH) min 1.2) / 40) +   (SafezoneX)";
			y = "1.32 * 13.8 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +   (safezoneY)";
			w = "1.6 * 3 *      (   ((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.6 * 1.5 *      (   (   ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

/*
// Ammo Count
class RscInGameUI {
	class RscUnitInfo {
		class WeaponInfoControlsGroupLeft : RscControlsGroup {
			class controls {
				class CA_AmmoCount : RscText {
					sizeEx = 0;
				};
				class CA_MagCount : RscText {
					sizeEx = 0;
				};
				class CA_GrenadeCount : RscText {
					sizeEx = 0;
				};
			};
		};
	};
};

class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
	class Spotlight {
		class GW_JoinServer {
			text = "Join";
			textIsQuote = 0; // 1 to add quotation marks around the text
			picture = QPATHTOF(data\Logo_Type_1.paa); // Square picture, ideally 512x512
			action = "0 = [_this, 'arma3.gol-clan.co.uk', '2302', 'god'] execVM '\x\gw\addons\ui\joinServer.sqf';";
			actionText = "Join server: GOL"; // Text displayed in top left corner of on-hover white frame
			condition = "true"; // Condition for showing the spotlight
		};
	};
};

*/
