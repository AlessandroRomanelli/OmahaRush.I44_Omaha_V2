scriptName "fn_initMatchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_initMatchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initMatchTimer.sqf"

private _time = param[0,0,[0]];
private _spawningProhibitedFor = param[1,0,[0]];

if (!isNil "cl_matchTimer_thread") then {
	terminate cl_matchTimer_thread;
};

cl_matchTimer_thread = [_time] spawn client_fnc_matchTimer;

// If the prohibitedTime is greater than 0, make sure we also cant spawn
if (_spawningProhibitedFor > 0) then {
	cl_blockSpawnUntil = diag_tickTime + _spawningProhibitedFor;
	cl_blockSpawnForSide = "attackers";
	[] spawn client_fnc_displaySpawnRestriction;
};
