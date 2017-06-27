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
_configs = "true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Attacker");
_configs = _configs + ("true" configClasses (missionConfigFile >> "Maps" >> sv_map >> "PersistentVehicles" >> "Defender"));

// Pushback into main array
{
	// _config, isRespawning
	sv_persistentVehicleData pushBack [_x, false];
} forEach _configs;

// Inline functions
sv_getVehicleByID = {
	_id = param[0,"",[""]];
	_ret = objNull;
	{
		if (_x getVariable ["id", ""] == _id) then {
			_ret = _x;
		};
	} forEach sv_persistentVehicles;
	_ret;
};
sv_deleteNullVehicles = {
	_newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_persistentVehicles;
	sv_persistentVehicles = _newList;
};
sv_tryRespawn = {
	_v = _this select 0;
	// Terminate old script handling this vehicle
	if (!isNull (_v getVariable ["vehicle_getout_thread", scriptNull])) then {
		terminate (_v getVariable ["vehicle_getout_thread", scriptNull]);
	};
	_scriptHandler = [_v] spawn {
		sleep 30;
		if ({alive _x} count (crew (_this select 0)) == 0 && {alive _x} count (getPos (_this select 0) nearEntities ["man", 10]) == 0) then {
			deleteVehicle (_this select 0);
		};
	};

	// Set handler on vehicle
	_v setVariable ["vehicle_getout_thread", _scriptHandler];
};
sv_spawnVehicle = {
	_config = param[0,configNull,[configNull]];
	_initialSpawn = param[1,false,[false]];
	_arrayToEdit = param[2,[],[[]]];
	//diag_log "_0";

	// Vehicle is not being handled yet, handle it now
	sv_persistentVehiclesAwaitingRespawn pushBack (configName _config);

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
	_vehicle = createVehicle [getText(_config >> "classname"), _posATL, [], _dir, "CAN_COLLIDE"];
	_vehicle setPosATL _posATL;
	_vehicle setDir _dir;
	_vehicle setVariable ["id", configName (_config), true];
	_vehicle setVariable ["config", _config];

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
	sv_persistentVehicles pushBack _vehicle;

	// Tell upper script that this vehicle has respawned
	_arrayToEdit set [1, false];

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
sv_deleteNullThreads = {
	_newList = [];
	{
		if (!isNull _x) then {
			_newList pushBack _x;
		};
	} forEach sv_persistentVehicleRespawnThreads;

	sv_persistentVehicleRespawnThreads = _newList;
};

// Main brain of this script
_matchStart = true;
while {sv_gameStatus == 2} do {
	sleep 1;
	{
		// Delete all respawn threads that are null
		[] call sv_deleteNullThreads;

		// Check if vehicle is already respawning
		if (!(_x select 1)) then {
			// Vehicle isnt respawning, check if has been destroyed
			//diag_log "1";
			_v = [configName (_x select 0)] call sv_getVehicleByID;

			if (isNull _v || !alive _v || !canMove _v) then {
				//diag_log "2";
				// Vehicle was ingame destroyed
				_thread = [_x select 0, _matchStart, _x] spawn sv_spawnVehicle;
				_x set [1, true];

				sv_persistentVehicleRespawnThreads pushBack _thread;
			} else {
				if (canMove _v) then {
					_v setVariable ["disabled", nil];
				};
			};
		};
	} forEach sv_persistentVehicleData;
	_matchStart = false;
};