scriptName "fn_stageVehicleManager";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_stageVehicleManager.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_stageVehicleManager.sqf"
#include "..\utils.h"

// Get vehicles from config and fetch their data
sv_stageVehicles = [];
sv_stageVehiclesAwaitingRespawn = [];
sv_stageVehicleRespawnThreads = [];
sv_stageVehicleInfo = [];

// Inline functions

// Getter for vehicle with same ID of the query
sv_stage_getVehicleByID = {
	private _id = param[0,"",[""]];
	private _ret = objNull;
	{
		if (_x getVariable ["id", ""] == _id) then {
			_ret = _x;
		};
	} forEach sv_stageVehicles;
	_ret;
};

private _sv_stage_spawnVehicle = {
	params [["_config", configNull,[configNull]], ["_initialSpawn", false,[false]]];

	private _className = configName _config;
	private _currentPlayers = count allPlayers;
	private _popReq = getNumber(_config >> "populationReq");

	VARIABLE_DEFAULT(sv_setting_DebugMode, 0);
	private _isDebug = sv_setting_DebugMode == 1;

	if (!_isDebug && {_currentPlayers < _popReq}) exitWith {};

	// Vehicle is not being handled yet, handle it now
	sv_stageVehiclesAwaitingRespawn pushBack (configName _config);

	// Wait the respawn time
	private _sleepTime = 0;
	if (!_initialSpawn) then {_sleepTime = getNumber(_config >> "respawnTime")};
	uiSleep _sleepTime;

	// Check if there is a old vehicle, if yes, delete it
	private _oldVeh = [configName _config] call sv_getVehicleByID;
	if (!isNull _oldVeh) then {
		deleteVehicle _oldVeh;
		[] call sv_deleteNullVehicles;
	};

	// Create vehicle
	private _posATL = getArray(_config >> "positionATL");
	private _dir = getNumber(_config >> "dir");
	private _vehicle = createVehicle [getText(_config >> "classname"), [-200,-200,0], [], 200, "CAN_COLLIDE"];
	_vehicle enableSimulationGlobal false;
	_vehicle allowDamage false;
	_vehicle setDir _dir;
	_vehicle setPosATL _posATL;
	_vehicle setVariable ["id", configName (_config)];
	_vehicle setVariable ["config", _config];
	_vehicle enableSimulationGlobal true;
	_vehicle allowDamage true;

	// Clear vehicle
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	// Broadcast to players
	/* [_vehicle] remoteExec ["client_fnc_vehicleSpawned"]; */

	// Run init script
	private _script = getText(_config >> "script");
	if (_script != "") then {
		private _compiled = compile _script;
		[_vehicle] call _compiled;
	};

	// Set texture
	private _variant = getText(_config >> "variant");
	if (_variant != "") then {
		private _textures = getArray(configFile >> "CfgVehicles" >> typeOf _vehicle >> "textureSources" >> _variant >> "textures");
		{
		    _vehicle setObjectTextureGlobal [_forEachIndex, _x];
		} forEach _textures;
	};

	missionNamespace setVariable [_className, _vehicle, true];

	// Pushback into array that holds all vehicles
	sv_stageVehicles pushBack _vehicle;

	// Tell upper script that this vehicle has respawned
	//_arrayToEdit set [1, false];
	private _vehicleIdx = sv_stageVehicleInfo findif {(_x select 0) isEqualTo _config};
	if (_vehicleIdx != -1) then {
		private _entry = sv_stageVehicleInfo select _vehicleIdx;
		_entry set [1, false];
		sv_stageVehicleInfo set [_vehicleIdx, _entry];
	};

	// Vehicle monitoring
	[_vehicle] spawn server_fnc_monitorVehicle;

};

private _sv_stage_deleteNullThreads = {
	// Delete threads that are currently managing a vehicle respawn that are already over
	private _newList = sv_stageVehicleRespawnThreads select {!isNull _x};
	sv_stageVehicleRespawnThreads = _newList;
	sv_stageVehicleRespawnThreads
};

