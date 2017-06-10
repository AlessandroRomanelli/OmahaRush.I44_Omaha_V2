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
["EXPLOSIVES ARMED","The radio station has been armed. Attackers will not lose tickets while it is."] spawn client_fnc_hint;

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
		while {sv_cur_obj getVariable ["armed",false] && _time >= 0} do {
			_time = _time - 1;
			sv_cur_obj say3D "beep";
			if (_time < 20) then {
				sleep 0.425;
				sv_cur_obj say3D "beep";
				sleep 0.425;
			} else {
				sleep 0.85;
			};
		};

		// was the mcom disarmed? If yes, just exit here, players will get a text displayed by the player who disarmed
		if (sv_cur_obj getVariable ["defused",false]) exitWith {
			sleep 1;
			sv_cur_obj setVariable ["defused",nil,true];
		};

		// Mark this mcom as done // e.g. used in matchTimer
		sv_cur_obj setVariable ["done", true, true];

		// Display message
		if (sv_cur_obj != sv_stage4_obj) then {
			// Mcom has been destroyed
			[true] remoteExec ["client_fnc_MCOMdestroyed"];
		};

		// Explosion
		"HelicopterExploBig" createVehicle getPos sv_cur_obj;

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
			//sv_matchTime = getNumber(missionConfigFile >> "Maps" >> sv_map >> "roundTime");
			if (!isNil "sv_matchTimer_thread") then {
				terminate sv_matchTimer_thread;
			};
			// Start the timer again with additional time counting in the fallback phase
			[false, (getNumber(missionConfigFile >> "GeneralConfig" >> "FallBackSeconds"))] spawn server_fnc_matchTimer;

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
		while {sv_cur_obj getVariable ["armed",false] && _time >= 0} do {
			_time = _time - 1;
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

	waitUntil {!(_objective getVariable ["armed",false]) || _objective != sv_cur_obj};

	// Still the same objective? Looks like we werent successful...
	if (_objective == sv_cur_obj) exitWith {};

	// We made it work yay
	["<t size='1.3' color='#FFFFFF'>RADIO STATION DESTROYED</t>", 400] spawn client_fnc_pointfeed_add;
	[400] spawn client_fnc_addPoints;
};

// PROPER FORMATTING
// 0.6 * ( ( ( ( safezoneW / safezoneH ) min 1.2 ) / 1.2 ) / 25 )
