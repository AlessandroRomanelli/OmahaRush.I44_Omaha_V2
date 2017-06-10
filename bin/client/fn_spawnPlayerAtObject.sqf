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
_unit = param[0,objNull,[objNull]];
_sendPoints = param[1,true,[true]];
_inVehicle = param[2,false,[false]];

// CHECKS TO DO BEFORE SPAWNING
// Invalid spawnpoint check (spawnpoint is not within the playable area)
if ((!alive _unit) || (_unit distance sv_cur_obj) > 5000) exitWith {
	// The spawnpoint is unavailable, do not spawn the player here
	["Spawnpoint unavailable"] spawn client_fnc_displayError;
};

_vehicleNoSpace = false;
// Put player into vehicle
if (_inVehicle) then {
	_vehicle = vehicle _unit;
	_vehicleNoSpace = !([player, _vehicle] call client_fnc_moveUnitIntoVehicle);
};

// Was the vehicle full?
if (_vehicleNoSpace) exitWith {
	["Vehicle full"] spawn client_fnc_displayError;
};

// Close spawn dialog
closeDialog 0;

_spawnPos = _unit modelToWorld [0,-1,0];

// Beacon?
if (_unit isKindOf "Land_Laptop_device_F") then {
	_spawnPos = _unit modelToWorld [0,0,0];
};

// Equip
[] spawn client_fnc_equipAll;

if (!_inVehicle) then { // Normal on-unit-spawn
	// Move player to spawn location
	player setPos _spawnPos;

	// Make player look into the direction of the objective
	player setDir (getDir _unit);
} else { // In-vehicle-spawn

};

// Give units points
if (_sendPoints) then {
	[] remoteExec ["client_fnc_squadSpawn",_unit];
};

// Move camera down to player, then delete it
cl_spawnmenu_cam camPreparePos (ASLToATL (eyePos player));
cl_spawnmenu_cam camPrepareTarget sv_cur_obj;
cl_spawnmenu_cam camCommitPrepared 1;

// Motion blurr
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
	0 = ["DynamicBlur", 400, [3]] spawn {
		params ["_name", "_priority", "_effect", "_handle"];
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
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
	0 = ["DynamicBlur", 400, [0]] spawn {
		params ["_name", "_priority", "_effect", "_handle"];
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
if (playerSide == WEST) then {
	["DEFENDER", "Defend the radio stations and kill all attackers trying to destroy them. Each killed attacker reduces their tickets. If it reaches zero, they have lost."] spawn client_fnc_hint;
} else {
	["ATTACKER", "Attack the radio stations and blow them up, protect them for 60 seconds and move on before you run out of tickets. Each death reduces your ticket count."] spawn client_fnc_hint;
};

// Display instructions hint for currently selected perk
[] spawn {
	sleep 10.3;
	_instructions = [cl_classPerk] call client_fnc_getPerkInstructions;
	[_instructions select 0, _instructions select 1] spawn client_fnc_hint;
	// Reload mcom interaction
	[] spawn client_fnc_objectiveActionUpdate;
};
