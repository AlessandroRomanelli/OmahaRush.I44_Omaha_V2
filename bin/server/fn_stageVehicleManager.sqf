scriptName "fn_stageVehicleManager";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_stageVehicleManager.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_stageVehicleManager.sqf"

// Get vehicles from config and fetch their data
sv_stageVehicles = [];
sv_stageVehiclesAwaitingRespawn = [];
sv_stageVehicleRespawnThreads = [];
sv_stageVehicleInfo = [];

// Inline functions
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

sv_stage_deleteNullVehicles = {
	private _newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_stageVehicles;
	sv_stageVehicles = _newList;
};

sv_stage_tryRespawn = {
	private _v = param[0, objNull, [objNull]];
	// Terminate old script handling this vehicle
	if (!isNull (_v getVariable ["vehicle_getout_thread", scriptNull])) then {
		terminate (_v getVariable ["vehicle_getout_thread", scriptNull]);
	};
	private _scriptHandler = [_v] spawn {
		sleep 30;
		private _v = param[0, objNull, [objNull]];
		if ((({alive _x} count (crew _v)) == 0) && {{alive _x} count ((getPos _v) nearEntities ["man", 10]) == 0}) then {
			deleteVehicle _v;
		};
	};
	// Set handler on vehicle
	_v setVariable ["vehicle_getout_thread", _scriptHandler];
};

sv_stage_spawnVehicle = {
	params [["_config", configNull,[configNull]], ["_initialSpawn", false,[false]]];

	private _currentPlayers = count allPlayers;
	private _popReq = getNumber(_config >> "populationReq");

	if (_currentPlayers < _popReq) exitWith {};

	// Vehicle is not being handled yet, handle it now
	sv_stageVehiclesAwaitingRespawn pushBack (configName _config);

	// Wait the respawn time
	private _sleepTime = 0;
	if (!_initialSpawn) then {_sleepTime = getNumber(_config >> "respawnTime")};
	sleep _sleepTime;

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
	_vehicle enableSimulation false;
	_vehicle allowDamage false;
	_vehicle setDir _dir;
	_vehicle setPosATL _posATL;
	_vehicle setVariable ["id", configName (_config), true];
	_vehicle setVariable ["config", _config];
	_vehicle enableSimulation true;
	_vehicle allowDamage true;

	// Clear vehicle
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	// Broadcast to players
	[_vehicle] remoteExec ["client_fnc_vehicleSpawned"];

	// Run init script
	private _script = getText(_config >> "script");
	private _compiled = compile _script;
	[_vehicle] call _compiled;

	// Pushback into array that holds all vehicles
	sv_stageVehicles pushBack _vehicle;

	// Tell upper script that this vehicle has respawned
	//_arrayToEdit set [1, false];
	private _vehicleIdx = sv_stageVehicleInfo find _config;
	sv_stageVehicleInfo set [_vehicleIdx, false];

	// Vehicle monitoring
	[_vehicle] spawn server_fnc_monitorVehicle;

};

sv_stage_deleteNullThreads = {
	// Delete threads that are currently managing a vehicle respawn that are already over
	private _newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_stageVehicleRespawnThreads;

	sv_stageVehicleRespawnThreads = _newList;
};

sv_stage_getCurrentStageVehicleDataIncOld = {
	// Get data of current stage
	private _stage = [] call client_fnc_getCurrentStageString;
	private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	private _configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Defender"));

	// Cycle through definitely up to date configs and add them if these vehicles are currently not being monitored
	{
		private _config = _x;
		private _included = false;
		{
			if ((_x select 0) == _config) then {
				_included = true;
			};
		} forEach sv_stageVehicleInfo;

		if (!_included) then {
			sv_stageVehicleInfo pushBack [_x, false];
		};
	} forEach _configs;

	sv_stageVehicleInfo;
};

sv_stage_getOnlyCurrentStageVehicleData = {
	// Get data of current stage
	private _stage = [] call client_fnc_getCurrentStageString;
	private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	private _configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Defender"));

	// Return list of configs
	_configs
};

sv_stage_getObsoleteVehiclesAndRemove = {
	private _activeVehicles = +sv_stageVehicleInfo;
	private _newVehiclesList = [];
	private _neededVehicles = [] call sv_stage_getOnlyCurrentStageVehicleData;
	private _obsoluteConfigs = [];
	{
		private _config = _x select 0;
		private _included = [false, true] select (_config in _neededVehicles);

		if (!_included) then {
			_obsoluteConfigs pushBack _config;
		} else {
			_newVehiclesList pushBack _x;
		};
	} forEach _activeVehicles;

	// Overwrite old array with new data
	sv_stageVehicleInfo = _newVehiclesList;

	_obsoluteConfigs
};

sv_stage_removeObsoleteVehicles = {
	//["Cleaning up obsolete stage vehicles"] spawn server_fnc_log;

	private _configs = param[0,[],[[]]];
	private _vehicles = [];
	{
		private _v = [configName _x] call sv_stage_getVehicleByID;
		if (!isNull _v) then {
			_vehicles pushBack _v;
		};
	} forEach _configs;

	// Loop and just check if people are still in there, if no, delete them
	while {{!isNull _x} count _vehicles > 0} do {
		sleep 10;
		{
			if ({alive _x} count (crew _x) == 0) then {
				deleteVehicle _x;
			};
		} forEach _vehicles;
	};

	//["All obsolete stage vehicles have been deleted"] spawn server_fnc_log;
};

// Main brain of this script
private _matchStart = true;
while {sv_gameStatus == 2} do {
	sleep 1;

	// Get vehicles that need to be removed as they are not part of the stage
	private _obsoleteConfigs = [] call sv_stage_getObsoleteVehiclesAndRemove;

	// Remove all vehicles that arent part of this stage
	[_obsoleteConfigs] spawn sv_stage_removeObsoleteVehicles;

	// Get all vehicles that should be ingame (this does not remove old ones which are not part of the current stage)
	private _currentStageVehicleData = [] call sv_stage_getCurrentStageVehicleDataIncOld;

	// Delete all respawn threads that are null
	[] call sv_stage_deleteNullThreads;

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
				private _thread = [_x select 0, _matchStart, _x] spawn sv_stage_spawnVehicle;
				_x set [1, true];
				sv_stageVehicleRespawnThreads pushBack _thread;
			} else {
				if (canMove _v) then {
					_v setVariable ["disabled", nil];
				};
			};
		};
	} forEach _currentStageVehicleData;
	_matchStart = false;
};
