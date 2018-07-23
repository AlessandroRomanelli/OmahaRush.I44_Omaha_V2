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
	_id = param[0,"",[""]];
	_ret = objNull;
	{
		if (_x getVariable ["id", ""] == _id) then {
			_ret = _x;
		};
	} forEach sv_stageVehicles;
	_ret;
};
sv_stage_deleteNullVehicles = {
	_newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_stageVehicles;
	sv_stageVehicles = _newList;
};
sv_stage_tryRespawn = {
	_v = _this select 0;
	// Terminate old script handling this vehicle
	if (!isNull (_v getVariable ["vehicle_getout_thread", scriptNull])) then {
		terminate (_v getVariable ["vehicle_getout_thread", scriptNull]);
	};
	_scriptHandler = [_v] spawn {
		sleep 30;
		if ({alive _x} count (crew (_this select 0)) == 0 && {{alive _x} count (getPos (_this select 0) nearEntities ["man", 10]) == 0}) then {
			deleteVehicle (_this select 0);
		};
	};

	// Set handler on vehicle
	_v setVariable ["vehicle_getout_thread", _scriptHandler];
};
sv_stage_spawnVehicle = {
	_config = param[0,configNull,[configNull]];
	_initialSpawn = param[1,false,[false]];
	_arrayToEdit = param[2,[],[[]]];
	//diag_log "_0";

	// Vehicle is not being handled yet, handle it now
	sv_stageVehiclesAwaitingRespawn pushBack (configName _config);

	// Wait the respawn time
	_sleepTime = 0;
	if (!_initialSpawn) then {_sleepTime = getNumber(_config >> "respawnTime")};
	sleep _sleepTime;

	//diag_log "_1";

	// Check if there is a old vehicle, if yes, delete it
	_oldVeh = [configName _config] call sv_getVehicleByID;
	if (!isNull _oldVeh) then {
		deleteVehicle _oldVeh;
		[] call sv_deleteNullVehicles;
		//diag_log "__1";
	};

	//diag_log "_2";

	// Create vehicle
	_posATL = getArray(_config >> "positionATL");
	_dir = getNumber(_config >> "dir");
	_vehicle = getText(_config >> "classname") createVehicle _posATL;
	_vehicle enableSimulation false;
	_vehicle setPosATL _posATL;
	_vehicle setDir _dir;
	_vehicle setVariable ["id", configName (_config), true];
	_vehicle setVariable ["config", _config];
	_vehicle enableSimulation true;

	// Clear vehicle
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	// Broadcast to players
	[_vehicle] remoteExec ["client_fnc_vehicleSpawned"];

	// Run init script
	_script = getText(_config >> "script");
	_compiled = compile _script;
	[_vehicle] call _compiled;

	// Pushback into array that holds all vehicles
	sv_stageVehicles pushBack _vehicle;

	// Tell upper script that this vehicle has respawned
	//_arrayToEdit set [1, false];
	{
		if ((_x select 0) == _config) then {
			_x set [1, false];
		};
	} forEach sv_stageVehicleInfo;

	// Vehicle monitoring
	[_vehicle] spawn server_fnc_monitorVehicle;

	// Give vehicle eventhandler if someone gets out
	// Makes sure abandoned vehicles get removed
	/*_vehicle addEventHandler ["GetOut", {
		_v = _this select 0;
		if ({alive _x} count (crew (_this select 0)) > 0) exitWith {};
		if (_v distance (getArray((_v getVariable ["config", configNull]) >> "positionATL")) < 3) exitWith {};
		[_v] spawn sv_stage_tryRespawn;
	}];*/
};
sv_stage_deleteNullThreads = {
	// Delete threads that are currently managing a vehicle respawn that are already over
	_newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_stageVehicleRespawnThreads;

	sv_stageVehicleRespawnThreads = _newList;
};
sv_stage_getCurrentStageVehicleDataIncOld = {
	private["_config","_configs","_included"];
	// Get data of current stage
	_stage = [] call client_fnc_getCurrentStageString;
	_configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	_configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Defender"));

	// Cycle through definitely up to date configs and add them if these vehicles are currently not being monitored
	{
		_config = _x;
		_included = false;
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
	private["_config","_configs","_included"];

	// Get data of current stage
	_stage = [] call client_fnc_getCurrentStageString;
	_configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Attacker");
	_configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Vehicles" >> "Defender"));

	// Return list of configs
	_configs
};

sv_stage_getObsoleteVehiclesAndRemove = {
	private["_config","_obsoleteConfigs"];
	_activeVehicles = +sv_stageVehicleInfo;
	_newVehiclesList = [];
	_neededVehicles = [] call sv_stage_getOnlyCurrentStageVehicleData;
	_obsoluteConfigs = [];
	{
		_config = _x select 0;
		_included = false;
		{
			if (_x == _config) then {
				_included = true;
			};
		} forEach _neededVehicles;

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

	_configs = param[0,[],[[]]];
	_vehicles = [];
	{
		_v = [configName _x] call sv_stage_getVehicleByID;
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
_matchStart = true;
while {sv_gameStatus == 2} do {
	sleep 1;

	// Get vehicles that need to be removed as they are not part of the stage
	_obsoleteConfigs = [] call sv_stage_getObsoleteVehiclesAndRemove;

	// Remove all vehicles that arent part of this stage
	[_obsoleteConfigs] spawn sv_stage_removeObsoleteVehicles;

	// Get all vehicles that should be ingame (this does not remove old ones which are not part of the current stage)
	_currentStageVehicleData = [] call sv_stage_getCurrentStageVehicleDataIncOld;
	{

		// Delete all respawn threads that are null
		[] call sv_stage_deleteNullThreads;

		// Check if vehicle is already respawning
		if (!(_x select 1)) then {
			// Vehicle isnt respawning, check if has been destroyed
			//diag_log "1";
			_v = [configName (_x select 0)] call sv_stage_getVehicleByID;

			if ((isNull _v || !alive _v || !canMove _v) && (isNull (_v getVariable ["vehicle_getout_thread", scriptNull]))) then {
				// Vehicle was ingame destroyed
				_thread = [_x select 0, _matchStart, _x] spawn sv_stage_spawnVehicle;
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
