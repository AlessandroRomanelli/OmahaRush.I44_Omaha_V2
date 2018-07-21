scriptName "fn_matchTimer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_matchTimer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_matchTimer.sqf"

_stageTime = param[0,0,[0]];
cl_intendedTime = diag_tickTime + _stageTime;

cl_matchTimer_thread = [] spawn {
	while {sv_gameStatus == 2} do {
		sleep 1;

		// Wait until the current mcom is NOT armed
		_delay = diag_tickTime;
		waitUntil {!(sv_cur_obj getVariable ["armed",false]) && !(sv_cur_obj getVariable ["arming", false])}; // This loop will either exit when the current mcom is not armed or wait until the current mcom object changes
		_delay = diag_tickTime - _delay;

		cl_intendedTime = cl_intendedTime + _delay;
		_timeLeft = cl_intendedTime - diag_tickTime;
		if (_timeLeft > 0) then {
			cl_matchTime = _timeLeft;
		};

		// Reveal friendly units (dank usage of already existing loops heh?)
		[] spawn client_fnc_revealFriendlyUnits;
	};
};
