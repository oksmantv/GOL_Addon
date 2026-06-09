#define COMPONENT Gear
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_GEAR
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GEAR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_3DEN
#endif

#include "\x\gw\addons\main\script_macros.hpp"

// Gear-specific magazine helper macros (mirrors mission's Modules\Gear\functions\script_Component.hpp).
// Used by Default.sqf when compiled via the function wrappers in functions\.
#define ISMAG(Class) (isClass (configfile >> "CfgMagazines" >> Class))
#define MAGCOUNT(Class) (getNumber (configfile >> "CfgMagazines" >> Class >> "count"))
#define ADD_MAG(Class) [Class, MAGCOUNT(Class)]
#define COUNT_MAGS(Class, Amount) [Class, Amount, MAGCOUNT(Class)]
#define COUNT_AG_MAGS(Class) (400 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_AB_MAGS(Class) (1200 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_ATAB_MAGS(Class) (400 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_AR_MAGS(Class) (800 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_AMMG_MAGS(Class) (500 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_MMG_MAGS(Class) (500 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define ISNILS(VARIABLE,DEFAULT_VALUE) if (isNil #VARIABLE) then { VARIABLE = DEFAULT_VALUE }

// Side helper — mirrors OKS_GOL_Misc/script_Component.hpp (not available in addon include chain)
#define GETSIDE(var1) getNumber(configfile >> "CfgVehicles" >> (typeOf var1) >> "side")
