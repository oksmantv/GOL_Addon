#define COMPONENT Core
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_Core
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_Core
    #define DEBUG_SETTINGS DEBUG_SETTINGS_3DEN
#endif

#include "\x\gw\addons\main\script_macros.hpp"

//	#define PREPCOREFOLDER(var1) ##PREFIX##_fnc_##var1 = compile preProcessFileLineNumbers QUOTE(var1.sqf);
#define PREPCOREFOLDER(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNCMAIN(fncName)] call CBA_fnc_compileFunction
#define PREPMISSIONFOLDER(var1) ##PREFIX##_fnc_##var1 = compile preProcessFileLineNumbers QUOTE(var1.sqf);

#ifdef VERSION
    #undef VERSION
    #define VERSION getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version")
#else
    #define VERSION
