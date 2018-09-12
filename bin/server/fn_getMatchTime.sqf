scriptName "fn_getMatchTime";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getMatchTime.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getMatchTime.sqf"

waitUntil {sv_gameStatus == 2};
private _returnTo = param[0, objNull, [objNull]];
// Match time // Time in seconds until spawning is allowed
[sv_matchEndTime, (sv_fallBack_timeLeft - diag_tickTime)] remoteExec ["client_fnc_initMatchTimer", _returnTo];
