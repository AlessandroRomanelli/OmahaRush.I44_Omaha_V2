scriptName "fn_autoTeamBalancer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_autoTeamBalancer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_autoTeamBalancer.sqf"

private _getUnitsThatLastJoined = {
	params [["_side",sideUnknown,[sideUnknown]], ["_amount", 0, [0]]];
	private _sidePlayers = (allPlayers select {side _x == _side}) apply {[_x getVariable ["joinServerTime",0], _x]};
	_sidePlayers sort false;
	(_sidePlayers select [0,_amount]) apply {_x select 1};
};

sv_autoTeamBalancerWarning = false;

while {sv_gameStatus == 2} do {
	uiSleep 60;

	private _attackersSide = [WEST, EAST] select (sv_gameCycle % 2 == 0);
	private _defendersSide = [EAST, WEST] select (sv_gameCycle % 2 == 0);
	// Run side checks
	private _attackers = _attackersSide countSide allPlayers;
	private _defenders = _defendersSide countSide allPlayers;

	private _diff = _attackers - _defenders;
	private _maxDiff = ["AutoTeamBalanceAtDifference", 3] call BIS_fnc_getParamValue;
	private _sideWithMoreUnits = if (_attackers >= _defenders) then {_attackersSide} else {_defendersSide};

	if (_diff < 0 || _diff > _maxDiff) then {
		if (!sv_autoTeamBalancerWarning) then {
			sv_autoTeamBalancerWarning = true;
			["Auto team balance will commence in 60 seconds if teams stay unbalanced"] remoteExec ["client_fnc_displayError", 0];
			[format["Players have been warned about team difference: %1", _diff]] call server_fnc_log;
		} else {
			private _toMove = floor(_diff / 2);
			for "_i" from 1 to _toMove step 1 do {
				private _units = [_sideWithMoreUnits, _toMove] call _getUnitsThatLastJoined;
				[format["Players %1 have been switched due to team balance", _units apply {_x getVariable ["name", name _x]}]] call server_fnc_log;
				[] remoteExec ["client_fnc_teamBalanceKick", _units];
				{ _x setVariable ["joinServerTime", diag_tickTime] } forEach _units;
			};
		};
	} else {
		sv_autoTeamBalancerWarning = false;
	};
};
