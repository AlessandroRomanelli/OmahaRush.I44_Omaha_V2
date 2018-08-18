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

private _fallBackTime = paramsArray#8;
private _OOBTime = paramsArray#7;
private _outOfBoundsTimeout = if (player getVariable ["isFallingBack", false]) then [{_fallBackTime}, {_OOBTime;}];

// Wait until time is out or were out again
waitUntil {((diag_tickTime - (player getVariable "entryTime")) > _outOfBoundsTimeout) || {(vehicle player) inArea playArea} || {(vehicle player) isKindOf "Air"}};

// Evaluate
if ((diag_tickTime - (player getVariable "entryTime")) > _outOfBoundsTimeout && (player getVariable ["isAlive", false])) then {
	player setDamage 1;
	player setVariable ["isAlive", false];
	["You have been killed for remaining in a restricted area"] spawn client_fnc_displayError;
};

// Delete myself ay!
cl_restrictedArea_thread = nil;
player setVariable ["entryTime", nil];
