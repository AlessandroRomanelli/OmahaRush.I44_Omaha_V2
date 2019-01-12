scriptName "fn_blockSpawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_blockSpawn.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_blockSpawn.sqf"

waitUntil {!isNil "sv_fallBack_timeLeft"};
diag_log format["DEBUG: Spawning prohibited for: %1 seconds more", sv_fallBack_timeLeft];
// If the prohibitedTime is greater than 0, make sure we also cant spawn
if (sv_fallBack_timeLeft > 0) then {
	cl_blockSpawnUntil = sv_fallBack_timeLeft + diag_tickTime;
	[] call client_fnc_displaySpawnRestriction;
};
