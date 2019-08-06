scriptName "fn_cleanUp";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_cleanUp.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_cleanUp.sqf"

/* private _allObjects = (allMissionObjects "Man") + (allMissionObjects "GroundWeaponHolder") + (allMissionObjects "LandVehicle") + (allMissionObjects "Air") + (allMissionObjects "WeaponHolder") + (allMissionObjects "LIB_GerRadio") + (allMissionObjects "LIB_Static_opelblitz_radio") + (allMissionObjects "LIB_SovRadio"); */

private _allObjects = [];

{
	if (_x isKindOf "Man" || {_x isKindOf "GroupWeaponHolder"} ||
		 {_x isKindOf "LandVehicle"} || {_x isKindOf "Air"} ||
		 {_x isKindOf "WeaponHolder"} || {_x isKindOf "LIB_GerRadio"} ||
		 {_x isKindOf "LIB_Static_opelblitz_radio"} || {_x isKindOf "LIB_SovRadio"} ||
		 {_x isKindOf "LIB_Static_zis6_radar"} || {_x isKindOf "test_EmptyObjectForFireBig"} ||
		 {_x isKindOf "Land_Antenna"}) then {
		 _allObjects pushBack _x
	 }
 } forEach allMissionObjects "";

{
	if (!isNil _x) then {
		_allObjects pushBackUnique (missionNamespace getVariable [_x, objNull]);
	};
} forEach ["sv_stage1_obj", "sv_stage2_obj", "sv_stage3_obj", "sv_stage4_obj"];


 _allObjects append (allMissionObjects "#crater");

// If we have vehicles, delete them aswell
if (!isNil "sv_persistentVehicles") then {
	_allObjects append sv_persistentVehicles;

	// Terminate all respawn scripts
	{
		terminate _x;
	} forEach sv_persistentVehicleRespawnThreads;
};

// Delete all objects that are not players
{
	if (_x getVariable ["isPersistent", false]) exitWith {
		_x setVehicleAmmo 1;
		_x setDamage 0;
	};
	if (!isPlayer _x) then {
		deleteVehicle _x;
	};
} forEach _allObjects;

// Log
[format["Cleaned up %1 objects", count _allObjects]] call server_fnc_log;

true
