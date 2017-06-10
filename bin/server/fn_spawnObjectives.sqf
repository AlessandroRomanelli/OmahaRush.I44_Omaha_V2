scriptName "fn_spawnObjectives";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnObjectives.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnObjectives.sqf"

// Spawn objective 1
if (true) then {
	_class = getText(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Objective" >> "classname");
	_posATL = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Objective" >> "positionATL");
	_dir = getNumber(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Objective" >> "dir");

	_obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];

	_obj setDir _dir;
	_obj setPosATL _posATL;

	sv_stage1_obj = _obj;
	sv_stage1_obj setVariable ["armed",false,true];
};

// Spawn objective 2
if (true) then {
	_class = getText(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Objective" >> "classname");
	_posATL = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Objective" >> "positionATL");
	_dir = getNumber(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Objective" >> "dir");

	_obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];

	_obj setDir _dir;
	_obj setPosATL _posATL;
	sv_stage2_obj = _obj;
	sv_stage2_obj setVariable ["armed",false,true];
};

// Spawn objective 3
if (true) then {
	_class = getText(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Objective" >> "classname");
	_posATL = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Objective" >> "positionATL");
	_dir = getNumber(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Objective" >> "dir");

	_obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];

	_obj setDir _dir;
	_obj setPosATL _posATL;
	sv_stage3_obj = _obj;
	sv_stage3_obj setVariable ["armed",false,true];
};

// Spawn objective 4
if (true) then {
	_class = getText(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Objective" >> "classname");
	_posATL = getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Objective" >> "positionATL");
	_dir = getNumber(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Objective" >> "dir");

	_obj = createVehicle [_class, _posATL, [], 0, "CAN_COLLIDE"];

	_obj setDir _dir;
	_obj setPosATL _posATL;
	sv_stage4_obj = _obj;
	sv_stage4_obj setVariable ["armed",false,true];
};

// Set active objective
sv_cur_obj = sv_stage1_obj;

// Broadcast
[["sv_stage1_obj","sv_stage2_obj","sv_stage3_obj","sv_stage4_obj","sv_cur_obj"]] spawn server_fnc_updateVars;

// Give objects around the mcom godmode
_objects = nearestTerrainObjects [sv_stage1_obj, [], 75, false];
_objects append (nearestTerrainObjects [sv_stage2_obj, [], 75, false]);
_objects append (nearestTerrainObjects [sv_stage3_obj, [], 75, false]);
_objects append (nearestTerrainObjects [sv_stage4_obj, [], 75, false]);

{
	_x allowDamage false;
	_x setDamage 0;
} forEach _objects;
