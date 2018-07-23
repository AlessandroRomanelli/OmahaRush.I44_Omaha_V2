scriptName "fn_spawnPlayerInVehicle";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
	File: fn_spawnPlayerInVehicle.sqf

	<Maverick Applications>
	Written by Maverick Applications (www.maverick-apps.de)
	You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayerInVehicle.sqf"
if (isServer && !hasInterface) exitWith {};

_configName = param[0,"",[""]];

_side = if (player getVariable "gameSide" == "defenders") then {"Defender"} else {"Attacker"};
_config = (missionConfigFile >> "MapSettings" >> "PersistentVehicles" >> _side >> _configName);

// If the config is null its most likely a stage vehicle
if (isNull _config) then {
	if (player getVariable "gameSide" == "defenders") then {
		_config = (missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Vehicles" >> "Defender" >> _configName);
	} else {
		_config = (missionConfigFile >> "MapSettings" >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Vehicles" >> "Attacker" >> _configName);
	};
};

_pos = getArray(_config >> "positionATL");
_class = getText(_config >> "classname");
_displayName = getText(_config >> "displayName");
_objects = nearestObjects [_pos, [_class], 5];
if (count _objects < 1) exitWith {["Vehicle unavailable"] spawn client_fnc_displayError;};

_vehicle = _objects select 0;

// Put player into vehicle
_vehicleNoSpace = !([player, _vehicle] call client_fnc_moveUnitIntoVehicle);

// Was the vehicle full?
if (_vehicleNoSpace) exitWith {
	["Vehicle full"] spawn client_fnc_displayError;
};

// Close spawn dialog
closeDialog 0;

// Equip
[] spawn client_fnc_equipAll;

// Move camera down to player, then delete it
cl_spawnmenu_cam camPreparePos (getPosATL _vehicle);
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

// HELICOPTER ONLY: MAKE SURE WE HAVE FLARES
/*if (_vehicle isKindOf "B_Heli_Light_01_armed_F") then {
	while {!("CMFlareLauncher" in (weapons _vehicle))} do {
		_vehicle addWeaponGlobal "CMFlareLauncher";
		_vehicle addWeapon "CMFlareLauncher";
		_vehicle addMagazines ["120Rnd_CMFlare_Chaff_Magazine", 1];
	};
};*/

// General success script
[] spawn cl_spawn_succ;

cl_spawnmenu_cam cameraEffect ["TERMINATE","BACK"];
camDestroy cl_spawnmenu_cam;
player switchCamera "INTERNAL";

// Launch GUI
cl_gui_thread = [] spawn client_fnc_startIngameGUI;

// Display flares help if we are in a air vehicle
if (_vehicle isKindOf "Air") then {
	[] spawn client_fnc_displayCountermeasureKeys;
};

// Display help hint
if (player getVariable "gameSide" == "defenders") then {
	["DEFENDER", "Defend the objectives and kill all attackers trying to destroy them. Each killed attacker reduces their tickets. If it reaches zero, they have lost."] spawn client_fnc_hint;
} else {
	["ATTACKER", "Attack the objectives and plant explosives on them, hold them for 60 seconds and move on before you run out of tickets. Each death reduces your ticket count."] spawn client_fnc_hint;
};

// Display instructions hint for currently selected perk
[] spawn {
	sleep 10.3;
	_instructions = [cl_classPerk] call client_fnc_getPerkInstructions;
	[_instructions select 0, _instructions select 1] spawn client_fnc_hint;

	// Reload mcom interaction
	[] spawn client_fnc_objectiveActionUpdate;
};
