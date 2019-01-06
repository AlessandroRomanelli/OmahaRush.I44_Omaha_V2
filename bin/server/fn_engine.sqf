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

private _fallBackTime = ["InitialFallBack", 60] call BIS_fnc_getParamValue;

// Server is now ready
sv_serverReady = true;
[["sv_serverReady"]] spawn server_fnc_updateVars;

// Persistent weather
private _mapWeather = ["MapWeather", 0] call BIS_fnc_getParamValue;
if (_mapWeather == 0) then {
	[] spawn server_fnc_loadPersistentWeather;
	["Persistent weather loaded"] spawn server_fnc_log;
};

// Script monitoring
[] spawn server_fnc_scriptMonitoring;

// Initial start, make sure units requesting time will also not be able to spawn for a certain amount of seconds
/* sv_fallBack_timeLeft = diag_tickTime + _fallBackTime; */

// Server engine loop
while {true} do {
	// Kill old threads
	if (!isNil "sv_persistentVehicleManager_thread") then {terminate sv_persistentVehicleManager_thread};
	if (!isNil "sv_stageVehicleManager_thread") then {terminate sv_stageVehicleManager_thread};
	if (!isNil "sv_matchTimer_thread") then {terminate sv_matchTimer_thread};
	if (!isNil "sv_autoTeamBalancer_thread") then {terminate sv_autoTeamBalancer_thread};
	["Old threads have been killed"] spawn server_fnc_log;

	// Get random map from config
	if (sv_gameCycle % 2 == 0) then {
		sv_mapSize = [] call server_fnc_decideMapSize;
		publicVariable "sv_mapSize";
	};
	/* ["Map has been selected"] spawn server_fnc_log; */

	// Delete all objects off the map
	[] call server_fnc_cleanUp;
	["Map has been cleaned"] spawn server_fnc_log;

	// Load weather
	if (_mapWeather == 1) then {
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
 	/* debug_players = 0;
	debug_ready_players = 0;
	waitUntil{debug_players >= 4};
	waitUntil{debug_ready_players >= round(debug_players*0.8)}; */
	if (isDedicated && sv_gameCycle == 0) then {
		waitUntil{(playersNumber WEST + playersNumber INDEPENDENT) >= 4};
		private _then = diag_tickTime;
		waitUntil{(diag_tickTime - _then >= 60) || ({_x getVariable ["playerInitOK", false]} count allPlayers > round ((playersNumber WEST + playersNumber INDEPENDENT)*0.8))};
	};

	// Make a new matchtimer with matchStart param true so it gets broadcasted to all clients
	sv_matchTimer_thread = [true, _fallBackTime] spawn server_fnc_matchTimer;
	["Matchtimer has been started"] spawn server_fnc_log;

	// Map has been selected, broadcast
	sv_gameStatus = 2; // Game may start now
	[["sv_gameStatus"]] spawn server_fnc_updateVars;

	// Start persistent vehicle manager
	if (isClass(missionConfigFile >> "MapSettings" >> sv_mapSize >> "PersistentVehicles")) then {
		sv_persistentVehicleManager_thread = [] spawn server_fnc_persistentVehicleManager;
		["Persistent vehicles manager has been started"] spawn server_fnc_log;
	};

	// Start stage vehicle manager (vehicles that spawn at different locations)
	sv_stageVehicleManager_thread = [] spawn server_fnc_stageVehicleManager;
	["Stage vehicles manager has been started"] spawn server_fnc_log;

	// Start autobalancer (will auto close when the match ends)
	if ((["AutoTeamBalancer", 1] call BIS_fnc_getParamValue) == 1) then {
		sv_autoTeamBalancer_thread = [] spawn server_fnc_autoTeamBalancer;
	};


	waitUntil {sv_gameStatus == 4};
	["Restarting engine..."] spawn server_fnc_log;

	// Count up cycles
	sv_gameCycle = sv_gameCycle + 1;
	[["sv_gameCycle"]] spawn server_fnc_updateVars;
	[format["Cycle %1 has been finished", sv_gameCycle]] spawn server_fnc_log;

	// If we have OnMatchEndRestart enabled, restart the mission rather than just keep running
	private _maxMatchTime = ["MaxMatchDuration", 10800] call BIS_fnc_getParamValue;
	if (((sv_gameCycle >= (["RotationsPerMatch", 2] call BIS_fnc_getParamValue)) || ((_maxMatchTime != -1) && (_maxMatchTime <= diag_tickTime))) && isDedicated) then {
		["Attempting to restart mission...."] spawn server_fnc_log;
		sleep 1;
		with uiNamespace do {
			private _missions = getArray(missionConfigFile >> "GeneralConfig" >> "mapsPool");
			private _currentMission = [format["%1.%2", missionName, worldName]];
			private _missionsPool = _missions - _currentMission;
			(getText(missionConfigFile >> "GeneralConfig" >> "commandPassword")) serverCommand format["#mission %1 custom", selectRandom _missionsPool];
		};
	};
};
