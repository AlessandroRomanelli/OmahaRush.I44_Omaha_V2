scriptName "fn_persistentVehicleManager";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_persistentVehicleManager.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_persistentVehicleManager.sqf"

// Get vehicles from config and fetch their data
sv_persistentVehicleData = [];
sv_persistentVehicles = [];
sv_persistentVehiclesAwaitingRespawn = [];
sv_persistentVehicleRespawnThreads = [];

// Get vehicle configs from both attacker and defender
private _configs = "true" configClasses (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> "Attacker");
private _configs = _configs + ("true" configClasses (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> "Defender"));

// Pushback into main array
{
	// _config, isRespawning
	sv_persistentVehicleData pushBack [_x, false];
} forEach _configs;

// Inline functions
sv_getVehicleByID = {
	private _id = param[0,"",[""]];
	private _ret = objNull;
	{
		if (_x getVariable ["id", ""] == _id) then {
			_ret = _x;
		};
	} forEach sv_persistentVehicles;
	_ret;
};
sv_deleteNullVehicles = {
	private _newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_persistentVehicles;
	sv_persistentVehicles = _newList;
};

sv_tryRespawn = {
	private _v = _this select 0;
	// Terminate old script handling this vehicle
	if (!isNull (_v getVariable ["vehicle_getout_thread", scriptNull])) then {
		terminate (_v getVariable ["vehicle_getout_thread", scriptNull]);
	};
	private _scriptHandler = [_v] spawn {
		private _veh = param[0, objNull, [objNull]];
		sleep 10;
		if ((({alive _x} count (crew _veh)) == 0) && {({alive _x} count ((getPos _veh) nearEntities ["man", 10])) == 0}) then {
			deleteVehicle _veh;
		};
	};
	// Set handler on vehicle
	_v setVariable ["vehicle_getout_thread", _scriptHandler];
};

private _sv_spawnVehicle = {
	private _config = param[0,configNull,[configNull]];
	/* private _initialSpawn = param[1,false,[false]]; */
	private _arrayToEdit = param[2,[],[[]]];
	//diag_log "_0";

	// Vehicle is not being handled yet, handle it now
	sv_persistentVehiclesAwaitingRespawn pushBack (configName _config);

	// Wait the respawn time
	private _sleepTime = getNumber(_config >> "respawnTime");
	diag_log format["DEBUG: Call will wait for %1 seconds before proceeding", _sleepTime];
	/* if (!_initialSpawn) then {_sleepTime = getNumber(_config >> "respawnTime")}; */
	sleep _sleepTime;

	//diag_log "_1";

	// Check if there is a old vehicle, if yes, delete it
	private _oldVeh = [configName _config] call sv_getVehicleByID;
	if (!isNull _oldVeh) then {
		deleteVehicle _oldVeh;
		[] call sv_deleteNullVehicles;
		//diag_log "__1";
	};

	//diag_log "_2";

	// Create vehicle
	private _posATL = getArray(_config >> "positionATL");
	private _dir = getNumber(_config >> "dir");
	private _className = getText(_config >> "classname");
	private _vehicle = objNull;
	if (_className isKindOf "Air") then {
		_vehicle = createVehicle [_className, [-200,-200,0], [], 200, "FLY"];
		_dir = _posATL getDir (getPos sv_cur_obj);
		diag_log format["DEBUG: Creating vehicle of class %1, at posATL: %2, dir: %3", _className, _posATL, _dir];
		private _velocity = [(sin _dir)*55, (cos _dir)*55, 0];
		_vehicle setDir _dir;
		_vehicle setPosATL _posATL;
		_vehicle setVelocity _velocity;
		_vehicle enableSimulationGlobal false;
		diag_log format["DEBUG: Simulation for vehicle disabled, currently at: %1, should be at: %2", getPos _vehicle, _posATL];
	} else {
		_vehicle = createVehicle [_className, [-200,-200,0], [], 200, "CAN_COLLIDE"];
		_vehicle setDir _dir;
		_vehicle setPosATL _posATL;
	};
	_vehicle setVariable ["id", configName (_config), true];
	_vehicle setVariable ["config", _config];

	// Clear vehicle
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	// Broadcast to players
	/* [_vehicle] remoteExec ["client_fnc_vehicleSpawned"]; */

	// Run init script
	private _script = getText(_config >> "script");
	private _compiled = compile _script;
	[_vehicle] call _compiled;

	// Pushback into array that holds all vehicles
	sv_persistentVehicles pushBack _vehicle;

	// Tell upper script that this vehicle has respawned
	_arrayToEdit set [1, false];

	private _idx = sv_persistentVehicleData findIf {(_x select 0) isEqualTo _config};
	diag_log format["Searched sv_persistentVehicleData, found a match at index: %1, replacing it with %2", _idx, _arrayToEdit];
	sv_persistentVehicleData set [_idx, _arrayToEdit];

	// Vehicle monitoring
	[_vehicle] spawn server_fnc_monitorVehicle;

	//diag_log "_3";

	// Give vehicle eventhandler if someone gets out
	// Makes sure abandoned vehicles get removed
	/*_vehicle addEventHandler ["GetOut", {
		_v = _this select 0;
		if ({alive _x} count (crew (_this select 0)) > 0) exitWith {};
		if (_v distance (getArray((_v getVariable ["config", configNull]) >> "positionATL")) < 3) exitWith {};
		[_v] spawn sv_tryRespawn;
	}];*/
};

private _sv_deleteNullThreads = {
	private _newList = sv_persistentVehicleRespawnThreads select {!isNull _x};
	sv_persistentVehicleRespawnThreads = _newList;
};

// Main brain of this script
private _matchStart = true;
while {sv_gameStatus == 2} do {
	sleep 1;
	// Delete all respawn threads that are null
	[] call _sv_deleteNullThreads;
	{
		private _config = _x select 0;
		private _isRespawning = _x select 1;
		// Check if vehicle is already respawning
		if (!_isRespawning) then {
			diag_log format["DEBUG: Attempting to spawn vehicle with ID: %1", configName _config];
			// Vehicle isnt respawning, check if has been destroyed
			private _v = [configName _config] call sv_getVehicleByID;

			if (isNull _v || !alive _v || !canMove _v) then {
				private _populationReq = getNumber(_config >> "populationReq");
				if (count allPlayers > _populationReq) then {
					diag_log format["DEBUG: Enough more than %1 players were connected, spawn allowed", _populationReq];
					// Vehicle was ingame destroyed
					private _thread = [_config, _matchStart, _x] spawn _sv_spawnVehicle;
					_x set [1, true];
					sv_persistentVehicleRespawnThreads pushBack _thread;
				};
			};
		};
	} forEach sv_persistentVehicleData;
	_matchStart = false;
};
