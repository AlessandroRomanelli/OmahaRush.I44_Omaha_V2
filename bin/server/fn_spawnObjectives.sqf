scriptName "fn_spawnObjectives";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnObjectives.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnObjectives.sqf"

//Init array of objects nearby our objectives
private _objects = [];

for "_i" from 1 to 4 do {
	//Get data out of config
	private _class = getText(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> format["Stage%1", _i] >> "Objective" >> "classname");
	private _posATL = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> format["Stage%1", _i] >> "Objective" >> "positionATL");
	private _dir = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> format["Stage%1", _i] >> "Objective" >> "dir");

	//Create object and make it invincible
	private _obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];
	_obj allowDamage false;
	_obj setDir _dir;
	_obj setPosATL _posATL;
	_obj setVehicleLock "LOCKED";
	_obj enableSimulation false;

	missionNamespace setVariable [format["sv_stage%1_obj", _i], _obj];
	private _objective = missionNamespace getVariable (format["sv_stage%1_obj", _i]);
	_objective setVariable ['status', -1, true];
	_objects append (nearestTerrainObjects [_objective, [], 75, false]);
	private _fences = nearestTerrainObjects [_objective, ["FENCE", "WALL"], 75, false];
	_objects = _objects - _fences;
};

// Set active objective
sv_cur_obj = sv_stage1_obj;

// Broadcast
[["sv_stage1_obj","sv_stage2_obj","sv_stage3_obj","sv_stage4_obj","sv_cur_obj"]] spawn server_fnc_updateVars;


//Make objects around objective invincible
{
	_x allowDamage false;
	_x setDamage 0;
} forEach _objects;
