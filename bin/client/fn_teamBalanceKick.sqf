scriptName "fn_teamBalanceKick";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_teamBalanceKick.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_teamBalanceKick.sqf"
if (isServer && !hasInterface) exitWith {};


if (player getVariable ["isAlive", false] && !cl_inSpawnMenu) then {
	["TEAMBALANCE - YOU ARE ABOUT TO BE MOVED"] call client_fnc_displayError;

	uiSleep 5;

	cl_forceSwitch = true;
	player setVariable ["isAlive", false];
	forceRespawn player;
} else {
	["TEAMBALANCE - YOU ARE BEING MOVED"] call client_fnc_displayError;
	cl_forceSwitch = true;
};
waitUntil{alive player && side player != civilian};
[] call client_fnc_sideSwitch;
