scriptName "fn_getBeaconOwner";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getBeacon.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getBeaconOwner.sqf"
if (isServer && !hasInterface) exitWith {};

_beacon = param[0,objNull,[objNull]];
_ret = objNull;

{
	if (_x getVariable ["assault_beacon_obj", objNull] == _beacon) then {
		_ret = _x;
	};
} forEach AllPlayers;

_ret;