private _sv_stage_getCurrentStageVehicleDataIncOld = {
	// Get data of current stage
	private _stage = sv_cur_obj getVariable ["cur_stage", "Stage1"];
	private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	_configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Vehicles" >> "Defender"));
	// Cycle through definitely up to date configs and add them if these vehicles are currently not being monitored
	{
		private _config = _x;
		private _idx = sv_stageVehicleInfo findIf {(_x select 0) isEqualTo _config};
		if (_idx == -1) then {
			sv_stageVehicleInfo pushBack [_x, false];
		};
	} forEach _configs;
	sv_stageVehicleInfo;
};

private _sv_stage_getOnlyCurrentStageVehicleData = {
	// Get data of current stage
	private _stage = sv_cur_obj getVariable ["cur_stage", "Stage1"];
	private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	private _configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Vehicles" >> "Defender"));

	// Return list of configs
	_configs
};

private _sv_stage_getObsoleteVehiclesAndRemove = {
	private _activeVehicles = +sv_stageVehicleInfo;
	private _neededVehicles = [] call _sv_stage_getOnlyCurrentStageVehicleData;
	private _newVehiclesList = _activeVehicles select {
		private _config = _x select 0;
		if (_config in _neededVehicles) then {true};
	};
	private _obsoluteConfigs = _activeVehicles - _newVehiclesList;

	// Overwrite old array with new data
	sv_stageVehicleInfo = _newVehiclesList;
	_obsoluteConfigs
};

private _sv_stage_removeObsoleteVehicles = {
	//["Cleaning up obsolete stage vehicles"] spawn server_fnc_log;

	private _configs = param[0,[],[[]]];
	private _vehicles = [];
	{
		private _v = [configName (_x select 0)] call sv_stage_getVehicleByID;
		if (!isNull _v) then {
			_vehicles pushBack _v;
		};
	} forEach _configs;

	// Loop and just check if people are still in there, if no, delete them
	while {{!isNull _x} count _vehicles > 0} do {
		private _emptyVehicles = _vehicles select {if (({alive _x} count (crew _x)) == 0) then {true}};
		{_x setVehicleLock "LOCKED"} forEach _emptyVehicles;
		uiSleep 10;
		{deleteVehicle _x} forEach _emptyVehicles;
	};

	//["All obsolete stage vehicles have been deleted"] spawn server_fnc_log;
};

// Main brain of this script
private _matchStart = true;
while {sv_gameStatus == 2} do {
	uiSleep 1;

	// Get vehicles that need to be removed as they are not part of the stage
	private _obsoleteConfigs = [] call _sv_stage_getObsoleteVehiclesAndRemove;

	// Remove all vehicles that arent part of this stage
	[_obsoleteConfigs] spawn _sv_stage_removeObsoleteVehicles;

	// Get all vehicles that should be ingame (this does not remove old ones which are not part of the current stage)
	private _currentStageVehicleData = [] call _sv_stage_getCurrentStageVehicleDataIncOld;

	// Delete all respawn threads that are null
	[] call _sv_stage_deleteNullThreads;

	{
		private _config = _x select 0;
		private _isRespawning = _x select 1;
		// Check if vehicle is already respawning
		if (!_isRespawning) then {
			// Vehicle isnt respawning, check if has been destroyed
			//diag_log "1";
			private _v = [configName _config] call sv_stage_getVehicleByID;

			if ((isNull _v || !alive _v || !canMove _v) && (isNull (_v getVariable ["vehicle_getout_thread", scriptNull]))) then {
				// Vehicle was ingame destroyed
				private _thread = [_config, _matchStart, _x] spawn _sv_stage_spawnVehicle;
				_x set [1, true];
				sv_stageVehicleRespawnThreads pushBack _thread;
			};
		};
	} forEach _currentStageVehicleData;
	_matchStart = false;
};
