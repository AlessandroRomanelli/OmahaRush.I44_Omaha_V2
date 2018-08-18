scriptName "fn_beaconSpawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_beaconSpawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_beaconSpawn.sqf"
if (isServer && !hasInterface) exitWith {};

// We are nice, arent we?
["<t size='1.3' color='#FFFFFF'>SQUAD MEMBER SPAWNED AT RALLY POINT</t>", 20] spawn client_fnc_pointfeed_add;
[20] spawn client_fnc_addPoints;

// Increase amount the beacon has been used
cl_beacon_used = cl_beacon_used + 1;

// Too many uses?
if (cl_beacon_used >= 5) then {
	// Delete beacon
	private _beacon = player getVariable ["assault_beacon_obj", objNull];
	if (!isNull _beacon) then {
		deleteVehicle _beacon;
	};

	// Message
	["RALLY POINT", "Your rally point has been used 5 times and despawned. You may place a new one now."] spawn client_fnc_hint;
};
