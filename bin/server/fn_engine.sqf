scriptName "fn_engine";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_engine.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_engine.sqf"

["Server engine has been started"] spawn server_fnc_log;

// Server is now ready
sv_serverReady = true;
[["sv_serverReady"]] spawn server_fnc_updateVars;

// Persistent weather
if (getNumber(missionConfigFile >> "GeneralConfig" >> "LoadWeather") == 0) then {
	[] spawn server_fnc_loadPersistentWeather;
	["Persistent weather loaded"] spawn server_fnc_log;
};

// Script monitoring
[] spawn server_fnc_scriptMonitoring;

// Initial start, make sure units requesting time will also not be able to spawn for a certain amount of seconds
sv_fallBack_timeLeft = diag_tickTime + (getNumber(missionConfigFile >> "GeneralConfig" >> "FallBackSeconds"));

// Server engine loop
while {true} do {
	// Kill old threads
	if (!isNil "sv_persistentVehicleManager_thread") then {terminate sv_persistentVehicleManager_thread};
	if (!isNil "sv_stageVehicleManager_thread") then {terminate sv_stageVehicleManager_thread};
	if (!isNil "sv_matchTimer_thread") then {terminate sv_matchTimer_thread};
	if (!isNil "sv_autoTeamBalancer_thread") then {terminate sv_autoTeamBalancer_thread};
	["Old threads have been killed"] spawn server_fnc_log;

	// Get random map from config
	sv_map = [] call server_fnc_getRandomMap;
	["Map has been selected"] spawn server_fnc_log;

	// Delete all objects off the map
	[] call server_fnc_cleanUp;
	["Map has been cleaned"] spawn server_fnc_log;

	// Load weather
	if (getNumber(missionConfigFile >> "GeneralConfig" >> "LoadWeather") == 1) then {
		[] call server_fnc_loadWeather;
		["Weather has been loaded"] spawn server_fnc_log;
	};

	// Spawn in MCOMs
	[] call server_fnc_spawnObjectives;
	["Objectives have been spawned"] spawn server_fnc_log;

	//[] call server_fnc_importantObjects;
	//["Important objects have been restored"] spawn server_fnc_log;

	// Refresh tickets
	[] call server_fnc_refreshTickets;
	["Tickets have been reset"] spawn server_fnc_log;

	// Make a new matchtimer with matchStart param true so it gets broadcasted to all clients
	sv_matchTimer_thread = [true, (getNumber(missionConfigFile >> "GeneralConfig" >> "FallBackSeconds"))] spawn server_fnc_matchTimer;
	["Matchtimer has been started"] spawn server_fnc_log;

	// Map has been selected, broadcast
	sv_gameStatus = 2; // Game may start now
	sv_random_chance = floor random 10 > 4;
	[["sv_map","sv_gameStatus","sv_random_chance"]] spawn server_fnc_updateVars;

	// Start persistent vehicle manager
	if (isClass(missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles")) then {
		sv_persistentVehicleManager_thread = [] spawn server_fnc_persistentVehicleManager;
		["Vehicle manager has been started"] spawn server_fnc_log;
	};

	// Start stage vehicle manager (vehicles that spawn at different locations)
	sv_stageVehicleManager_thread = [] spawn server_fnc_stageVehicleManager;
	["Stage vehicle manager has been started"] spawn server_fnc_log;

	// Start autobalancer (will auto close when the match ends)
	if (getNumber(missionConfigFile >> "GeneralConfig" >> "AutoTeamBalancer") == 1) then {
		sv_autoTeamBalancer_thread = [] spawn server_fnc_autoTeamBalancer;
	};


	waitUntil {sv_gameStatus == 4};
	["Restarting engine..."] spawn server_fnc_log;

	// Count up cycles
	sv_gameCycle = sv_gameCycle + 1;
	[["sv_gameCycle"]] spawn server_fnc_updateVars;
	[format["Cycle %1 has been finished", sv_gameCycle]] spawn server_fnc_log;

	// If we have OnMatchEndRestart enabled, restart the mission rather than just keep running
	if (((getNumber(missionConfigFile >> "GeneralConfig" >> "PerformanceRestart") == 1 && sv_gameCycle >= getNumber(missionConfigFile >> "GeneralConfig" >> "MatchCount")) || ((getNumber(missionConfigFile >> "GeneralConfig" >> "MatchTime") != -1) && (getNumber(missionConfigFile >> "GeneralConfig" >> "MatchTime") <= diag_tickTime))) && isDedicated) then {
		["Attempting to restart mission...."] spawn server_fnc_log;
		sleep 1;
		with uiNamespace do {
			(getText(missionConfigFile >> "GeneralConfig" >> "commandPassword")) serverCommand "#shutdown";
		};
	};
};
