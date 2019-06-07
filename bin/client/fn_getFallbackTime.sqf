scriptName "fn_getFallbackTime";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_getFallbackTime.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getFallbackTime.sqf"

private _oldStage = sv_cur_obj getVariable ["pre_stage", ""];

// If it's the first objective, return the defined fallback time
if (_oldStage isEqualTo "") exitWith {["InitialFallBack", 60] call BIS_fnc_getParamValue};

// 4m/s speed of a player whilst sprinting
private _playerSpeed = 6;

private _oldSpawnPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _oldStage >> "Spawns" >> "defenders" >> "HQSpawn" >> "positionATL");
private _oldObjPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _oldStage >> "Objective" >> "positionATL");
private _newObjPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> (sv_cur_obj getVariable ["cur_stage", "Stage1"]) >> "Objective" >> "positionATL");


private _avgOldPos = [_oldSpawnPos, _oldObjPos] call client_fnc_getSectionCenter;

private _distance = _avgOldPos distance2D _newObjPos;
private _time = _distance/_playerSpeed;
floor _time
