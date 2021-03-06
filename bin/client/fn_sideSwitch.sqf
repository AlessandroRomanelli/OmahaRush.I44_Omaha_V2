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

if (IS_OBJ_ARMED) then {
  _error = "CANNOT SWITCH SIDES WHILE THE BOMB IS ARMED";
};

if (player getVariable ["isAlive", true]) then {
  _error = "CANNOT SWITCH SIDES WHEN DEPLOYED";
};

private _def = WEST countSide allPlayers;
private _atk = EAST countSide allPlayers;

private _sideLessUnits = [EAST, WEST] select (_def <= _atk);

if ((player getVariable ["side", sideUnknown]) == _sideLessUnits) then {
  _error = "CANNOT SWITCH TO THE BIGGER SIDE";
};

VARIABLE_DEFAULT(cl_forceSwitch, false);
if (_error != "" && !cl_forceSwitch) exitWith {
  [_error] call client_fnc_displayError;
};

private _oldSide = player getVariable ["side", side player];
private _newSide = [EAST, WEST] select (_oldSide == EAST);

[player] join (createGroup _newSide);
[player] join grpNull;

waitUntil {side player != civilian && {side player != _oldSide}};

[] call client_fnc_saveStatistics;

player setVariable ["side", side player, true];

player setVariable ["joinServerTime", diag_tickTime, 2];

[] call client_fnc_loadStatistics;

cl_lastSwitched = diag_tickTime;
cl_forceSwitch = false;

[] spawn client_fnc_spawn;
