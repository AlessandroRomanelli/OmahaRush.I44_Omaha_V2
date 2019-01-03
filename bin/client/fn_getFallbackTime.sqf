scriptName "fn_getFallbackTime";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_getFallbackTime.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getFallbackTime.sqf"

private _oldStage = [] call {
  if ((str sv_cur_obj) isEqualTo (str sv_stage1_obj)) exitWith {""};
  if ((str sv_cur_obj) isEqualTo (str sv_stage2_obj)) exitWith {"Stage1"};
  if ((str sv_cur_obj) isEqualTo (str sv_stage3_obj)) exitWith {"Stage2"};
  if ((str sv_cur_obj) isEqualTo (str sv_stage4_obj)) exitWith {"Stage3"};
};

// If it's the first objective, return the defined fallback time
if (_oldStage isEqualTo "") exitWith {paramsArray#8};

// 4m/s speed of a player whilst sprinting
private _playerSpeed = 6;

_oldStage = ""+_oldStage;
private _oldSpawnPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _oldStage >> "Spawns" >> "defenders" >> "HQSpawn" >> "positionATL");
private _oldObjPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _oldStage >> "Objective" >> "positionATL");
private _newObjPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Objective" >> "positionATL");


private _avgOldPos = [_oldSpawnPos, _oldObjPos] call client_fnc_getSectionCenter;

private _distance = _avgOldPos distance2D _newObjPos;
private _time = _distance/_playerSpeed;
floor _time
