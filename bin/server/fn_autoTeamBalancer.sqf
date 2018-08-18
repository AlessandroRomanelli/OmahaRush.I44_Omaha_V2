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

	private _unitsTeam1 = {(side _x) isEqualTo WEST} count allPlayers;
	private _unitsTeam2 = (count allPlayers) - _unitsTeam1;

	private _diff = abs(_unitsTeam1 - _unitsTeam2);
	private _maxDiff = paramsArray#14;
	private _sideWithMoreUnits = if (_unitsTeam1 >= _unitsTeam2) then {WEST} else {independent};

	if (_diff > _maxDiff) then {
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

				if (_sideWithMoreUnits == WEST) then {
					[independent] remoteExec ["client_fnc_teamBalanceKick", _unit];
				} else {
					[WEST] remoteExec ["client_fnc_teamBalanceKick", _unit];
				};

				// Make sure this unit will be gone until next evaluation
				sleep 5;
			};
		};
	} else {
		sv_autoTeamBalancerWarning = false;
	};
};
