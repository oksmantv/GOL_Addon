#define COMPONENT admin
#include "\x\gw\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_ADMIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_admin
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ADMIN
#endif

#include "\x\gw\addons\main\script_macros.hpp"

#define	GUZZENVONLIDL	"76561197993196728"
#define	OKSMAN	"76561198013929549"
#define BLU	"76561198086056020"

#define	ADMINLIST GUZZENVONLIDL, OKSMAN, BLU

#define	ACTIVE_LIST (GVARMAIN(activeAdmins) + [getAssignedCuratorUnit GW_ZeuzModuleAdminLogged])
