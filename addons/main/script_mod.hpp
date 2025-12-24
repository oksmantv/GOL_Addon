#define PREFIX GW
#include "version.hpp"
#define MAJOR GW_MAJOR
#define MINOR GW_MINOR
#define PATCHLVL GW_PATCHLVL
#define BUILD GW_BUILD

#define VERSION GW_VERSION
#define VERSION_AR GW_VERSION_AR
#define VERSION_CONFIG version = VERSION; versionStr = QUOTE(VERSION); versionAr[] = {VERSION_AR}

#define ADDON DOUBLES(PREFIX,COMPONENT)

#define REQUIRED_VERSION 1.0

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).
/*
    #define DEBUG_ENABLED_COMMON
    #define DEBUG_ENABLED_DIAGNOSTIC
    #define DEBUG_ENABLED_EVENTS
    #define DEBUG_ENABLED_HASHES
    #define DEBUG_ENABLED_MAIN
    #define DEBUG_ENABLED_NETWORK
    #define DEBUG_ENABLED_STRINGS
    #define DEBUG_ENABLED_VERSIONING
*/
