scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_matchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"

private _stageTime = param[0,0,[0]];
/* cl_intendedTime = diag_tickTime + _stageTime; */

cl_matchTimer_thread = [_stageTime] spawn {
	private _time = param[0, 0, [0]];
	while {sv_gameStatus == 2} do {
		private _status = sv_cur_obj getVariable ["status", -1];
		if !(_status == 0 || _status == 1) then {
			_time = _time - 1;
		};
		sleep 1;

		if (_time > 0) then {
			cl_matchTime = _time;
		};
	};
};
