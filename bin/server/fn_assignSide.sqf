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
diag_log ("Acquiring lock in " +__filename);

VARIABLE_DEFAULT(sv_groups_counter, 0);
private _sideToJoin = [EAST, WEST] select (sv_groups_counter % 2);
sv_groups_counter = (sv_groups_counter + 1) % 2;
private _group = [sv_east_group, sv_west_group] select (_sideToJoin == WEST);

[_unit] join _group;

MUTEX_UNLOCK(sv_groups_lock);
diag_log ("Releasing lock in " +__filename);
