scriptName "fn_instantTeamBalanceCheck";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_instantTeamBalanceCheck.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_instantTeamBalanceCheck.sqf"
#include "..\utils.h"

// Made obsolete by server-side assignment
if (true) exitWith {};
/* 
// Is this even enabled
VARIABLE_DEFAULT(sv_setting_AutoTeamBalancer, 1);
if (sv_setting_AutoTeamBalancer != 1) exitWith {};

// Check if server has been online for 300 seconds already
if (serverTime < 300) exitWith {};

private _attackersSide = [WEST, EAST] select (sv_gameCycle % 2 == 0);
private _defendersSide = [WEST, EAST] select (sv_gameCycle % 2 != 0);

// Run side checks
private _attackersTeam = {(_x getVariable ["side", side _x]) isEqualTo EAST} count allPlayers;
private _defendersTeam = {(_x getVariable ["side", side _x]) isEqualTo WEST} count allPlayers;
if (player getVariable ["side", side player] == EAST) then {
	_attackersTeam = _attackersTeam - 1;
} else {
	_defendersTeam = _defendersTeam - 1;
};
diag_log format["DEBUG: TeamBalanceCheck.. Attackers' count: %1, Defenders' count: %2", _attackersTeam, _defendersTeam];

private _diff = _attackersTeam - _defendersTeam;
private _sideWithMoreUnits = if (_attackersTeam >= _defendersTeam) then {_attackersSide} else {_defendersSide};

VARIABLE_DEFAULT(sv_setting_AutoTeamBalanceAtDifference, 3);
private _maxDiff = sv_setting_AutoTeamBalanceAtDifference;
private _ending = ["teamFullWEST", "teamFullEAST"] select ((player getVariable ["side", sideUnknown]) isEqualTo WEST);

if (((player getVariable ["side", sideUnknown]) isEqualTo _sideWithMoreUnits) && (_diff < 0 || _diff > _maxDiff)) then {
	endMission _ending;
};
true */
