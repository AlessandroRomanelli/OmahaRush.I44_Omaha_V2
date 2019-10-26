scriptName "fn_switchPlayer";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_switchPlayer.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_switchPlayer.sqf"

if (isNil "cl_admin_player_sel") exitWith {};

private _oldSide = cl_admin_player_sel getVariable ["gameSide", ""];
[] remoteExec ["client_fnc_teamBalanceKick", cl_admin_player_sel];

waitUntil{(cl_admin_player_sel getVariable ["gameSide", ""]) != _oldSide};

[] call client_fnc_populateAdminArea;
