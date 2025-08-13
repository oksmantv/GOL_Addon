#define COMPONENT admin
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_ADMIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_admin
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ADMIN
#endif

#include "\x\gw\addons\main\script_macros.hpp"

#define	OKSMAN	"76561198013929549"
#define BLU	"76561198086056020"
#define FILTH "76561198014971848"
#define RUTTERS "76561199681025229"
#define SKELI "76561198073683939"
#define ERIC "76561198210159148"
#define JOONA "76561198058521961"
#define VERSED "76561198082242266"

#define	ADMINLIST OKSMAN, BLU, FILTH, RUTTERS, SKELI, ERIC, JOONA, VERSED

#define	ACTIVE_LIST (GVARMAIN(activeAdmins) + [getAssignedCuratorUnit GW_ZeuzModuleAdminLogged])
