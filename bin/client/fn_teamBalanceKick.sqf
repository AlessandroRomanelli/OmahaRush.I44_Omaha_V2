scriptName "fn_teamBalanceKick";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_teamBalanceKick.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_teamBalanceKick.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

VARIABLE_DEFAULT(cl_lastTeamBalanceKick, 0);
VARIABLE_DEFAULT(cl_forceSwitch, false);
// If already being moved or moved recently
if (cl_forceSwitch || {diag_tickTime - cl_lastTeamBalanceKick < 5} ) exitWith {};


cl_forceSwitch = true;
cl_lastTeamBalanceKick = diag_tickTime;

if (!(player getVariable ["isAlive", false]) || cl_inSpawnMenu) exitWith {
	["TEAMBALANCE - YOU ARE BEING MOVED TO THE OTHER TEAM"] call client_fnc_displayError;
	[] call client_fnc_sideSwitch;
};

["TEAMBALANCE - YOU ARE ABOUT TO BE MOVED"] call client_fnc_displayError;
uiSleep 5;

if (player getVariable ["isAlive", false]) then {
	player setVariable ["isAlive", false];
	forceRespawn player;
};

waitUntil{alive player && side player != civilian};

cl_lastTeamBalanceKick = diag_tickTime;
[] call client_fnc_sideSwitch;
