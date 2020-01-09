scriptName "fn_spawnMenu_handleSpawnSelect";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleSpawnSelect.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_handleSpawnSelect.sqf"
#include "..\utils.h"

#define SPAWNS_LIST_IDC 	8
#define VEHICLES_LIST_IDC	9
#define SPAWNCAM_POLAR 		75
#define HALF_V_FOV			22.5


if (isServer && !hasInterface) exitWith {};

diag_log __filename;
diag_log str _this;

params [["_control", controlNull], ["_idx", -1]];

if (isNull _control || _idx == -1) exitWith {false};

private _cam_to_point = {
	params ["_pos"];
	private _cameraSet = [_pos] call displays_fnc_spawnMenu_getCameraPosAndTarget;
	cl_spawnmenu_cam camSetPos (_cameraSet select 0);
	cl_spawnmenu_cam camSetTarget (_cameraSet select 1);
	cl_spawnmenu_cam camCommit 1;

	waitUntil {camCommitted cl_spawnmenu_cam};
};

private _follow_unit = {
	params ["_unit"];
	while {cl_inSpawnMenu && {!isNull _unit} && {alive _unit}} do {
		private _newPos = getPosATL _unit;
		[_newPos] call _cam_to_point;
	};
	TERMINATE_SCRIPT(cl_cam_follow_unit);
};

private _idc = ctrlIDC _control;
private _data = _control lbData _idx;
private _spawnDisplay = findDisplay 5000;

if (_idc == SPAWNS_LIST_IDC) then {
	if ((_control lbValue _idx) == -1) then {
		private _stage = sv_cur_obj getVariable ["cur_stage", "Stage1"];
		if (_stage == "") exitWith {};
		private _newPos = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> _stage >> "Spawns" >> GAMESIDE(player) >> _data >> "positionATL");
		[_newPos] spawn _cam_to_point;
	} else {
		private _unit = objectFromNetId _data;
		TERMINATE_SCRIPT(cl_cam_follow_unit);
		cl_cam_follow_unit = [_unit] spawn _follow_unit;
	};
	(_spawnDisplay displayCtrl VEHICLES_LIST_IDC) lbSetCurSel -1;
};

if (_idc == VEHICLES_LIST_IDC) then {
	private _vehName = _control lbData (lbCurSel _control);
	private _newPos = getPosATL (missionNamespace getVariable [_vehName, objNull]);
	[_newPos] spawn _cam_to_point;
	(_spawnDisplay displayCtrl SPAWNS_LIST_IDC) lbSetCurSel -1;
};


true;
