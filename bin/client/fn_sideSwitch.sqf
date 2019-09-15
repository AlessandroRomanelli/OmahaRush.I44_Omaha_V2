scriptName "fn_sideSwitch";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_sideSwitch.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_sideSwitch.sqf"
#include "..\utils.h"

private _error = "";
VARIABLE_DEFAULT(cl_lastSwitched, 0);
if ((diag_tickTime - cl_lastSwitched) < 15) then {
  _error = "CANNOT SWITCH SIDES TOO QUICKLY";
};

if (sv_cur_obj getVariable ["status", 0] == 1) then {
  _error = "CANNOT SWITCH SIDES WHILE THE BOMB IS ARMED";
};

if (player getVariable ["isAlive", true]) then {
  _error = "CANNOT SWITCH SIDES WHEN DEPLOYED";
};

VARIABLE_DEFAULT(cl_forceSwitch, false);
if (_error != "" && !cl_forceSwitch) exitWith {
  [_error] call client_fnc_displayError;
};

private _def = WEST countSide allPlayers;
private _atk = EAST countSide allPlayers;

private _sideLessUnits = [EAST, WEST] select (_def <= _atk);

if ((player getVariable ["side", sideUnknown]) == _sideLessUnits) exitWith {
  ["CANNOT SWITCH TO THE BIGGER SIDE"] call client_fnc_displayError;
};

private _oldSide = player getVariable ["side", sideUnknown];

[player] join (createGroup _sideLessUnits);
[player] join grpNull;

waitUntil {side player != civilian && {side player != _oldSide}};

[] call client_fnc_saveStatistics;

player setVariable ["side", side player, true];

player setVariable ["gameSide", (
  [
    ["defenders", "attackers"],
    ["attackers", "defenders"]
  ] select (sv_gameCycle % 2 == 0)
) select (side player == WEST), true];

[] call client_fnc_loadStatistics;

cl_lastSwitched = diag_tickTime;

[] call client_fnc_spawn;

cl_forceSwitch = false;
