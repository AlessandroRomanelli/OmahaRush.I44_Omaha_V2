scriptName "fn_getBlockedSpawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getMatchTime.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getBlockedSpawn.sqf"

waitUntil {sv_gameStatus == 2};
private _client = param [0, objNull, [objNull]];
// Publish variable to given clientID
[sv_fallBack_timeLeft - diag_tickTime] remoteExec ["client_fnc_initBlockSpawn", _client];
