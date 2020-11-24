#define SPOTTING_SENSIVITIY 5
#define SPOTTING_SENSITIVITYEAR 1
#define SPOTTING_VEHICLESENSITIVITYEAR 35
/*
	sensitivity = SPOTTING_SENSIVITIY;			// 1.75
	sensitivityEar = SPOTTING_SENSITIVITYEAR;	// 0.125
	4		- 300
	5		- 500
	7		- 600
	10		- 700
*/

class ViewPilot;
class HeadLimits;

class CfgVehicles {
    class All;
    class AllVehicles;
    class Land;
    class Man: Land {
		audible = 0.015;
		camouflage = 1;
//		sensitivityEar = 1;
	};
	class CAManBase: Man {
		audible = 0.025;		// 0.015
		crouchProbabilityCombat = 0.4;
		crouchProbabilityEngage = 0.8;
		crouchProbabilityHiding = 0.6;
		fsmDanger = "x\gw\addons\AI_Enhancements\danger.fsm";
		detectSkill = 10;
		sensitivity = 1;
		sensitivityEar = 0.125;
	};
	class SoldierEB: CAManBase {
		sensitivity = SPOTTING_SENSIVITIY;
		sensitivityEar = SPOTTING_SENSITIVITYEAR;
	};
	class SoldierGB: CAManBase {
		sensitivity = SPOTTING_SENSIVITIY;
		sensitivityEar = SPOTTING_SENSITIVITYEAR;
	};
	class SoldierWB: CAManBase {
		sensitivity = SPOTTING_SENSIVITIY;
		sensitivityEar = SPOTTING_SENSITIVITYEAR;
	};
};

/*
		spotableDarkNightLightsOff = 0.0015;
		spotableNightLightsOff = 0.0175;
		crouchProbabilityCombat = 100;
		crouchProbabilityHiding = 100;
		lyingLimitSpeedCombat = 3;
		lyingLimitSpeedHiding = 0.5;
		lyingLimitSpeedStealth = 0.2;

	class Civilian: CAManBase {
		accuracy = 0.2;
		aiBrainType = "DefaultAnimalBrain";		//	DefaultCivilianBrain
		fsmDanger = "";
		fsmFormation = "";
		handgunAmmoCoef = 0;
		primaryAmmoCoef = 0;
		secondaryAmmoCoef = 0;
		sensitivity = 0.50;
		sensitivityEar = 0.050;
	};
*/
