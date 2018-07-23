scriptName "fn_autoTeamBalancer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_autoTeamBalancer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_autoTeamBalancer.sqf"

_getUnitsThatLastJoined = {
	_side = param[0,sideUnknown,[sideUnknown]];

	_lastJoinTime = 0;
	_preferredUnit = objNull;
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

	_unitsAttacker = {side _x == independent} count AllPlayers;
	_unitsDefender = {side _x == WEST} count AllPlayers;

	_diff = if (_unitsAttacker <= _unitsDefender) then {_unitsDefender - _unitsAttacker} else {_unitsAttacker - _unitsDefender};
	_sideWithMoreUnits = if (_unitsAttacker <= _unitsDefender) then {WEST} else {independent};

	if (_diff >= ("AutoTeamBalanceAtDifference" call bis_fnc_getParamValue)) then {
		if (!sv_autoTeamBalancerWarning) then {
			sv_autoTeamBalancerWarning = true;
			["Auto team balance will commence in 60 seconds if teams stay unbalanced"] remoteExec ["client_fnc_displayError"];
			[format["Players have been warned about team difference: %1", _diff]] call server_fnc_log;
		} else {
			sv_autoTeamBalancerWarning = true;

			_toMove = floor(_diff / 2);
			for "_i" from 1 to _toMove step 1 do
			{
				_unit = [_sideWithMoreUnits] call _getUnitsThatLastJoined;
				[format["Player %1 has been kicked due to team balance", name _unit]] call server_fnc_log;

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
