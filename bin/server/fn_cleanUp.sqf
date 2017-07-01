scriptName "fn_cleanUp";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_cleanUp.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_cleanUp.sqf"

_allObjects = (allMissionObjects "Man") + (allMissionObjects "GroundWeaponHolder") + (allMissionObjects "LandVehicle") + (allMissionObjects "Air") + (allMissionObjects "WeaponHolder") + (allMissionObjects "LIB_GerRadio") + (allMissionObjects "LIB_Static_opelblitz_radio") + (allMissionObjects "Vysilacka");

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
	if (_x isKindOf "StaticWeapon") exitWith {};
	if (!isPlayer _x) then {
		deleteVehicle _x;
	};
} forEach _allObjects;

// Log
[format["Cleaned up %1 objects", count _allObjects]] call server_fnc_log;
