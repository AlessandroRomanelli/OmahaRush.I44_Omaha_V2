scriptName "fn_initPerks";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_initPerks.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initPerks.sqf"
if (isServer && !hasInterface) exitWith {};

// cl_classPerk and cl_squadPerk return the used perks

if (cl_squadPerk == "sprint") then {
	player setAnimSpeedCoef 1.05;
} else {
	player setAnimSpeedCoef 1;
};