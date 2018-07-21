scriptName "fn_restrictedAreaDefenders";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_restrictedArea.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_restrictedAreaDefenders.sqf"

player setVariable ["entryTime", diag_tickTime];

// Wait until time is out or were out again
waitUntil {((diag_tickTime - (player getVariable "entryTime")) > 20) || (player getVariable ["gameSide", "defenders"] == "defenders") && (vehicle player in (list area_def))};

// Evaluate
if ((diag_tickTime - (player getVariable "entryTime")) > 20) then {
	player setDamage 1;
	player setVariable ["isAlive", false];
	["You have been killed for remaining in a restricted area"] spawn client_fnc_displayError;
};

// Delete myself ay!
cl_restrictedAreaDefenders_thread = nil;
player setVariable ["entryTime", nil];
