//	https://community.bistudio.com/wiki/setLightAttenuation

class CfgWeapons {
	class Default {
		fireLightDuration = 1;
		fireLightIntensity = 0.5;
	};

	class ItemCore;
	class InventoryFlashLightItem_Base_F;
	class GW_X3000: ItemCore {
		scope = 2;
		author = "GuzzenVonLidl";
		_generalMacro = "GW_X3000";
		displayName = "X3000 FlashLight";
		descriptionUse = "Powerfull flashLight";
		descriptionShort = "Powerfull flashLight";
		picture = "\A3\weapons_F\Data\UI\gear_accv_flashlight_CA.paa";
		model = "\A3\weapons_f\acc\accv_Flashlight_F";
		class ItemInfo: InventoryFlashLightItem_Base_F {
			mass = 2;
			class FlashLight {
				color[] = {100,150,180};
				ambient[] = {180,225,270};
				intensity = 100;
				size = 1;
				innerAngle = 40;
				outerAngle = 80;
				coneFadeCoef = 10;
				position = "flash dir";
				direction = "flash";
				useFlare = 1;
				flareSize = 1.5;
				flareMaxDistance = "600.0f";
				dayLight = 0;
				class Attenuation {
					start = 0.5;
					constant = 80;
					linear = 60;
					quadratic = 20;
					hardLimitStart = 200;
					hardLimitEnd = 300;
				};
				scale[] = {0};
//				scale[]={1,1,0.5};
			};
		};
		inertia = 0.1;
	};

	class GVL_X2000_point: GW_X3000 {
		scope = 2;
		author = "GuzzenVonLidl";
		_generalMacro = "GVL_X2000_point";
		displayName = "X2000 FlashLight (Point-Beam)";
		descriptionUse = "Powerfull flashLight for longer distances";
		descriptionShort = "Powerfull flashLight for longer distances";
		picture = "\A3\weapons_F\Data\UI\gear_accv_flashlight_CA.paa";
		model = "\A3\weapons_f\acc\accv_Flashlight_F";
		class ItemInfo: InventoryFlashLightItem_Base_F {
			mass = 2;
			class FlashLight {
				color[] = {1200,1500,1800};
				ambient[] = {10,7.5,5};
				intensity = 300;
				size = 1;
				innerAngle = 20;
				outerAngle = 30;
				coneFadeCoef = 3;
				direction = "flash";
				position = "flash dir";
				dayLight = 1;
				useFlare = 1;
				flareSize = 3;
				flareMaxDistance = 300;
				class Attenuation {
					start = 15;
					constant = 100;
					linear = 70;
					quadratic = 15;
					hardLimitStart = 130;
					hardLimitEnd = 160;
				};
				scale[] = {0};
			};
		};
		inertia = 0.1;
	};

	class GVL_X2000_wide: GW_X3000 {
		scope = 2;
		author = "GuzzenVonLidl";
		_generalMacro = "GVL_X2000_wide";
		displayName = "X2000 FlashLight (Wide-Beam)";
		descriptionUse = "Powerfull flashLight, lower range but wide beam";
		descriptionShort = "Powerfull flashLight, lower range but wide beam";
		picture = "\A3\weapons_F\Data\UI\gear_accv_flashlight_CA.paa";
		model = "\A3\weapons_f\acc\accv_Flashlight_F";
		class ItemInfo: InventoryFlashLightItem_Base_F {
			mass = 2;
			class FlashLight {
				color[] = {100,150,180};
				ambient[] = {180,225,270};
				intensity = 100;
				size = 1;
				innerAngle = 40;
				outerAngle = 80;
				coneFadeCoef = 5;
				direction = "flash";
				position = "flash dir";
				dayLight = 0;
				useFlare = 1;
				flareSize = 1;
				flareMaxDistance = 100;
				class Attenuation {
					start = 0.25;
					constant = 80;
					linear = 60;
					quadratic = 20;
					hardLimitStart = 20;
					hardLimitEnd = 60;
				};
				scale[] = {0};
			};
		};
		inertia = 0.1;
	};
};

