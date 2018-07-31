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

// Make the UI at the top blink
[] spawn client_fnc_objectiveArmedGUIAnimation;

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
		// Countdown
		_time = 71; // Original time 71 = 60 seconds (95 = 80 seconds)
		_status = sv_cur_obj getVariable ["status", -1];
		// If the objective is armed and there's still time on the clock
		while {((_status == 1) || (_status == 0)) && _time >= 0} do {
			_status = sv_cur_obj getVariable ["status", -1];
			// Freeze time if the objective is being armed
			if (_status == 0) then {
				_time = _time;
			} else {
				_time = _time - 1;
			};
			sv_cur_obj say3D "beep";
			if (_time < 20) then {
				sleep 0.425;
				sv_cur_obj say3D "beep";
				sleep 0.425;
			} else {
				sleep 0.85;
			};
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
			[true] remoteExec ["client_fnc_MCOMdestroyed"];
		};

		// Explosion
		"HelicopterExploBig" createVehicle getPos sv_cur_obj;
		if ((player distance sv_cur_obj < 10) || (player distance sv_cur_obj < 25 && (([sv_cur_obj, "VIEW"] checkVisibility [eyePos sv_cur_obj, eyePos player]) > 0.1))) then {
			player setDamage 1;
			["You were killed by the blast of the charge"] spawn client_fnc_displayError;
		};
		sv_cur_obj setVariable ["positionAGL", nil];

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
			//sv_matchTime = getNumber(missionConfigFile >> "MapSettings" >> "roundTime");
			if (!isNil "sv_matchTimer_thread") then {
				terminate sv_matchTimer_thread;
			};
			// Start the timer again with additional time counting in the fallback phase
			_fallBackTime = "FallBackSeconds" call bis_fnc_getParamValue;
			[false, _fallBackTime] spawn server_fnc_matchTimer;

			// refresh tickets
			[] call server_fnc_refreshTickets;

			[] remoteExec ["client_fnc_objectiveActionUpdate",0];

			// Update everyones variable
			[["sv_cur_obj"]] spawn server_fnc_updateVars;
		};
	};
};

// Local sound loop
if (!_wasServer) then {
	[] spawn {
		_time = 71;
		_status = sv_cur_obj getVariable ["status", -1];
		while {(_status == 0 || _status == 1) && _time >= 0} do {
			_status = sv_cur_obj getVariable ["status", -1];
			// Freeze time if the objective is being armed
			if (_status == 0) then {
				_time = _time;
			} else {
				_time = _time - 1;
			};
			sv_cur_obj say3D "beep";
			if (_time < 20) then {
				sleep 0.425;
				sv_cur_obj say3D "beep";
				sleep 0.425;
			} else {
				sleep 0.85;
			};
		};
	};
};


// Did we plant? Should be give ourself points?
if (_planter == player) then {
	// Wait until estimated explosion time
	_objective = sv_cur_obj;
	_status = _objective getVariable ["status", -1];
	waitUntil {_status != 1 || _objective != sv_cur_obj};

	// Still the same objective? Looks like we werent successful...
	if (_objective == sv_cur_obj) exitWith {};

	// We made it work yay
	["<t size='1.3' color='#FFFFFF'>OBJECTIVE DESTROYED</t>", 400] spawn client_fnc_pointfeed_add;
	[400] spawn client_fnc_addPoints;
};

// PROPER FORMATTING
// 0.6 * ( ( ( ( safezoneW / safezoneH ) min 1.2 ) / 1.2 ) / 25 )
