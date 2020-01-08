scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_matchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"
#include "..\utils.h"

// Make obsolete
if (true) exitWith {};

private _stageTime = param[0,0,[0]];
/* cl_intendedTime = diag_tickTime + _stageTime; */
cl_matchEndTime = _stageTime;

cl_matchTimer_thread = [] spawn {
	private ["_time"];
	private _delay = 0;
	while {sv_gameStatus == 2} do {
		uiSleep 1;
		private _status = sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED];
		if (_status == OBJ_STATUS_IN_USE || _status == OBJ_STATUS_ARMED) then {
			_delay = _delay + 1;
		};
		_time = cl_matchEndTime - serverTime + _delay;
		if (_time > 0) then {
			cl_matchTime = _time;
		};
	};
};
