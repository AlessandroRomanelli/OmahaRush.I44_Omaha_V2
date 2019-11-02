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

if (_matchStart) then {
	[_additionalTime] spawn {
		uiSleep (param[0, 0, [0]]);
		[] call server_fnc_refreshTickets;
	};
};

private _objective = sv_cur_obj;

// While there's time left and the game is ongoing
for "_time" from sv_matchTime to 0 step -1 do {
	if (sv_gameStatus != 2) exitWith {};
	private _status = _objective getVariable ["status", -1];
	if (_status in [0, 1]) then {
		_time = _time + 1;
	};
	if (_time % 5 == 0) then {
		sv_cur_obj setVariable ["status", _status, true];
	};
	sv_matchTime = _time;
	publicVariable "sv_matchTime";
	if (_time == 0) exitWith {
		[] call server_fnc_endRound;
	};
    //code
	uiSleep 1;
};
