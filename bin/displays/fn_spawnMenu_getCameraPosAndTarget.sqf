scriptName "fn_spawnMenu_getCameraPosAndTarget";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_getCameraPosAndTarget.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_getCameraPosAndTarget.sqf"
#include "..\utils.h"

#define SPAWNS_LIST_IDC 	8
#define VEHICLES_LIST_IDC	9
#define SPAWNCAM_POLAR 		75
#define HALF_V_FOV			22.5


if (isServer && !hasInterface) exitWith {};

params [["_pos", [0,0,0], [[]]]];

private _target = ((getPosATL sv_cur_obj) vectorAdd _pos) vectorMultiply 0.5;
private _ray = vectorNormalized ((vectorNormalized (_pos vectorDiff _target)) vectorAdd [0,0,tan(SPAWNCAM_POLAR)]);
private _toTarget = _ray vectorMultiply -1;
private _origin = _target vectorAdd _ray;
private _toPos = vectorNormalized (_pos vectorDiff _origin);
private _i = 50;
while {
	_toTarget vectorDotProduct _toPos < cos(HALF_V_FOV)
} do {
	_origin = _target vectorAdd (_ray vectorMultiply _i);
	_toPos = vectorNormalized (_pos vectorDiff _origin);
	_i = _i + 25;
};

[_origin, _target];
