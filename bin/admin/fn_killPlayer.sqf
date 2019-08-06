scriptName "fn_killPlayer";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_killPlayer.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_killPlayer.sqf"

if (isNil "cl_admin_player_sel" || {isNull cl_admin_player_sel}) exitWith {
	["No player was chosen to be killed"] call client_fnc_displayError;
};

if ([cl_admin_player_sel] call admin_fnc_isAdmin) exitWith {
	["An admin cannot be killed"] call client_fnc_displayError;
};

if (!alive cl_admin_player_sel) exitWith {
	["Player is already dead"] call client_fnc_displayError;
};

["KILL PLAYER", "Reason for admin kill:", {
	params [["_reason", "Admin Kill", [""]]];
	[_reason] remoteExecCall ["client_fnc_administrationKill", cl_admin_player_sel];
}] call client_fnc_spawnModal;
