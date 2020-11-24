//#define DEBUG_ENABLED_enhancements
#define COMPONENT enhancements
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_enhancements
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_enhancements
    #define DEBUG_SETTINGS DEBUG_SETTINGS_enhancements
#endif

#include "\x\gw\addons\main\script_macros.hpp"


#define MAXLOAD140 \
    maximumLoad = 140;

#define MAXLOAD280 \
    maximumLoad = 280;

#define MAXLOAD320 \
    maximumLoad = 320;


#define SMOKE_COLOR_RED    {0.95, 0.04, 0.04, 0.8}
#define SMOKE_COLOR_GREEN  {0.03, 0.16, 0.10, 0.8}
#define SMOKE_COLOR_YELLOW {0.90, 0.60, 0.00, 0.8}
#define SMOKE_COLOR_PURPLE {0.46, 0.06, 0.30, 0.8}
#define SMOKE_COLOR_BLUE   {0.04, 0.20, 1.00, 0.8}
#define SMOKE_COLOR_ORANGE {0.90, 0.20, 0.01, 0.8}

#define	F_SIZE	8
#define	F_INTENSITY	100000

#define LAUNCHER \
	aiAmmoUsageFlags = "64 + 128 + 256 + 512"; \
	airLock = 1; \
	allowAgainstInfantry = 1; \
	cost = 100; \
	soundFly[] = { \
		"A3\Sounds_F\weapons\Rockets\rocket_fly_1", \
		6, \
		0.85, \
		500 \
	}; \
	whistleDist = 32;
