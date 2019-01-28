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
[["sv_gameStatus"]] call server_fnc_updateVars;

// Disable team balancer
if (!isNil "sv_autoTeamBalancer_thread") then {terminate sv_autoTeamBalancer_thread};

private _mcomsLeft = !((sv_stage4_obj getVariable ["status", -1]) isEqualTo 3);

// Send event to clients
if (sv_tickets <= 0 || sv_matchTime <= 0 || _mcomsLeft) then {
	["defenders"] remoteExec ["client_fnc_endMatch",0];
} else {
	["attackers"] remoteExec ["client_fnc_endMatch",0];
};

// Wait 38 seconds
uiSleep 31;

// Start countdown on users
[] remoteExec ["client_fnc_resetPlayer", 0];

// Tell upper script we're done after all players waited
private _time = ["LobbyTime", 60] call BIS_fnc_getParamValue;
uiSleep (_time - 3);

sv_gameStatus = 4;
[["sv_gameStatus"]] call server_fnc_updateVars;
