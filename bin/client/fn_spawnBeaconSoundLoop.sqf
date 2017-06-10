scriptName "fn_spawnBeaconSoundLoop";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnBeaconSoundLoop.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnBeaconSoundLoop.sqf"
if (isServer && !hasInterface) exitWith {};

_beacon = param[0,objNull,[objNull]];

while {!isNull _beacon} do {
	sleep 2;
	_beacon say3D "tug_beep";
};