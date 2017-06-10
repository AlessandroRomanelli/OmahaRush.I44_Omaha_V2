scriptName "fn_squadSpawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_squadSpawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_squadSpawn.sqf"
if (isServer && !hasInterface) exitWith {};

// We are nice, arent we?
["<t size='1.3' color='#FFFFFF'>SQUAD SPAWN ON YOU</t>", 15] spawn client_fnc_pointfeed_add;
[15] spawn client_fnc_addPoints;