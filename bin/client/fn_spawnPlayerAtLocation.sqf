scriptName "fn_spawnPlayerAtHQ";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnPlayerAtHQ.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayerAtHQ.sqf"
if (isServer && !hasInterface) exitWith {};

// Close spawn dialog
closeDialog 0;

private _side = player getVariable ["gameSide", "defenders"];
private _spawnName = param [0, "HQSpawn", [""]];
private _spawnConfig = missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> [] call client_fnc_getCurrentStageString >> "Spawns" >> _side >> _spawnName;

// Get spawn position
private _pos = getArray(_spawnConfig >> "positionATL");

private _spawnPos = _pos findEmptyPosition [0,20];

[] spawn client_fnc_equipAll;

private _idx = (_spawnPos nearEntities ["Man", 25]) findIf {(_x getVariable "gameSide") isEqualTo _side};
if !(_idx isEqualTo -1) exitWith {[] spawn client_fnc_spawnPlayerAtLocation;};

// Move player to spawn location
player setPos _spawnPos;

// Make player look into the direction of the objective
private _dir = _spawnPos getDir (getPos sv_cur_obj);
player setDir _dir;

// Move camera down to player, then delete it
cl_spawnmenu_cam camPreparePos (_spawnPos vectorAdd [0,0,2]);
cl_spawnmenu_cam camPrepareTarget sv_cur_obj;
cl_spawnmenu_cam camCommitPrepared 1;

private _PPon = [false, true] select (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1);
// Motion blurr
if (_PPon) then {
	["DynamicBlur", 400, [3]] spawn {
		params ["_name", "_priority", "_effect"];
		while {
			cl_spawnmenu_blur = ppEffectCreate [_name, _priority];
			cl_spawnmenu_blur < 0
		} do {
			_priority = _priority + 1;
		};
		cl_spawnmenu_blur ppEffectEnable true;
		cl_spawnmenu_blur ppEffectAdjust _effect;
		cl_spawnmenu_blur ppEffectCommit 0.1;
	};
};

sleep 0.7;

// Black fade out/in
2000 cutRsc ["rr_spawnPlayer","PLAIN"];
sleep 0.4;

// Delete blurry effect
if (_PPon) then {
	["DynamicBlur", 400, [0]] spawn {
		params ["_name", "_priority", "_effect"];
		while {
			cl_spawnmenu_blur = ppEffectCreate [_name, _priority];
			cl_spawnmenu_blur < 0
		} do {
			_priority = _priority + 1;
		};
		cl_spawnmenu_blur ppEffectEnable true;
		cl_spawnmenu_blur ppEffectAdjust _effect;
		cl_spawnmenu_blur ppEffectCommit 0.1;
	};
};

// Unmute sound
0.3 fadeSound 1;

cl_spawnmenu_cam cameraEffect ["TERMINATE","BACK"];
camDestroy cl_spawnmenu_cam;
player switchCamera "INTERNAL";

// Launch GUI
cl_gui_thread = [] spawn client_fnc_startIngameGUI;

// General success script
[] spawn cl_spawn_succ;

// Display help hint
if (player getVariable "gameSide" == "defenders") then {
	["DEFENDER", "Defend the objectives and kill all attackers trying to destroy them. Each killed attacker reduces their tickets. If it reaches zero, they have lost."] spawn client_fnc_hint;
} else {
	["ATTACKER", "Attack the objectives and blow them up, protect them for 60 seconds and move on before you run out of tickets. Each death reduces your ticket count."] spawn client_fnc_hint;
};

// Mark spawn tick
cl_spawn_tick = diag_tickTime;

// Display instructions hint for currently selected perk
[] spawn {
	sleep 10.3;
	private _instructions = [cl_classPerk] call client_fnc_getPerkInstructions;
	[_instructions select 0, _instructions select 1] spawn client_fnc_hint;
};
