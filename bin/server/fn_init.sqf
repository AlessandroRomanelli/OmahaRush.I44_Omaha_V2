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

["================== RUSH REDUX SERVER START =================="] spawn server_fnc_log;

// Dedicated environment?
sv_dedicatedEnvironment = isDedicated;
[format ["Dedicated Environment: %1", sv_dedicatedEnvironment]] spawn server_fnc_log;

// Very first server start
sv_serverReady = false; // Waiting for server to be ready
sv_gameStatus = 1; // Waiting for map selection
sv_gameCycle = 0;
sv_db_connected = false;

// Init Groups
["Initialize", [false, 5]] call BIS_fnc_dynamicGroups;
["Groups initialized"] spawn server_fnc_log;

// Initialize Database Connection
if (("extDB2" callExtension "9:VERSION") != "") then {
	["Attempting to connect to database"] spawn server_fnc_log;
	[] spawn server_fnc_db_connect;
	waitUntil {sv_db_connected};
	["Successfully connected to database"] spawn server_fnc_log;

	sv_usingDatabase = true;
} else {
	sv_usingDatabase = false;
};

[format ["Connected to database: %1", sv_usingDatabase]] spawn server_fnc_log;

// Publish variables
[["sv_serverReady","sv_gameStatus","sv_gameCycle","sv_dedicatedEnvironment","sv_usingDatabase"]] spawn server_fnc_updateVars;

// Start Main Loop
sv_engine_thread = [] spawn server_fnc_engine;
