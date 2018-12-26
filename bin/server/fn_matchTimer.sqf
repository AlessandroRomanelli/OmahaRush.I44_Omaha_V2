scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_matchTimer.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"

private _matchStart = param[0,false,[false]];
private _additionalTime = param[1,0,[0]];

/* _stageTime = getNumber(missionConfigFile >> "MapSettings" >> "roundTime"); */
private _stageTime = ceil (paramsArray#3 * 60);

sv_matchTime =  _stageTime + _additionalTime;
sv_matchEndTime =  sv_matchTime + diag_tickTime;
sv_fallBack_timeLeft = _additionalTime + diag_tickTime;
diag_log format ["sv_fallBack_timeLeft: %1", sv_fallBack_timeLeft];

if (_matchStart) then {
	[_additionalTime] spawn {
		sleep (param[0, 0, [0]]);
		[] call server_fnc_refreshTickets;
	};
};

// Start timer on all clients
//[sv_matchTime] remoteExec ["client_fnc_matchTimer"];

// Initial delay
private _delay = 0;
// Current match time
private _time = sv_matchTime;
// How many seconds between objective status update
private _refreshRate = 10;
// While there's time left and the game is ongoing
while {_time >= 0 && sv_gameStatus == 2} do {
	// Tick each second
	sleep 1;
	// Get objective status on the server (super partes)
	private _status = sv_cur_obj getVariable ["status", -1];
	// If the bomb is armed or being armed
	if (_status == 0 || _status == 1) then {
		// Increase the delay by one second
		_delay = _delay + 1;
		// Refresh the bomb status each 3 seconds to keep sync with server
		_refreshRate = 3;
	// If the bomb is idle
	} else {
		// Refresh each 5 seconds
		_refreshRate = 5;
	};
	// Refresh status of objective for all clinets
	if (((floor diag_tickTime) % _refreshRate) == 0) then {
		sv_cur_obj setVariable ["status", _status, true];
	};
	// Current time is given by the intended endMatch time, summed with the delay, minus the serverTime
	_time = sv_matchEndTime - diag_tickTime + _delay;
	// Broadcast the matchTime only if NOT done
	if ((sv_cur_obj getVariable ["status", -1] != 3) && _time >= 0) then {
		sv_matchTime = _time;
		publicVariable "sv_matchTime";
	};
	if (_time < 0) then {
		sleep 1;
		// Only if the time actually got to 0, end the match for the defenders
		[] spawn server_fnc_endRound;
	};
};
