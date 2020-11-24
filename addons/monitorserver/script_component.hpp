#define COMPONENT MonitorServer
#include "\x\gw\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_MonitorServer

#ifdef DEBUG_ENABLED_MonitorServer
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MonitorServer
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MonitorServer
#endif

#include "\x\gw\addons\main\script_macros.hpp"
