scriptName "fn_MCOMarmed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_MCOMarmed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMarmed.sqf"

// Planter
_planter = param[0,objNull,[objNull]];

// Display warning
["EXPLOSIVES HAVE BEEN SET"] spawn client_fnc_displayObjectiveMessage;


// Info
["EXPLOSIVES ARMED","The objective has been armed. Attackers will not lose tickets while it is."] spawn client_fnc_hint;

// Start sound loop if we are the server
_wasServer = false;
if (isServer) then {
	_wasServer = true;

	if (!isNil "sv_mcom_thread") then {
		terminate sv_mcom_thread;
	};

	sv_mcom_thread = [] spawn {
		// Countdown of 60 seconds
		_time = 60;
		_soundTime = 60;
		_status = sv_cur_obj getVariable ["status", -1];
		_beep = MISSION_ROOT + "sounds\beep.ogg";
		// If the objective is armed and there's still time on the clock
		playSound3D [_beep, sv_cur_obj, false, getPosATL sv_cur_obj, 20, 1, 300];
		while {((_status == 1) || (_status == 0)) && _time >= 0} do {
			_status = sv_cur_obj getVariable ["status", -1];
			// Freeze time if the objective is being armed
			if (_status == 0) then {
				_time = _time;
			} else {
				_time = _time - 1;
			};
			_soundTime = _soundTime - 1;
			if (_time > 20) then {
				if (_soundTime % 3 == 0) then {
					playSound3D [_beep, sv_cur_obj, false, getPosATL sv_cur_obj, 0, 1, 300];
				};
			};
			if (_time >= 10 && _time <= 20) then {
				if (_soundTime % 2 == 0) then {
					playSound3D [_beep, sv_cur_obj, false, getPosATL sv_cur_obj, 5, 1, 300];
				};
			};
			if (_time < 10) then {
				if (_soundTime % 1 == 0) then {
					playSound3D [_beep, sv_cur_obj, false, getPosATL sv_cur_obj, 10, 1, 300];
				};
			};
			uiSleep 1;
		};

		_status = sv_cur_obj getVariable ["status", -1];
		// was the mcom disarmed? If yes, just exit here, players will get a text displayed by the player who disarmed
		if (_status == 2) exitWith {
			sleep 1;
			sv_cur_obj setVariable ["status",-1,true];
		};

		// Mark this mcom as done // e.g. used in matchTimer
		sv_cur_obj setVariable ["status", 3, true];

		// Display message
		if (sv_cur_obj != sv_stage4_obj) then {
			// Mcom has been destroyed
			[true] remoteExec ["client_fnc_MCOMdestroyed", 0];
		};

		// Explosion
		"HelicopterExploBig" createVehicle getPosATL sv_cur_obj;

		_killZone = sv_cur_obj nearEntities ["Man", 25];
		{
			if ((_x distance sv_cur_obj < 10) || {_x distance sv_cur_obj < 25 && {([sv_cur_obj, "VIEW"] checkVisibility [eyePos sv_cur_obj, eyePos _x]) > 0.1}}) then {
				player setDamage 1;
				["You were killed by the blast of the explosion"] remoteExec ["client_fnc_administrationKill", _x];
			};
		} forEach _killZone;

		if (sv_cur_obj == sv_stage4_obj) then {
			// Trigger win
			[] spawn server_fnc_endRound;
		} else {
			// Move onto next objective
			if (sv_cur_obj == sv_stage1_obj) then {
				sv_cur_obj = sv_stage2_obj;
			} else {
			if (sv_cur_obj == sv_stage2_obj) then {
				sv_cur_obj = sv_stage3_obj;
			} else {
				sv_cur_obj = sv_stage4_obj;
				};
			};
			// Reset the time
			if (!isNil "sv_matchTimer_thread") then {
				terminate sv_matchTimer_thread;
			};
			// Start the timer again with additional time counting in the fallback phase
			_fallBackTime = paramsArray#8;
			[false, _fallBackTime] spawn server_fnc_matchTimer;

			// refresh tickets
			[] call server_fnc_refreshTickets;

			// Update everyones variable
			[["sv_cur_obj"]] spawn server_fnc_updateVars;
		};
	};
};

// Did we plant? Should be give ourself points?
if (_planter == player) then {
	// Wait until estimated explosion time
	_objective = sv_cur_obj;
	waitUntil {(_objective getVariable ["status", -1] == 3) || (_objective != sv_cur_obj)};

	// Still the same objective? Looks like we werent successful...
	if (_objective == sv_cur_obj) exitWith {};

	// We made it work yay
	["<t size='1.3' color='#FFFFFF'>OBJECTIVE DESTROYED</t>", 400] spawn client_fnc_pointfeed_add;
	[400] spawn client_fnc_addPoints;
};

// PROPER FORMATTING
// 0.6 * ( ( ( ( safezoneW / safezoneH ) min 1.2 ) / 1.2 ) / 25 )
