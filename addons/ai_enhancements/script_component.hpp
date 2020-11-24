#define COMPONENT AI_Enhancements
#include "\x\gw\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_AI_Enhancements

#ifdef DEBUG_ENABLED_AI_Enhancements
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AI_Enhancements
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AI_Enhancements
#endif

#include "\x\gw\addons\main\script_macros.hpp"


#define ReadAndWrite access = 0;		// any modifications enabled
#define ReadAndCreate access = 1;		// only adding new class members is allowed
#define ReadOnly access = 2;			// no modifications enabled
#define ReadOnlyVerified access = 3;	// no modifications enabled, CRC test applied

#define LAUNCHER_MAIN \
	aiDispersionCoefX = 1; \
	aiDispersionCoefY = 1; \
	aiRateOfFire = 10; \
	aiRateOfFireDistance = 500; \
	aiRateOfFireDispersion = 1; \
	maxRange = 1000; \
	maxRangeProbab = 0.2; \
	midRange = 300; \
	midRangeProbab = 0.9; \
	minRange = 20; \
	minRangeProbab = 0.4;

#define LAUNCHER_SINGLE \
	aiDispersionCoefX = 1.4; \
	aiDispersionCoefY = 1.7; \
	aiRateOfFire = 7; \
	aiRateOfFireDistance = 500; \
	aiRateOfFireDispersion = 1; \
	maxRange = 1000; \
	maxRangeProbab = 0.2; \
	midRange = 400; \
	midRangeProbab = 0.9; \
	minRange = 10; \
	minRangeProbab = 0.4;


#define RIFLE_SINGLE \
	aiRateOfFire = 1; \
	aiRateOfFireDistance = 550; \
	aiRateOfFireDispersion = 2.0; \
	maxRange = 1000; \
	maxRangeProbab = 0.5; \
	midRange = 500; \
	midRangeProbab = 0.9; \
	minRange = 50; \
	minRangeProbab = 0.3;


#define RIFLE_BURST \
	aiRateOfFire = 1; \
	aiRateOfFireDistance = 200; \
	aiRateOfFireDispersion = 0.5; \
	maxRange = 150; \
	maxRangeProbab = 0.2; \
	midRange = 75; \
	midRangeProbab = 0.6; \
	minRange = 10; \
	minRangeProbab = 0.4;


#define RIFLE_FULL \
	aiRateOfFire = 0.1; \
	aiRateOfFireDistance = 50; \
	maxRange = 25; \
	maxRangeProbab = 0.1; \
	midRange = 10; \
	midRangeProbab = 0.7; \
	minRange = 0; \
	minRangeProbab = 0.9;
