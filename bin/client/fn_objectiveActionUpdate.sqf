scriptName "fn_objectiveActionUpdate";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_objectiveActionUpdate.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_objectiveActionUpdate.sqf"
if (isServer && !hasInterface) exitWith {};

// MAKE THIS FILE OBSOLETE
if (true) exitWith {};

// Sense of this file is to delete all exiting actions on the objectives and create the one we actually need!
{
	[_x, _x getVariable ["actionID", -1]] call BIS_fnc_holdActionRemove;
	removeAllActions _x;
} forEach [sv_stage1_obj,sv_stage2_obj,sv_stage3_obj,sv_stage4_obj];

// Get the stage
_stage = [] call client_fnc_getCurrentStageString;

// Condition
_cond = "";
_text = "";
_completion = {};
if ((player getVariable ["side", sideUnknown]) == WEST) then {
	_text = "Disarm Explosives";
	_cond = "(_target distance _this) < 2 && (_target getVariable ['armed',false])";
	_completion = {if (_target distance player < 2) then {[] spawn client_fnc_disarmMCOM;};};
} else {
	_text = "Set Explosives";
	_cond = "(_target distance _this) < 2 && !(_target getVariable ['armed',false])";
	_completion = {if (_target distance player < 2) then {[] spawn client_fnc_armMCOM;};};
};

// Add action to current objective
_id = [
/* 0 object */							sv_cur_obj,
/* 1 action title */					_text,
/* 2 idle icon */						"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\upload_ca.paa",
/* 3 progress icon */					"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\upload_ca.paa",
/* 4 condition to show */				_cond,
/* 5 condition for action */			"true",
/* 6 code executed on start */			{[sv_cur_obj, "arm"] remoteExec ["client_fnc_say3D",0]},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */		_completion,
/* 9 code executed on interruption */	{},
/* 10 arguments */						[],
/* 11 action duration */				4,
/* 12 priority */						10000,
/* 13 remove on completion */			false,
/* 14 show unconscious */				false
] call bis_fnc_holdActionAdd;

//
sv_cur_obj setVariable ["actionID",_id];
