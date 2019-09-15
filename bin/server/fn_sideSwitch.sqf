scriptName "fn_sideSwitch";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_sideSwitch.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_sideSwitch.sqf"
#include "..\utils.h"

params [["_unit", objNull, [objNull]]];
// Not the server?
if (!isServer || isNull _unit) exitWith {};

{
    if (isNil _x || {missionNamespace getVariable [_x, grpNull] isEqualTo grpNull}) then {
      missionNamespace setVariable [_x, createGroup ([WEST,EAST] select (_forEachIndex % 2 == 0))];
    };
} forEach ["sv_east_group", "sv_west_group"];

MUTEX_INIT(sv_groups_lock);
MUTEX_LOCK(sv_groups_lock);

private _def = WEST countSide allPlayers;
private _atk = EAST countSide allPlayers;

private _sideLessUnits = [EAST, WEST] select (_def <= _atk);

if (_unit getVariable ["side", sideUnknown] == _sideLessUnits) exitWith {};

private _newSide = [sv_east_group, sv_west_group] select (side _unit == EAST);

[_unit] join _newSide;

MUTEX_UNLOCK(sv_groups_lock);
