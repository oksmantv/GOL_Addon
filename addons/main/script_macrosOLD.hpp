#include "\x\cba\addons\main\script_macros_common.hpp"

#ifdef DISABLE_COMPILE_CACHE
	#undef PREP
	#define PREP(fncName) QFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
	#define PREPMAIN(fncName) QFUNCMAIN(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
	#undef PREP
	#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
	#define PREPMAIN(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNCMAIN(fncName)] call CBA_fnc_compileFunction
#endif

#define	ISADMIN	(GVARMAIN(isAdmin) || (serverCommandAvailable "#logout"))
#define	ISACTIVEADMIN	(GVARMAIN(isActiveAdmin) || (serverCommandAvailable "#logout"))

#define REMOTEONLYSERVER(A) remoteExecCall [A, 2]
#define MAPLOADED getClientStateNumber >= 9 || !isMultiplayer
#define MISSIONLOADED getClientStateNumber >= 10 || !isMultiplayer

#define	DEVCONSOLE(VAR1)	"debug_console" callExtension (VAR1)

#define conBeep DEVCONSOLE("A")
#define conClear DEVCONSOLE("C")
#define conClose DEVCONSOLE("X")

// *************************************	// Do not edit below
// Internal
#define	FALSE -1
#define	TRUE -2
#define PRIVATE 0
#define PUBLIC 2

#define NO_SIDE -1
#define EAST 0
#define WEST 1
#define RESISTANCE 2
#define CIVILIAN 3
#define NEUTRAL 4
#define ENEMY 5
#define FRIENDLY 6
#define LOGIC 7

#define CBA_CANOVERWRITE 0
#define CBA_SERVEROVERWRITE 1
#define CBA_BLOCKOVERWRITE 2

#define CBA_NEEDRESTART true
#define CBA_EDITABLE false

/* -------------------------------------------
Group: Debugging
------------------------------------------- */
//	#define DEBUG_SETTINGS [true, true, true]

#ifdef DEBUG_MODE_FULL
	#define DEBUG_MODE_NORMAL
#endif

#ifdef DEBUG_MODE_NORMAL
	#define DEBUG_MODE_MINIMAL
#endif

#ifndef DEBUG_MODE_MINIMAL
	#define DEBUG_MODE_NORMAL
	#define DEBUG_MODE_MINIMAL
#endif

#ifdef DEBUG_MODE_FULL
	#define LOG(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "DEBUG", false] call GW_fnc_log
	#define LOG_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "DEBUG", true] call GW_fnc_log
#else	// disabled
	#define LOG(MESSAGE)
	#define LOG_ADMIN(MESSAGE)
#endif

#ifdef DEBUG_MODE_NORMAL
	#define WARNING(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "WARNING", false] call GW_fnc_log
	#define WARNING_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "WARNING", true] call GW_fnc_log
#else	// disabled
	#define WARNING(MESSAGE)
	#define WARNING_ADMIN(MESSAGE)
#endif

#define ERROR(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "ERROR", false] call GW_fnc_log
#define ERROR_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "ERROR", true] call GW_fnc_log

#ifdef DEBUG_MODE_FULL
	#define TRACE_1(MESSAGE,A) LOG(PFORMAT_1(MESSAGE,A));
	#define TRACE_2(MESSAGE,A,B) LOG(PFORMAT_2(MESSAGE,A,B));
	#define TRACE_3(MESSAGE,A,B,C) LOG(PFORMAT_3(MESSAGE,A,B,C));
	#define TRACE_4(MESSAGE,A,B,C,D) LOG(PFORMAT_4(MESSAGE,B,C,D));
	#define TRACE_5(MESSAGE,A,B,C,D,E) LOG(PFORMAT_5(MESSAGE,B,C,D,E));
	#define TRACE_6(MESSAGE,A,B,C,D,E,F) LOG(PFORMAT_6(MESSAGE,B,C,D,E,F));
	#define TRACE_7(MESSAGE,A,B,C,D,E,F,G) LOG(PFORMAT_7(MESSAGE,B,C,D,E,F,G));
	#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) LOG(PFORMAT_8(MESSAGE,B,C,D,E,F,G,H));
	#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) LOG(PFORMAT_9(MESSAGE,B,C,D,E,F,G,H,I));
#else	// disabled
	#define TRACE_1(MESSAGE,A)
	#define TRACE_2(MESSAGE,A,B)
	#define TRACE_3(MESSAGE,A,B,C)
	#define TRACE_4(MESSAGE,A,B,C,D)
	#define TRACE_5(MESSAGE,A,B,C,D,E)
	#define TRACE_6(MESSAGE,A,B,C,D,E,F)
	#define TRACE_7(MESSAGE,A,B,C,D,E,F,G)
	#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H)
	#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I)
#endif
