scriptName "fn_autoTeamBalancer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_autoTeamBalancer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_autoTeamBalancer.sqf"
#include "..\utils.h"

private _getUnitsThatLastJoined = {
	params [["_side",sideUnknown,[sideUnknown]], ["_amount", 0, [0]]];
	private _sidePlayers = (allPlayers select {side _x == _side}) apply {[_x getVariable ["joinServerTime", diag_tickTime], _x]};
	_sidePlayers sort false;
	(_sidePlayers select [0,_amount]) apply {_x select 1}
};

sv_autoTeamBalancerWarning = false;

VARIABLE_DEFAULT(sv_setting_AutoTeamBalanceAtDifference, 3);

while {sv_gameStatus == 2} do {
	uiSleep 60;

	// Run side checks
	private _attackers = EAST countSide allPlayers;
	private _defenders = WEST countSide allPlayers;

	private _sideWithMoreUnits = if (_attackers <= _defenders) then {WEST} else {EAST};
	private _maxDiff = if (_sideWithMoreUnits == WEST) then {0} else {sv_setting_AutoTeamBalanceAtDifference};

	private _diff = abs(_attackers - _defenders);

	if (_diff > _maxDiff) then {
		if (!sv_autoTeamBalancerWarning) then {
			sv_autoTeamBalancerWarning = true;
			private _message = if (_sideWithMoreUnits == WEST) then {
				"TEAM BALANCE: players will be moved in 60 seconds if there will be more defenders than attackers"
			} else {
				format["TEAM BALANCE: players will be moved in 60 seconds if there are more than %1 attackers than defenders", sv_setting_AutoTeamBalanceAtDifference]
			};
			[_message] remoteExec ["client_fnc_displayError", -2];
			[format["Players have been warned about team difference: %1", _diff]] call server_fnc_log;
		} else {
			private _toMove = ceil(_diff / 2);
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
