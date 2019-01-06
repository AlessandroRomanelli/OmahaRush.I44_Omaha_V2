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
	private _side = param[0,sideUnknown,[sideUnknown]];
	private _lastJoinTime = 0;
	private _preferredUnit = objNull;
	{
		if (side _x == _side) then {
			if ((_x getVariable ["joinServerTime", 0]) > _lastJoinTime) then {
				_lastJoinTime = (_x getVariable ["joinServerTime", 0]);
				_preferredUnit = _x;
			};
		};
	} forEach AllPlayers;
	_preferredUnit;
};

sv_autoTeamBalancerWarning = false;

while {sv_gameStatus == 2} do {
	sleep 60;

	private _attackersSide = [WEST, independent] select (sv_gameCycle % 2 == 0);
	private _defendersSide = [WEST, independent] select (sv_gameCycle % 2 != 0);
	// Run side checks
	private _attackersTeam = {(_x getVariable ["gameSide", "attackers"]) isEqualTo "attackers"} count allPlayers;
	private _defendersTeam = {(_x getVariable ["gameSide", "defenders"]) isEqualTo "defenders"} count allPlayers;

	private _diff = _attackersTeam - _defendersTeam;
	private _maxDiff = ["AutoTeamBalanceAtDifference", 3] call BIS_fnc_getParamValue;
	private _sideWithMoreUnits = if (_attackersTeam >= _defendersTeam) then {_attackersSide} else {_defendersSide};

	if (_diff < 0 || _diff > _maxDiff) then {
		if (!sv_autoTeamBalancerWarning) then {
			sv_autoTeamBalancerWarning = true;
			["Auto team balance will commence in 60 seconds if teams stay unbalanced"] remoteExec ["client_fnc_displayError"];
			[format["Players have been warned about team difference: %1", _diff]] call server_fnc_log;
		} else {
			sv_autoTeamBalancerWarning = true;

			private _toMove = floor(_diff / 2);
			for "_i" from 1 to _toMove step 1 do
			{
				private _unit = [_sideWithMoreUnits] call _getUnitsThatLastJoined;
				[format["Player %1 has been kicked due to team balance", _unit getVariable ["name", "ERROR: No Name"]]] call server_fnc_log;

				if (_sideWithMoreUnits == _attackersSide) then {
					[_defendersSide] remoteExec ["client_fnc_teamBalanceKick", _unit];
				} else {
					[_attackersSide] remoteExec ["client_fnc_teamBalanceKick", _unit];
				};

				// Make sure this unit will be gone until next evaluation
				sleep 5;
			};
		};
	} else {
		sv_autoTeamBalancerWarning = false;
	};
};
