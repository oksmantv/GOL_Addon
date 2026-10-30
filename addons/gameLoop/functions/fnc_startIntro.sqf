#include "script_Component.hpp"
/*
	Starts the player-local mission intro after both player and UI loading state
	are ready. The two readiness events can arrive in either order.
*/

if (
	!hasInterface
	|| {isNull player}
	|| {!GVAR(IntroPlayerReady)}
	|| {!GVAR(IntroLoadingScreenDone)}
	|| {GVAR(IntroStarted)}
) exitWith {false};

GVAR(IntroStarted) = true;
diag_log format ["[GW][Intro] starting for %1", name player];

#include "..\XEH_postInitPlayer.sqf"

true