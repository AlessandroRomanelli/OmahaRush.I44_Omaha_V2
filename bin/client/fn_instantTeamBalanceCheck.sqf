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
if (getNumber(missionConfigFile >> "GeneralConfig" >> "AutoTeamBalancer") != 1) exitWith {};

// Check if server has been online for 300 seconds already
if (serverTime < 300) exitWith {};

// Run side checks
_unitsAttacker = {side _x == independent} count AllPlayers;
_unitsDefender = {side _x == WEST} count AllPlayers;

_diff = if (_unitsAttacker <= _unitsDefender) then {_unitsDefender - _unitsAttacker} else {_unitsAttacker - _unitsDefender};
_sideWithMoreUnits = if (_unitsAttacker <= _unitsDefender) then {WEST} else {independent};

_maxDiff = getNumber(missionConfigFile >> "GeneralConfig" >> "AutoTeamBalanceAtDifference");

if (playerSide == _sideWithMoreUnits AND _diff > 2) then {
	if (playerSide == WEST) then {
		endMission "teamFullindependent";
	} else {
		endMission "teamFullWEST";
	};
};
