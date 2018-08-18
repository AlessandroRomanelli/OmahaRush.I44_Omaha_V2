scriptName "fn_cleanUp";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_cleanUp.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_cleanUp.sqf"
if (isServer && !hasInterface) exitWith {};

// MAKE THIS FILE OBSOLETE
if (true) exitWith {};


// Remove all actions
removeAllActions player;
private _objects = allPlayers;
{
	removeAllActions _x;
	for "_i" from 0 to 100 step 1 do
	{
		[_x, _i] call BIS_fnc_holdActionRemove;
	};
} forEach _objects;
