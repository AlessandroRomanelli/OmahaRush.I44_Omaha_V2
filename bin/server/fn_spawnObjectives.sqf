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
_objects = [];

for "_i" from 0 to 3 do {
	//Get data out of config
	_class = getText(missionConfigFile >> "MapSettings" >> "Stages" >> format["Stage%1", (_i+1)] >> "Objective" >> "classname");
	_posATL = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> format["Stage%1", (_i+1)] >> "Objective" >> "positionATL");
	_dir = getNumber(missionConfigFile >> "MapSettings" >> "Stages" >> format["Stage%1", (_i+1)] >> "Objective" >> "dir");

	//Create object and make it invincible
	_obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];
	_obj allowDamage false;
	_obj setDir _dir;
	_obj setPosATL _posATL;

	missionNamespace setVariable [format["sv_stage%1_obj", (_i+1)], _obj];
	_objective = missionNamespace getVariable (format["sv_stage%1_obj", (_i+1)]);
	_objective setVariable ['status', -1, true];
	_objects append (nearestTerrainObjects [_objective, [], 75, false]);
	_fences = nearestTerrainObjects [_objective, ["FENCE", "WALL"], 75, false];
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
