scriptName "fn_cleanUp";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_cleanUp.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_cleanUp.sqf"

_allObjects = (allMissionObjects "Man") + (allMissionObjects "GroundWeaponHolder") + (allMissionObjects "LandVehicle") + (allMissionObjects "Air") + (allMissionObjects "WeaponHolder") + (allMissionObjects "Land_DataTerminal_01_F") + (allMissionObjects "Land_Laptop_device_F");

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
	if (!isPlayer _x) then {
		deleteVehicle _x;
	};
} forEach _allObjects;

// Log
[format["Cleaned up %1 objects", count _allObjects]] call server_fnc_log;