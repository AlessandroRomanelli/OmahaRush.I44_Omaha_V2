scriptName "fn_spawnPlayerAtObject";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnPlayerAtObject.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayerAtObject.sqf"
if (isServer && !hasInterface) exitWith {};

// Unit
private _unit = param[0,objNull,[objNull]];
private _sendPoints = param[1,true,[true]];
private _inVehicle = param[2,false,[false]];

// CHECKS TO DO BEFORE SPAWNING

private _nearbyEnemies = {player getVariable ["gameSide", ""] != _x getVariable ["gameSide", ""]} count (_unit nearEntities ["Man", 25]) > 0;

// Invalid spawnpoint check (spawnpoint is not within the playable area)
if ((!alive _unit) || (_unit distance sv_cur_obj) > 5000 || _nearbyEnemies) exitWith {
	// The spawnpoint is unavailable, do not spawn the player here
	["Spawnpoint unavailable"] call client_fnc_displayError;
};

private _vehicleNoSpace = false;
// Put player into vehicle
if (_inVehicle) then {
	private _vehicle = vehicle _unit;
  _vehicleNoSpace = !([_vehicle] call client_fnc_moveUnitIntoVehicle);
};

// Was the vehicle full?
if (_vehicleNoSpace) exitWith {
	["Vehicle full"] call client_fnc_displayError;
};

// Close spawn dialog
closeDialog 0;

private _spawnPos = _unit modelToWorld [0,-1,0];

// Beacon?
if (_unit isKindOf "LIB_GerRadio" || _unit isKindOf "LIB_SovRadio") then {
	_spawnPos = _unit modelToWorld [0,0,0];
};

// Equip
[] call client_fnc_equipAll;

if (!_inVehicle) then { // Normal on-unit-spawn
	// Move player to spawn location
	player setPos _spawnPos;

	// Make player look into the direction of the objective
	player setDir (getDir _unit);
} else { // In-vehicle-spawn

};

// Give units points
if (_sendPoints) then {
	[] remoteExecCall ["client_fnc_squadSpawn",_unit];
};

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
[] call client_fnc_startIngameGUI;

// General success script
[] call cl_spawn_succ;

// Display help hint
if (player getVariable "gameSide" == "defenders") then {
	["DEFENDER", "Defend the objectives and kill all attackers trying to destroy them. Each killed attacker reduces their tickets. If it reaches zero, they have lost."] spawn client_fnc_hint;
} else {
	["ATTACKER", "Attack the objectives and blow them up, protect them for 60 seconds and move on before you run out of tickets. Each death reduces your ticket count."] spawn client_fnc_hint;
};

// Display instructions hint for currently selected perk
sleep 10.3;
private _instructions = [cl_classPerk] call client_fnc_getPerkInstructions;
[_instructions select 0, _instructions select 1] call client_fnc_hint;
