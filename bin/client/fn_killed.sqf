scriptName "fn_killed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_killed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_killed.sqf"
#define CAM_DIST 2
#define pm_random(x) random [-x, 0, x]
if (isServer && !hasInterface) exitWith {};

params [["_killer", objNull, [objNull]]];

if (!isNil "cl_killcam_thread") then {
	terminate cl_killcam_thread;
};

cl_killcam_thread = [_killer] spawn {
	params [["_killer", objNull, [objNull]]];
	// Create a death camera above our corpse
	cl_spawnmenu_cam = "camera" camCreate (ASLtoATL (eyePos player));
	cl_spawnmenu_cam cameraEffect ["Internal", "BACK"];
	cl_spawnmenu_cam camSetFOV 0.75;
	cl_spawnmenu_cam camSetTarget player;
	cl_spawnmenu_cam camSetFocus [2, 2];
	cl_spawnmenu_cam camCommit 0;

	showCinemaBorder false;
	cameraEffectEnableHUD true;

	// From body pos to dead cam pos
	private _vector = [pm_random(CAM_DIST), pm_random(CAM_DIST), 0];
	private _intersections = lineIntersectsSurfaces [getPosASL player, ((getPosASL cl_spawnmenu_cam) vectorAdd _vector), player];
	while {(vectorMagnitude _vector < 5) && {(count _intersections) == 0}} do {
		_vector = _vector vectorAdd [0,0,0.25];
		_intersections = lineIntersectsSurfaces [getPosASL player, ((getPosASL cl_spawnmenu_cam) vectorAdd _vector), player];
	};
	cl_spawnmenu_cam camSetRelPos _vector;
	cl_spawnmenu_cam camCommit 2;
	uiSleep 3;
	if (cl_inSpawnMenu) exitWith {
		cl_killcam_thread = nil;
	};
	private _fnc_zoomAway = {
		cl_spawnmenu_cam camSetRelPos [0,0,50];
		cl_spawnmenu_cam camCommit 13;
		399 cutText ["", "BLACK OUT", 10];
		waitUntil { cl_inSpawnMenu || {camCommitted cl_spawnmenu_cam} || {player getVariable ["isAlive", false]} };
		399 cutText ["","PLAIN", 0];
	};

	if (isNull _killer || {_killer isEqualTo player}) exitWith {
		[] call _fnc_zoomAway;
	};

	if ((["FoeStatsEnabled", 1] call BIS_fnc_getParamValue) == 1) then {
		[_killer] spawn client_fnc_displayKillcam;
	};


	if ((["KillcamEnabled", 1] call BIS_fnc_getParamValue) == 0) then {
		[] call _fnc_zoomAway;
	};

	cl_spawnmenu_cam camSetTarget _killer;
	cl_spawnmenu_cam camCommit 2;
	waitUntil { camCommitted cl_spawnmenu_cam };
	if (cl_inSpawnMenu) exitWith {
		cl_killcam_thread = nil;
	};

	private _fnc_computeOffset = {
		params ["_unit"];
		private _stance = stance _unit;
		if (_stance isEqualTo "STAND") exitWith {1.5};
		if (_stance isEqualTo "CROUCH") exitWith {0.75};
		if (_stance isEqualTo "PRONE") exitWith {0.25};
		0
	};

	while {!cl_inSpawnMenu || !dialog} do {
		private _dist = player distance _killer;
		private _fov = if (_dist > 10) then {(750/(_dist^3)) max 0.025} else {0.75};
		private _targetPos = (getPosATL _killer) vectorAdd [0,0, [_killer] call _fnc_computeOffset];
		cl_spawnmenu_cam camSetTarget _targetPos;
		cl_spawnmenu_cam camSetFOV _fov;
		cl_spawnmenu_cam camSetFocus [round _dist, 0];
		cl_spawnmenu_cam camCommit 0.25;
		waitUntil { camCommitted cl_spawnmenu_cam };
	};
	cl_spawnmenu_cam camSetFov .9;
	cl_spawnmenu_cam camSetFocus [150, 1];
	cl_spawnmenu_cam camCommit 0.25;
	cl_killcam_thread = nil;
};




// Disable possible flare thread
if (!isNull (missionNamespace getVariable ["cl_reloadFlares_thread", scriptNull])) then {
	terminate cl_reloadFlares_thread;
	285 cutRsc ["default", "PLAIN"];
};

// Are no alive units left? Send a respawn request to the server
private _vehicle = vehicle player;
if (_vehicle != player) then {
	if ({alive _x} count (crew _vehicle) == 0) then {
		[_vehicle] remoteExec ["sv_tryRespawn", 2];
	};
};

uiSleep 3;

// Move dead body out of vehicle
if !(isNull objectParent player) then {moveOut player};

uiSleep 12;

// Destroy all objects that are left of us
private _objs = nearestObjects [getPos player, ["Man","GroundWeaponHolder", "WeaponHolder"], 5];
{
	deleteVehicle _x;
} forEach _objs;

// Reduce ticket count if we are an attacker
if (player getVariable "gameSide" == "attackers") then {
	private _isObjArmed = sv_cur_obj getVariable ["status", -1] == 1;
	if (sv_tickets > 0 && !(_isObjArmed)) then {
		sv_tickets = sv_tickets - 1;
		publicVariable "sv_tickets";

		if (sv_tickets <= 0) then {
			// Trigger lose
			[] remoteExec ["server_fnc_endRound",2];
		};
	};

	// DEAD CHECK
	// Sometimes the respawn handler doesnt fire so we have to manuall check here if it did!
	uiSleep 0.5;
	if (!cl_inSpawnMenu || !dialog) then {
		["Player respawned - Backup"] call server_fnc_log;
		[format["sv_gameStatus %1 cl_revived %2", sv_gameStatus, cl_revived]] call server_fnc_log;
		if (sv_gameStatus == 2 && !cl_revived) then {

			player enableStamina false;
			player forceWalk false;
			[] call client_fnc_spawn;
		};
	};
};

rr_respawn_thread = nil;
