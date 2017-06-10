scriptName "fn_waitForServer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_waitForServer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_waitForServer.sqf"
if (isServer && !hasInterface) exitWith {};

// Apparently the server isnt done selecting a map yet
waitUntil {sv_gameStatus == 2}; // Wait until the match begins

// Cycle..
[] spawn client_fnc_spawn;