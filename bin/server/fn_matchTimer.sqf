scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_matchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"

private _matchStart = param[0,false,[false]];
private _additionalTime = param[1,0,[0]];

/* _stageTime = getNumber(missionConfigFile >> "MapSettings" >> "roundTime"); */
private _stageTime = ceil (paramsArray#3 * 60);

sv_matchTime =  _stageTime + _additionalTime;
sv_matchEndTime =  sv_matchTime + serverTime;
sv_fallBack_timeLeft = _additionalTime + diag_tickTime;

if (_matchStart) then {
	[_additionalTime] spawn {
		sleep (param[0, 0, [0]]);
		[] call server_fnc_refreshTickets;
	};
};

// Start timer on all clients
//[sv_matchTime] remoteExec ["client_fnc_matchTimer"];

private _delay = 0;
private _time = sv_matchTime;
while {_time > 0 && sv_gameStatus == 2} do {
	sleep 1;
	private _status = sv_cur_obj getVariable ["status", -1];
	if (_status == 0 || _status == 1) then {
		sv_startTicking = nil;
		_delay = _delay + 1;
		if (serverTime % 3 == 0) then {
			sv_cur_obj setVariable ["status", _status, true];
		};
	} else {
		sv_stopTicking = nil;
		if (serverTime % 5 == 0) then {
			sv_cur_obj setVariable ["status", _status, true];
		};
	};
	_time = sv_matchEndTime - serverTime + _delay;
	// Only decrease the time if the current mcom is NOT done
	if (sv_cur_obj getVariable ["status", -1] != 3) then {
		sv_matchTime = _time;
	};
};

sleep 1;

// Only if the time actually got to 0, end the match for the defenders
if (sv_matchTime <= 0) exitWith {
	[] spawn server_fnc_endRound;

	// Overwrite time values on all clients
	cl_matchTime = 0;
	[["cl_matchTime"]] spawn server_fnc_updateVars;
};
