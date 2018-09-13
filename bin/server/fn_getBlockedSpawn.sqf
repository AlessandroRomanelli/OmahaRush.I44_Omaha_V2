scriptName "fn_getBlockedSpawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getMatchTime.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getBlockedSpawn.sqf"

waitUntil {sv_gameStatus == 2};
private _id = param[0, 0, [0]];
// Publish variable to given clientID
_id publicVariableClient "sv_fallBack_timeLeft";
