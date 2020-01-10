scriptName "fn_MCOMarmed";
/*--------------------------------------------------------------------
	Author: A. Roman
	File: fn_MCOMarmed.sqf

	Written by A. Roman
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MCOMarmed.sqf"
#include "..\utils.h"

if (!isServer) exitWith {};

// Start sound loop if we are the server
TERMINATE_SCRIPT(sv_mcom_thread);

sv_mcom_thread = [] spawn {
    // Countdown of 60 seconds
    private _time = 60;
    private _soundTime = 60;
	private _start = diag_tickTime;
    waitUntil {IS_OBJ_ARMED || {diag_tickTime - _start > 2.5}};
	if (diag_tickTime - _start > 2.5) exitWith {
		terminate sv_mcom_thread;
		sv_mcom_thread = nil;
	};
    private _status = OBJ_STATUS_ARMED;
    private _beep = WWRUSH_ROOT + "sounds\beep.ogg";

    private _obj = sv_cur_obj;
    // If the objective is armed and there's still time on the clock
    playSound3D [_beep, _obj, false, getPosATL _obj, 3, 1, 500];
    while {
		_status = sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED];
		(_status in [OBJ_STATUS_IN_USE, OBJ_STATUS_ARMED]) && _time >= 0 && _obj == sv_cur_obj
	} do {
        // Count down only if the objective is being armed
        if (_status == OBJ_STATUS_ARMED) then {
            _time = _time - 1;
        };
        private _timeFrame = (((floor (_time / 10)) min 2) + 1) max 1;
        if (_soundTime % _timeFrame == 0) then {
            playSound3D [_beep, _obj, false, getPosATL _obj, 2, 1, 500];
        };
        _soundTime = _soundTime - 1;
        uiSleep 1;
    };

	if (_obj != sv_cur_obj) exitWith {};

    // was the mcom disarmed? If yes, just exit here, players will get a text displayed by the player who disarmed
    if (_time > 0 || {!(_status in [OBJ_STATUS_IN_USE, OBJ_STATUS_ARMED])}) exitWith {
        uiSleep 1;
        _obj setVariable ["status", OBJ_STATUS_UNARMED,true];
    };

    // Mark this mcom as done // e.g. used in matchTimer
    _obj setVariable ["status", OBJ_STATUS_DONE, true];

    // Display message
    if (_obj != sv_stage4_obj) then {
        // Mcom has been destroyed
        [true] remoteExec ["client_fnc_MCOMdestroyed", 0];
    };

    private _pos = getPosATL _obj;
    _obj enableSimulation true;
    _obj allowDamage true;
    // Explosion
    createVehicle ["HelicopterExploBig", _pos, [], 0, "CAN_COLLIDE"];
    _obj setDamage 1;

    private _killZone = _obj nearEntities ["Man", 25];
    {
        if ((_x distance _obj < 10) || {_x distance _obj < 25 && {([_obj, "VIEW"] checkVisibility [eyePos _obj, eyePos _x]) > 0.1}}) then {
            ["You were killed by the blast of the explosion"] remoteExecCall ["client_fnc_administrationKill", _x];
        };
    } forEach _killZone;

    private _nextObj = sv_cur_obj getVariable ["next_obj", objNull];
    // Trigger win
    if (isNull _nextObj) exitWith {
        [] call server_fnc_endRound;
    };
    sv_cur_obj = _nextObj;
    // Reset the time
    TERMINATE_SCRIPT(sv_matchTimer_thread);
    // Start the timer again with additional time counting in the fallback phase
    private _fallBackTime = [] call client_fnc_getFallbackTime;
    sv_matchTimer_thread = [false, _fallBackTime] spawn server_fnc_matchTimer;

    // refresh tickets
    [] call server_fnc_refreshTickets;

    // Update everyones variable
    [["sv_cur_obj"]] call server_fnc_updateVars;
    sv_mcom_thread = nil;
};
