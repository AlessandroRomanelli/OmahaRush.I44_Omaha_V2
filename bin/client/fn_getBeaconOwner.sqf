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

private _beacon = param[0,objNull,[objNull]];

private _idx = allPlayers findIf {_x getVariable ["assault_beacon_obj", objNull] isEqualTo _beacon};
private _ret = allPlayers select _idx;

_ret;
