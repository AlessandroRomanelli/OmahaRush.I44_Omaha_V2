scriptName "fn_init";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_init.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_init.sqf"

// Not the server?
if (!isServer) exitWith {};

["================== RUSH REDUX SERVER START =================="] call server_fnc_log;

// Dedicated environment?
sv_dedicatedEnvironment = isDedicated;
[format ["Dedicated Environment: %1", sv_dedicatedEnvironment]] call server_fnc_log;

// Very first server start
sv_serverReady = false; // Waiting for server to be ready
sv_gameStatus = 1; // Waiting for map selection
sv_gameCycle = 0;

// Init Groups
["Initialize", [false, 5]] call BIS_fnc_dynamicGroups;
["Groups initialized"] call server_fnc_log;

sv_usingDatabase = false;

[format ["Connected to database: %1", sv_usingDatabase]] call server_fnc_log;

// Publish variables
[["sv_serverReady","sv_gameStatus","sv_gameCycle","sv_dedicatedEnvironment","sv_usingDatabase"]] call server_fnc_updateVars;

// Start Main Loop
[] call server_fnc_engine;
