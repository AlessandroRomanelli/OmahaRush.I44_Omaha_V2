scriptName "fn_spawnPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnPlayer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnPlayer.sqf"
if (isServer && !hasInterface) exitWith {};

if (isNil "cl_blockSpawnUntil") then {
	cl_blockSpawnUntil = serverTime;
};

private ["_blockedSpawn"];
if (isNil "cl_blockSpawnForSide") then {
	_blockedSpawn = false;
} else {
	_blockedSpawn = (cl_blockSpawnForSide == (player getVariable ["gameSide", "defenders"]));
};

// Check if spawning is currently allowed and if we are the side thats not allowed to spawn
if ((cl_blockSpawnUntil - serverTime > 0) && _blockedSpawn) exitWith {
	[format ["SPAWNING ALLOWED IN %1", [cl_blockSpawnUntil - serverTime, "MM:SS"] call bis_fnc_secondsToString]] spawn client_fnc_displayError;
};

if (cl_equipClassnames select 0 == "") exitWith {
	 ["YOU NEED TO CHOOSE A WEAPON BEFORE SPAWNING"] spawn client_fnc_displayError;
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
	["NO CLASS PERK SELECTED, PLEASE RESELECT ONE AND TRY AGAIN"] spawn client_fnc_displayError;
};

cl_classPerk = _perkData select 0;
cl_squadPerk = _perkData select 1;
[] call client_fnc_setSquadPerks;

cl_squadPerks = [] call client_fnc_getSquadPerks;

// Set class
cl_equipClassnames set [2, _class];

// Get value from listbox
private _value = (_d displayCtrl 9) lbValue (lbCurSel (_d displayCtrl 9));

// Successfull spawn inline function (stupid design) | Will be called from the child scripts if the spawn was successfull
cl_spawn_succ = {
	// Object action update
	[] spawn client_fnc_objectiveActionUpdate;

	if (isNil "cl_adsDisplay") then {
		cl_adsDisplay = [] spawn client_fnc_displayAds;
	};

	// GPS
	showGPS false;
	player setVariable ["isAlive", true];
	// Spawn protection
	[] spawn {
		sleep 0.5;
		player allowDamage true;
	};

	// Start ingame class functionality
	[] call client_fnc_initClass;

	// Start ingame perk functionality
	[] call client_fnc_initPerks;

	// Init hold actions
	[] spawn client_fnc_initHoldActions;

	// Out of spawn menu
	cl_inSpawnMenu = false;

	// Hide hud
	private _3dcursor = [false, true] select (paramsArray#17);
	showHUD [true,false,false,false,false,true,false,_3dcursor,false];

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

switch (_value) do
{
	case -2: // Vehicle (classname given as data)
	{
		private _configName = (_d displayCtrl 9) lbData (lbCurSel (_d displayCtrl 9));
		[_configName] spawn client_fnc_spawnPlayerInVehicle;
	};

	case -1: // HQ
	{
		[] spawn client_fnc_spawnPlayerAtHQ;
	};

	default // Beacon or squad member (squad member may be in vehicle)
	{
		private _data = (_d displayCtrl 9) lbData (lbCurSel (_d displayCtrl 9));

		// Soldier selected, is he in combat?
		if (_data == "inCombat") exitWith {
			["The selected player is in combat and cannot be spawned on"] spawn client_fnc_displayError;
		};

		// Get unit to spawn at
		private _unit = (units group player) select _value;
		private _beacon = _unit getVariable ["assault_beacon_obj", objNull];

		if (_data == "beacon") then {
			// Spawn at object
			if (!isNull _beacon) then {
				[_beacon, false] spawn client_fnc_spawnPlayerAtObject;

				// Give points
				if (_unit != player) then {
					[] remoteExec ["client_fnc_beaconSpawn", _unit];
				};
			} else {
				["The beacon is unavailable"] spawn client_fnc_displayError;
			};
		} else {
			// Spawn at object
			if (vehicle _unit == _unit) then {
				[_unit] spawn client_fnc_spawnPlayerAtObject;
			} else {
				[_unit, true, true] spawn client_fnc_spawnPlayerAtObject;
			};
		};
	};
};
