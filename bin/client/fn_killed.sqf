scriptName "fn_killed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_killed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_killed.sqf"
if (isServer && !hasInterface) exitWith {};

// Create a death camera above our corpse
cl_spawnmenu_cam = "camera" camCreate (getPos player);
cl_spawnmenu_cam cameraEffect ["Internal", "Back"];
cl_spawnmenu_cam camSetFOV .90;
cl_spawnmenu_cam camSetFocus [2, 2];
cl_spawnmenu_cam camCommit 0;

// From body pos to dead cam pos
cl_spawnmenu_cam camPreparePos (getPosATL player);
cl_spawnmenu_cam camPrepareTarget (getPosATL player);
cl_spawnmenu_cam camCommitPrepared 0;

sleep 0.05;
showCinemaBorder false;
cameraEffectEnableHUD true;

// Disable possible flare thread
if (!isNull (missionNamespace getVariable ["cl_reloadFlares_thread", scriptNull])) then {
	terminate cl_reloadFlares_thread;
	285 cutRsc ["default", "PLAIN"];
};

// Move above body
private _pos = player modelToWorld [0.1,0.1,3];
private _targetPos = (getPosATL player);
_targetPos set [2, 0];
cl_spawnmenu_cam camPreparePos _pos;
cl_spawnmenu_cam camPrepareTarget _targetPos;
cl_spawnmenu_cam camCommitPrepared 1;

// Are no alive units left? Send a respawn request to the server
private _vehicle = vehicle player;
if (_vehicle != player) then {
	if ({alive _x} count (crew _vehicle) == 0) then {
		[_vehicle] remoteExec ["sv_tryRespawn", 2];
	};
};

sleep 15;

// Move dead body out of vehicle
if !(isNull objectParent player) then {moveOut player};
sleep 0.1;

// Destroy all objects that are left of us
private _objs = nearestObjects [_pos, ["Man","GroundWeaponHolder", "WeaponHolder"], 5];
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
	sleep 0.5;
	if (!cl_inSpawnMenu || !dialog) then {
		["Player respawned - Backup"] spawn server_fnc_log;
		[format["sv_gameStatus %1 cl_revived %2", sv_gameStatus, cl_revived]] spawn server_fnc_log;
		if (sv_gameStatus == 2 && !cl_revived) then {
			[] spawn client_fnc_spawn;

			player enableStamina false;
			player forceWalk false;
		};
	};
};
