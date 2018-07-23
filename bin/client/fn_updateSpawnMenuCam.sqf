scriptName "fn_updateSpawnMenuCam";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_updateSpawnMenuCam.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateSpawnMenuCam.sqf"

if (!cl_inSpawnMenu) exitWith {};
if (isNil "cl_spawnmenu_cam") exitWith {hint "1"};
if (isNull cl_spawnmenu_cam) exitWith {hint "2"};

// Get cam pos for spawn menu cam
_stage = "null";
while {_stage == "null"} do {
	_stage = [] call client_fnc_getCurrentStageString;
};
_side = if (player getVariable "gameSide" == "defenders") then {"defenders"} else {"attackers"};
_pos = getArray(missionConfigFile >> "MapSettings" >> "Stages" >> _stage >> "Spawns" >> _side);

// Determine point between current pos and target pos
_targetPos = [_pos,getPos sv_cur_obj] call client_fnc_getSectionCenter;

// Set cam pos height
_pos set[2, 400];

// Commit
cl_spawnmenu_cam camPreparePos _pos;
cl_spawnmenu_cam camPrepareTarget _targetPos;

cl_spawnmenu_cam camCommitPrepared 1.5;
