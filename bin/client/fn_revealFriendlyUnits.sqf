scriptName "fn_revealFriendlyUnits";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_revealFriendlyUnits.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_revealFriendlyUnits.sqf"

{
	if ((player getVariable ["side", sideUnknown]) == (side (group _x))) then {
		player reveal _x;
	};
} forEach AllPlayers;