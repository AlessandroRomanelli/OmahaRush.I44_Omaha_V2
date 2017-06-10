scriptName "fn_vehicleSpawned";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_vehicleSpawned.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_vehicleSpawned.sqf"
if (isServer && !hasInterface) exitWith {};

_v = param[0,objNull,[objNull]];

// No vehicle?
if (isNull _v) exitWith {};

// File reserved for later use