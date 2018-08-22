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
diag_log format["DEBUG: Looking for the earlier stage: %1", _oldStage];
// If it's the first objective, return the defined fallback time
if (_oldStage isEqualTo "") exitWith {paramsArray#8};

// 4m/s speed of a player whilst jogging
private _playerSpeed = 6.5;

_oldStage = ""+_oldStage;
private _oldSpawnPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _oldStage >> "Spawns" >> "defenders");
private _oldObjPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _oldStage >> "Objective" >> "positionATL");
private _newObjPos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Objective" >> "positionATL");

diag_log format["DEBUG: Older spawn position was: %1, older objective position was: %2 and new objective position is: %3", _oldSpawnPos, _oldObjPos, _newObjPos];

private _avgOldPos = [_oldSpawnPos, _oldObjPos] call client_fnc_getSectionCenter;
diag_log format["DEBUG: Calcuated average old position to be: %1", _avgOldPos];

private _distance = _avgOldPos distance2D _newObjPos;
diag_log format["DEBUG: Distance in meters between average old position and new objective position is %1 meters", _distance];
private _time = _distance/_playerSpeed;
diag_log format["DEBUG: Projected time to fallback: %1 seconds", _time];
floor _time
