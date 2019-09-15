scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_matchTimer.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"
#include "..\utils.h"

private _matchStart = param[0,false,[false]];
private _additionalTime = param[1,0,[0]];

/* _stageTime = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "roundTime"); */
VARIABLE_DEFAULT(sv_setting_RoundTime, 15);
private _stageTime = sv_setting_RoundTime * 60;

sv_matchTime =  _stageTime + _additionalTime;
sv_matchEndTime =  sv_matchTime + (ceil diag_tickTime);
sv_fallBack_timeLeft = _additionalTime;

if (_matchStart) then {
	[_additionalTime] spawn {
		uiSleep (param[0, 0, [0]]);
		[] call server_fnc_refreshTickets;
	};
};

private _objective = sv_cur_obj;

// Initial delay
private _delay = 0;
// Current match time
private _time = sv_matchTime;
// How many seconds between objective status update
private _refreshRate = 10;
// While there's time left and the game is ongoing
while {_time >= 0 && sv_gameStatus == 2} do {
	// Tick each second
	uiSleep 1;
	if (sv_fallBack_timeLeft >= 0) then {
		sv_fallBack_timeLeft = sv_fallBack_timeLeft - 1;
		publicVariable "sv_fallBack_timeLeft";
	};
	// Get objective status on the server (super partes)
	private _status = _objective getVariable ["status", -1];
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
		_objective setVariable ["status", _status, true];
	};
	// Current time is given by the intended endMatch time, summed with the delay, minus the serverTime
	_time = sv_matchEndTime - (ceil diag_tickTime) + _delay;
	// Broadcast the matchTime only if NOT done
	if ((_status != 3) && _time >= 0) then {
		sv_matchTime = _time;
		publicVariable "sv_matchTime";
	};
	if (_time < 0) exitWith {
		sv_matchTime = 0;
		uiSleep 1;
		// Only if the time actually got to 0, end the match for the defenders
		[] call server_fnc_endRound;
	};
};
