#define PREFIX GW
#define MAJOR 0
#define MINOR 9
#define PATCHLVL 4
#define BUILD 241119	// We will use the DATE for the BUILD# in the format DDMMYY

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION_CONFIG version = VERSION; versionStr = QUOTE(VERSION); versionAr[] = {VERSION_AR}

#define REQUIRED_VERSION 1.78

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
