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

// Run side checks
private _unitsTeam1 = {(_x getVariable ["side", sideUnknown]) isEqualTo WEST} count allPlayers;
private _unitsTeam2 = (count allPlayers) - _unitsTeam1;
diag_log format["DEBUG: TeamBalanceCheck.. TeamBLUE: %1, TeamRED: %2, Total: %3", _unitsTeam1, _unitsTeam2, count allPlayers];

private _diff = abs(_unitsTeam1 - _unitsTeam2);
private _sideWithMoreUnits = if (_unitsTeam2 <= _unitsTeam1) then {WEST} else {independent};

private _maxDiff = paramsArray#14;
private _ending = ["teamFullWEST", "teamFullindependent"] select (playerSide isEqualTo WEST);

if ((playerSide isEqualTo _sideWithMoreUnits) && (_diff > _maxDiff)) then {
	endMission _ending;
};
