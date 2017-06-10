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

// Pos
_pos = getPosATL player;

// Make sure the spawn menu script gets cancelled
cl_revived = true;

// Looks like we have been revived :)
setPlayerRespawnTime 0.1;
sleep 0.2;

// Set pos
player setPosATL _pos;

// Message
["You have been revived"] spawn client_fnc_displayInfo;

// Lets get back our weapons + one mag which was in the old weapon
[true] spawn client_fnc_equipWeapons;

if (!isNil "rr_respawn_thread") then {
	terminate rr_respawn_thread;
};

// Destroy cam
cl_spawnmenu_cam cameraEffect ["TERMINATE","BACK"];
camDestroy cl_spawnmenu_cam;
player switchCamera "INTERNAL";

// Destroy all objects that are left of us
_objs = nearestObjects [player, ["Man","GroundWeaponHolder", "WeaponHolder"], 5];
{
	deleteVehicle _x;
} forEach _objs;

// Give player all his items
[] spawn client_fnc_equipAll;

// Reenable hud
300 cutRsc ["default","PLAIN"];
cl_gui_thread = [] spawn client_fnc_startIngameGUI;

sleep 1;
setPlayerRespawnTime 15;
cl_revived = false;

// Not in spawn menu
cl_inSpawnMenu = false;

// Hold actions
[] spawn client_fnc_initHoldActions;