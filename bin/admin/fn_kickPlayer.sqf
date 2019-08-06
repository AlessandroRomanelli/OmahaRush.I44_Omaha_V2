scriptName "fn_kickPlayer";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_kickPlayer.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_kickPlayer.sqf"

if (isRemoteExecuted) exitWith {
	endMission "Kicked";
};

if (isNil "cl_admin_player_sel" || {isNull cl_admin_player_sel}) exitWith {
	["No player was chosen to be kicked"] call client_fnc_displayError;
};

if ([cl_admin_player_sel] call admin_fnc_isAdmin) exitWith {
	["An admin cannot be kicked"] call client_fnc_displayError;
};

[] spawn {
	private _result = ["Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;
	if (_result) then {
		[] remoteExecCall ["admin_fnc_kickPlayer", cl_admin_player_sel];
	};
};
