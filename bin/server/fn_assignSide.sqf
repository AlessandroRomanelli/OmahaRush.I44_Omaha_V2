scriptName "fn_assignSide";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_assignSide.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_assignSide.sqf"
#include "..\utils.h"

params [["_unit", objNull, [objNull]]];
// Not the server?
if (!isServer || isNull _unit) exitWith {};

// Time played to make sure the auto team balancer knows our jointime
_unit setVariable ["joinServerTime", diag_tickTime];

{
	if (isNil _x || {missionNamespace getVariable [_x, grpNull] isEqualTo grpNull}) then {
		missionNamespace setVariable [_x, createGroup ([WEST,EAST] select (_forEachIndex % 2 == 0))];
	};
} forEach ["sv_east_group", "sv_west_group"];

MUTEX_INIT(sv_groups_lock);
MUTEX_LOCK(sv_groups_lock);

private _def = WEST countSide allPlayers;
private _atk = EAST countSide allPlayers;

private _sideLessUnits = [sv_east_group, sv_west_group] select (_def <= _atk);

[_unit] join _sideLessUnits;

MUTEX_UNLOCK(sv_groups_lock);
