scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_matchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"

_matchStart = param[0,false,[false]];
_additionalTime = param[1,0,[0]];

/* _stageTime = getNumber(missionConfigFile >> "MapSettings" >> "roundTime"); */
_stageTime = ceil (paramsArray#3 * 60);

sv_matchTime =  _stageTime + _additionalTime;
sv_fallBack_timeLeft = _additionalTime;

// Start timer on all clients
//[sv_matchTime] remoteExec ["client_fnc_matchTimer"];

_time = sv_matchTime;
while {_time > 0 && sv_gameStatus == 2} do {
	sleep 1;
	_status = sv_cur_obj getVariable ["status", -1];
	if !(_status == 0 || _status == 1) then {
		_time = _time - 1;
	};
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
