scriptName "fn_loadSpawnpoints";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadSpawnpoints.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadSpawnpoints.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _d = findDisplay 5000;

// Clear listbox of any spawnpoints
private _spawnCtrl = _d displayCtrl 8;
private _vehiclesCtrl = _d displayCtrl 9;
lbClear _spawnCtrl;
lbClear _vehiclesCtrl;

private _side = player getVariable ["gameSide", "defenders"];
private _playerIsDefending = _side isEqualTo "defenders";

private _configs = configProperties [missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> [] call client_fnc_getCurrentStageString >> "Spawns" >> _side, "true", false];

{
  _spawnCtrl lbAdd (getText(_x >> "name"));
	_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "pictures\teammate.paa"];
	_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, -1];
	_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, configName _x];
} forEach _configs;

/* // Load HQ spawnpoint
if (_playerIsDefending) then {
	_spawnCtrl lbAdd "Defender HQ";
} else {
	_spawnCtrl lbAdd "Attacker HQ";
};

// HQ Icon
_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "pictures\teammate.paa"];
_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, -1];
_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, "Spawn HQ"]; */

// Load squad members
private _index = -1;
{
	_index = _index + 1;

	if ((isPlayer _x && {_x distance sv_cur_obj < 1500} && {alive _x}) || {_x == player} || {!isNull (_x getVariable ["assault_beacon_obj", objNUll])}) then {
		private _add = false;

		// If unit is alive AND is not the player AND (player NOT defending OR the unit is the leader OR player is the leader)
		// If the player is attacking, he can spawn on any group member, whereas if he's defending, he can only spawn on the leader
		if (alive _x && {_x != player} && {!_playerIsDefending || (_x == (leader group player)) || ((leader group player) == player)}) then {
			_add = true;
		};
/*
		if (alive _x && {_x != player}) then {
			if (_playerIsDefending) then {
				if (_x == (leader group player)) then {
					_add = true;
				};
				if ((leader group player) == player) then {
				_add = true;
				};
			} else {
				_add = true;
			};
		}; */

		private _beacon = _x getVariable ["assault_beacon_obj", objNull];
		if (!isNull _beacon) then {
			_add = true;
		};

		if (_add) then {
			if (!isNull _beacon) then {
				// Spawn beacon
				_spawnCtrl lbAdd ((_x getVariable ["name", "ERROR: No Name"]) + "'s Beacon");
				_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, "beacon"];
				_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
				_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "pictures\squad.paa"];
			} else {
				// Player
				private _unit = _x;
				// Find enemies within 20m radius
				private _nearbyEnemies = {(_unit getVariable "gameSide") != (_x getVariable "gameSide")} count (_x nearEntities ["Man", 25]);
				// If the unit was hit or is nearby enemies
				if (_x getVariable ["inCombat", false] || {_nearbyEnemies > 0}) then {
					_spawnCtrl lbAdd ((_x getVariable ["name", "ERROR: No Name"]) + " (IN COMBAT)");
					_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
					_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, "inCombat"];
					_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "pictures\enemy.paa"];
				} else {
					_spawnCtrl lbAdd (_x getVariable ["name", "ERROR: No Name"]);
					_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
					_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, netID _unit];
					_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "pictures\squad.paa"];
				};
			};
		};
	};
} forEach (units group player);


// Get configs of vehicles we can spawn at (PERSISTENT ONES)
private _configs = [];
private _side = ["Attacker", "Defender"] select (_playerIsDefending);
_configs append ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "PersistentVehicles" >> _side));
_configs append ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> ([] call client_fnc_getCurrentStageString) >> "Vehicles" >> _side));


{
	private _pos = getArray(_x >> "positionATL");
	private _class = getText(_x >> "classname");
	private _displayName = getText(_x >> "displayName");
	private _objects = nearestObjects [_pos, [_class], 20];
	private _config = _x;
	if (count _objects > 0) then {
		// Check whether this array of found vehicles actually containers our vehicle
		private _OK = (_objects findIf {_x getVariable ["id", ""] isEqualTo (configName _config)}) != -1;
		if (_OK) then {
			_vehiclesCtrl lbAdd _displayName;
			_vehiclesCtrl lbSetData [(lbSize _vehiclesCtrl) - 1, configName _x];
			_vehiclesCtrl lbSetValue [(lbSize _vehiclesCtrl) - 1, -2];
			_vehiclesCtrl lbSetPicture [(lbSize _vehiclesCtrl) - 1, "pictures\teammate.paa"];
		};
	};
} forEach _configs;
