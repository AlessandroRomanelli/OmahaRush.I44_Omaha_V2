scriptName "fn_initBlockSpawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_initBlockSpawn.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initBlockSpawn.sqf"

// Wait for the server ti reply to our previous query
waitUntil{!isNil sv_fallBack_timeLeft};

// Get the time left for spawn block
_spawningProhibitedFor = sv_fallBack_timeLeft - serverTime;
// If the prohibitedTime is greater than 0, make sure we also cant spawn
if (_spawningProhibitedFor > 0) then {
	cl_blockSpawnUntil = sv_fallBack_timeLeft;
	cl_blockSpawnForSide = "attackers";
	[] spawn client_fnc_displaySpawnRestriction;
};
