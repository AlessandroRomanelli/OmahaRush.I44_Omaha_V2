scriptName "fn_instantTeamBalanceCheck";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_instantTeamBalanceCheck.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_instantTeamBalanceCheck.sqf"

// Is this even enabled
private _enableATB = paramsArray#13;
if (_enableATB != 1) exitWith {};

// Check if server has been online for 300 seconds already
if (serverTime < 300) exitWith {};

private _attackersSide = [WEST, independent] select (sv_gameCycle % 2 == 0);
private _defendersSide = [WEST, independent] select (sv_gameCycle % 2 != 0);

// Run side checks
private _attackersTeam = {(_x getVariable ["gameSide", "attackers"]) isEqualTo "attackers"} count allPlayers;
private _defendersTeam = {(_x getVariable ["gameSide", "defenders"]) isEqualTo "defenders"} count allPlayers;
diag_log format["DEBUG: TeamBalanceCheck.. Attackers' count: %1, Defenders' count: %2", _attackersTeam, _defendersTeam];

private _diff = _attackersTeam - _defendersTeam;
private _sideWithMoreUnits = if (_attackersTeam >= _defendersTeam) then {_attackersSide} else {_defendersSide};

private _maxDiff = paramsArray#14;
private _ending = ["teamFullWEST", "teamFullindependent"] select (playerSide isEqualTo WEST);

if ((playerSide isEqualTo _sideWithMoreUnits) && (_diff < 0 || _diff > _maxDiff)) then {
	endMission _ending;
};
