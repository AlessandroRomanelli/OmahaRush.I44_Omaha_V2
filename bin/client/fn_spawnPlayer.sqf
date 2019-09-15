scriptName "fn_spawnPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A. Roman
    File: fn_spawnPlayer.sqf

    Written by both authors
    You're not allowed to use this file without permission from the authors!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayer.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

if (cl_equipClassnames select 0 == "") exitWith {
	 ["YOU NEED TO CHOOSE A WEAPON BEFORE SPAWNING"] call client_fnc_displayError;
};

if !((cl_equipClassnames select 0) in cl_equipConfigurations) exitWith {
	 ["YOU HAVE SELECTED AN INVALID WEAPON"] call client_fnc_displayError;
};

VARIABLE_DEFAULT(sv_setting_RoundTime, 15);
private _matchTime = sv_setting_RoundTime*60;
if (sv_matchTime > _matchTime && (player getVariable ["gameSide", "attackers"]) isEqualTo "attackers") exitWith {
	[format["YOU ARE NOT ALLOWED TO SPAWN JUST YET! %1S LEFT"], sv_matchTime - _matchTime] call client_fnc_displayError;
};

disableSerialization;
private _d = findDisplay 5000;

// Class and perks
private _class = param[0,"medic",[""]];

private _isClassRestricted = [_class] call client_fnc_checkClassRestriction;
if (_isClassRestricted) exitWith {};

cl_class = _class;
private _perkData = [cl_class] call client_fnc_getUsedPerksForClass;
if ((count _perkData) isEqualTo 0) then {
	["NO CLASS PERK SELECTED, PLEASE RESELECT ONE AND TRY AGAIN"] call client_fnc_displayError;
};

cl_classPerk = _perkData select 0;
cl_squadPerk = _perkData select 1;
[] call client_fnc_setSquadPerks;

cl_squadPerks = [] call client_fnc_getSquadPerks;

// Set class
cl_equipClassnames set [2, _class];

// Get value from listbox
private _spawnCtrl = _d displayCtrl 8;
private _vehiclesCtrl = _d displayCtrl 9;
private _value = if !((lbCurSel _spawnCtrl) isEqualTo -1) then {
	_spawnCtrl lbValue (lbCurSel _spawnCtrl);
} else {
	_vehiclesCtrl lbValue (lbCurSel _vehiclesCtrl);
};

// Successfull spawn inline function (stupid design) | Will be called from the child scripts if the spawn was successfull
cl_spawn_succ = {
	if (isNil "cl_adsDisplay") then {
		cl_adsDisplay = [] spawn client_fnc_displayAds;
	};

	// GPS
	showGPS false;
	player setVariable ["isAlive", true];
	// Spawn protection
	[] spawn {
		uiSleep 0.5;
		player allowDamage true;
	};

	// Start ingame class functionality
	[] call client_fnc_initClass;

	// Start ingame perk functionality
	[] call client_fnc_initPerks;

	// Init hold actions
	[] call client_fnc_initHoldActions;

	// Out of spawn menu
	cl_inSpawnMenu = false;

	// Hide hud
	showHUD [true,false,false,false,false,true,false,true,false];

	// Run check if we have been moved to an OK position, if not, move us to our HQ, failed spawn as it seems...
	if (player distance cl_safePos < 100) then {
		// we are on the debug island, move us to our hq as our spawn is bugged apparently
		if (player getVariable "gameSide" == "defenders") then {
			player setPos (getMarkerPos "mobile_respawn_defenders");
		} else {
			player setPos (getMarkerPos "mobile_respawn_attackers");
		};
	};
};

/* private _deleteBlurr = {
	// Delete blurry effect
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
}; */

[] spawn client_fnc_saveStatistics;

private _spawnDisplay = _d displayCtrl 8;
private _data = _spawnDisplay lbData (lbCurSel _spawnDisplay);

switch (_value) do
{
	case -2: // Vehicle (classname given as data)
	{
		private _vehiclesDisplay = _d displayCtrl 9;
		private _configName = _vehiclesDisplay lbData (lbCurSel _vehiclesDisplay);
		[_configName] call client_fnc_spawnPlayerInVehicle;
	};

	case -1: // HQ
	{
		[_data] call client_fnc_spawnPlayerAtLocation;
	};

	default // Beacon or squad member (squad member may be in vehicle)
	{
		// Soldier selected, is he in combat?
		if (_data == "inCombat") exitWith {
			["The selected player is in combat and cannot be spawned on"] call client_fnc_displayError;
		};

		// Get unit to spawn at
		private _unit = objectFromNetID _data;
		if (isNull _unit) then {
			_unit = (units group player) select _value;
		};
		private _beacon = _unit getVariable ["assault_beacon_obj", objNull];

		if (_data == "beacon") then {
			// Spawn at object
			if (!isNull _beacon) then {
				// Give points
				if (_unit != player) then {
					[] remoteExecCall ["client_fnc_beaconSpawn", _unit];
				};
				[_beacon, false] call client_fnc_spawnPlayerAtObject;

			} else {
				["The beacon is unavailable"] call client_fnc_displayError;
			};
		} else {
			// Spawn at object
			if (vehicle _unit == _unit) then {
				[_unit] call client_fnc_spawnPlayerAtObject;
			} else {
				[_unit, true, true] call client_fnc_spawnPlayerAtObject;
			};
		};
	};
};
