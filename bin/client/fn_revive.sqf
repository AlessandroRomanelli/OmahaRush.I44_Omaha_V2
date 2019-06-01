scriptName "fn_revive";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_revive.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_revive.sqf"
if (isServer && !hasInterface) exitWith {};

private _savior = param [0, objNull, [objNull]];
private _adminRevive = param [1, false, [false]];

// Pos
private _pos = getPosATL player;

if (!(_adminRevive) && {!isNull _savior && _pos distance (getPosWorld _savior) > 10}) then {
	_pos = getPosATL _savior;
	private _dir = getDir _savior;
	private _rdist = random 2;
	_pos set [0, (_pos select 0)+sin(_dir)*_rdist];
	_pos set [1, (_pos select 1)+cos(_dir)*_rdist];
};

if (cl_inSpawnMenu) exitWith {};

// Make sure the spawn menu script gets cancelled
cl_revived = true;

uiSleep 0.5;
// Looks like we have been revived :)
setPlayerRespawnTime 0.1;
uiSleep 0.2;

// Set pos
player setPosATL _pos;
player playActionNow "PlayerProne";

// Message
if (!isNull _savior) then {
	[format ["You have been revived by<br/>%1", [_savior] call client_fnc_getUnitName]] call client_fnc_displayInfo;
} else {
	["You have been revived"] call client_fnc_displayInfo;
};

if (!isNil "rr_respawn_thread") then {
	terminate rr_respawn_thread;
};

// Destroy cam
cl_spawnmenu_cam cameraEffect ["TERMINATE","BACK"];
camDestroy cl_spawnmenu_cam;
player switchCamera "INTERNAL";

// Destroy all objects that are left of us
private _objs = nearestObjects [player, ["Man","GroundWeaponHolder", "WeaponHolder"], 5];
{
	deleteVehicle _x;
} forEach _objs;

player setUnitLoadout (player getVariable ["wwr_unit_loadout",[]]);

// Give player all his items
[true] call client_fnc_equipAll;

// Reenable hud
300 cutRsc ["default","PLAIN"];
[] call client_fnc_startIngameGUI;

player setVariable ["isAlive", true];
player setVariable ["grenade_kill", nil];
player setVariable ["wasHS", false];

uiSleep 1;
setPlayerRespawnTime 15;
cl_revived = false;

// Not in spawn menu
cl_inSpawnMenu = false;

// Hold actions
[] call client_fnc_initHoldActions;
