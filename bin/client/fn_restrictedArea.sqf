scriptName "fn_restrictedArea";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_restrictedArea.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_restrictedArea.sqf"

player setVariable ["entryTime", diag_tickTime];

_isPlayerAttacking = player getVariable "gameSide" == "attackers";
_fallBackTime = "FallBackSeconds" call bis_fnc_getParamValue;
_OOBTime = "OutOfBoundsTime" call bis_fnc_getParamValue;
_outOfBoundsTimeout = if (player getVariable ["isFallingBack", false]) then [{_fallBackTime}, {_OOBTime;}];

// Wait until time is out or were out again
waitUntil {((diag_tickTime - (player getVariable "entryTime")) > _outOfBoundsTimeout) || ((vehicle player) inArea playArea)};

// Evaluate
if ((diag_tickTime - (player getVariable "entryTime")) > _outOfBoundsTimeout) then {
	player setDamage 1;
	player setVariable ["isAlive", false];
	["You have been killed for remaining in a restricted area"] spawn client_fnc_displayError;
};

// Delete myself ay!
cl_restrictedArea_thread = nil;
player setVariable ["entryTime", nil];
