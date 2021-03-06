scriptName "fn_spawnPlayerInVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
	File: fn_spawnPlayerInVehicle.sqf

	<Maverick Applications>
	Written by Maverick Applications (www.maverick-apps.de)
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayerInVehicle.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

private _configName = param[0,"",[""]];

// Equip
[] call client_fnc_equipAll;

private _vehicle = missionNamespace getVariable [_configName, objNull];

if (isNull _vehicle) exitWith {["Vehicle unavailable"] call client_fnc_displayError;};

private _enemyWithin = (fullCrew _vehicle) findIf {!(SAME_SIDE(player, _x))};
if (_enemyWithin >= 0) exitWith {
	["Vehicle has been hijacked"] call client_fnc_displayError;
};

// Put player into vehicle
private _vehicleNoSpace = !([_vehicle] call client_fnc_moveUnitIntoVehicle);

// Was the vehicle full?
if (_vehicleNoSpace) exitWith {
	["Vehicle full"] call client_fnc_displayError;
};

// Close spawn dialog
closeDialog 0;

// Move camera down to player, then delete it
cl_spawnmenu_cam camPreparePos (getPosATL _vehicle);
cl_spawnmenu_cam camPrepareTarget sv_cur_obj;
cl_spawnmenu_cam camCommitPrepared 1;

// Motion blurr
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
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

uiSleep 0.7;

// Black fade out/in
2000 cutRsc ["rr_spawnPlayer","PLAIN"];
uiSleep 0.4;

// Delete blurry effect
if (getNumber(missionConfigFile >> "GeneralConfig" >> "PostProcessing") == 1) then {
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

// General success script
[] call cl_spawn_succ;

cl_spawnmenu_cam cameraEffect ["TERMINATE","BACK"];
camDestroy cl_spawnmenu_cam;

// Launch GUI
[] call client_fnc_startIngameGUI;

// Display help hint

if (IS_DEFENDING(player)) then {
	["DEFENDER", "Defend the objectives and kill all attackers trying to destroy them. Each killed attacker reduces their tickets. If it reaches zero, they have lost."] spawn client_fnc_hint;
} else {
	["ATTACKER", "Attack the objectives and plant explosives on them, hold them for 60 seconds and move on before you run out of tickets. Each death reduces your ticket count."] spawn client_fnc_hint;
};

// Display instructions hint for currently selected perk
uiSleep 10.3;
private _instructions = [cl_classPerk] call client_fnc_getPerkInstructions;
[_instructions select 0, _instructions select 1] spawn client_fnc_hint;
