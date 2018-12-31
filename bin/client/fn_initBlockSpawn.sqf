scriptName "fn_initBlockSpawn";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_initBlockSpawn.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initBlockSpawn.sqf"

// Get the time left for spawn block
private _spawningProhibitedFor = param [0, 0, [0]];
diag_log format["DEBUG: Spawning prohibited for: %1 seconds more", _spawningProhibitedFor];
// If the prohibitedTime is greater than 0, make sure we also cant spawn
if (_spawningProhibitedFor > 0) then {
	cl_blockSpawnUntil = _spawningProhibitedFor + diag_tickTime;
	[] spawn client_fnc_displaySpawnRestriction;
};
