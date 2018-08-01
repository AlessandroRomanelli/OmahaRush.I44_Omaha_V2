scriptName "fn_endRound";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_endRound.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_endRound.sqf"

// Exit if the game is already over
if (sv_gameStatus == 3) exitWith {};

// Update status var
sv_gameStatus = 3;
[["sv_gameStatus"]] spawn server_fnc_updateVars;

// Disable team balancer
if (!isNil "sv_autoTeamBalancer_thread") then {terminate sv_autoTeamBalancer_thread};

// Send event to clients
if (sv_tickets <= 0 || sv_matchTime <= 0) then {
	["defenders"] remoteExec ["client_fnc_endMatch",0];
} else {
	["attackers"] remoteExec ["client_fnc_endMatch",0];
};

// Wait 38 seconds
sleep 31;

// Start countdown on users
[] remoteExec ["client_fnc_resetPlayer", -2];

// Tell upper script we're done after all players waited
_time = "LobbyTime" call bis_fnc_getParamValue;
sleep (_time - 3);

sv_gameStatus = 4;
[["sv_gameStatus"]] spawn server_fnc_updateVars;
