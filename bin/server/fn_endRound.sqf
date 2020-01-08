scriptName "fn_endRound";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_endRound.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_endRound.sqf"
#include "..\utils.h"

// Exit if the game is already over
if (sv_gameStatus == 3) exitWith {};

// Update status var
sv_gameStatus = 3;
[["sv_gameStatus"]] call server_fnc_updateVars;

// Disable team balancer
if (!isNil "sv_autoTeamBalancer_thread") then {terminate sv_autoTeamBalancer_thread};

private _lastObj = (sv_stage4_obj getVariable ["status", OBJ_STATUS_UNARMED]) != OBJ_STATUS_DONE;

// Send event to clients
if (sv_tickets <= 0 || sv_matchTime <= 0 || _lastObj) then {
	[DEFEND_SIDE] remoteExec ["client_fnc_endMatch",0];
} else {
	[ATTACK_SIDE] remoteExec ["client_fnc_endMatch",0];
};

// Wait 38 seconds
uiSleep 31;

// Start countdown on users
[] remoteExec ["client_fnc_resetPlayer", 0];

// Tell upper script we're done after all players waited
VARIABLE_DEFAULT(sv_setting_LobbyTime, 30);
uiSleep (sv_setting_LobbyTime - 3);

sv_gameStatus = 4;
[["sv_gameStatus"]] call server_fnc_updateVars;
