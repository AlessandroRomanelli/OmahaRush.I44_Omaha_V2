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

/* {
	if (isNil _x || {missionNamespace getVariable [_x, grpNull] isEqualTo grpNull}) then {
		missionNamespace setVariable [_x, createGroup ([WEST,EAST] select (_forEachIndex % 2 == 0))];
	};
} forEach ["sv_east_group", "sv_west_group"]; */

MUTEX_INIT(sv_groups_lock);
MUTEX_LOCK(sv_groups_lock);

VARIABLE_DEFAULT(sv_groups_counter, 0);
private _sideToJoin = [EAST, WEST] select (sv_groups_counter % 2);
sv_groups_counter = (sv_groups_counter + 1) % 2;

private _registeredGroups = ["GetAllGroupsOfSide", [_sideToJoin]] call BIS_fnc_dynamicGroups;
private _found = false;
{
	if !(_x getVariable ["bis_dg_pri", false]) then {
		private _members = count units _x;
		if ((_members > 0) && (_members < 5)) exitWith {
			["AddGroupMember", [_x, _unit]] call BIS_fnc_dynamicGroups;
			_found = true;
		};
	};
} forEach _registeredGroups;

if (!_found) exitWith {
	private _group = createGroup _sideToJoin;
	private _faction = getText(missionconfigfile >> "Soldiers" >> (["defenders", "attackers"] select (_sideToJoin == EAST)) >> "faction");
	[_unit] join _group;
	[_group, _unit, _faction] call server_fnc_generateGroup;
	MUTEX_UNLOCK(sv_groups_lock);
};

/* private _group = [sv_east_group, sv_west_group] select (_sideToJoin == WEST); */

MUTEX_UNLOCK(sv_groups_lock);
