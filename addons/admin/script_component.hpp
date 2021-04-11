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
#define	ARROW "76561197971568283"
#define	OKSMAN	"76561198013929549"
#define MALLEY "76561198110128838"
#define THEC "76561198030991949"
#define FALSE	"76561198024730389"
#define BLU	"76561198086056020"

#define	ADMINLIST GUZZENVONLIDL, ARROW, OKSMAN, MALLEY, THEC, FALSE, BLU

#define	ACTIVE_LIST (GVARMAIN(activeAdmins) + [getAssignedCuratorUnit GW_ZeuzModuleAdminLogged])
