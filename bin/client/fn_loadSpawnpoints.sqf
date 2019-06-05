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
	_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, WWRUSH_ROOT+"pictures\teammate.paa"];
	_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, -1];
	_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, configName _x];
} forEach _configs;

private _getIconPlayer = {
  private _unit = param [0, objNull, [objNull]];
  private _class = _unit getVariable ["class", ""];
  if (_class isEqualTo "") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconMan_ca.paa"};
  if (_unit isEqualTo (leader group _unit)) exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManCommander_ca.paa"};
  if (_class isEqualTo "medic") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManMedic_ca.paa"};
  if (_class isEqualTo "assault") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManLeader_ca.paa"};
  if (_class isEqualTo "engineer") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManEngineer_ca.paa"};
  if (_class isEqualTo "support") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManMG_ca.paa"};
  if (_class isEqualTo "recon") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManLeader_ca.paa"};
};

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

		private _beacon = _x getVariable ["assault_beacon_obj", objNull];
		if (!isNull _beacon) then {
			_add = true;
		};

		if (_add) then {
			if (!isNull _beacon) then {
				// Spawn beacon
				_spawnCtrl lbAdd ([_x] call client_fnc_getUnitName + "'s Beacon");
				_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, "beacon"];
				_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
				_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, "\a3\ui_f\data\Map\MapControl\bunker_CA.paa"];
				_spawnCtrl lbSetPictureColor [(lbSize _spawnCtrl) - 1, [0,0.3,0.6,1]];
			} else {
				// Player
				private _unit = _x;
        private _icon = [_x] call _getIconPlayer;
				// Find enemies within 20m radius
				private _nearbyEnemies = {(_unit getVariable "gameSide") != (_x getVariable "gameSide")} count (_x nearEntities ["Man", 25]);
				// If the unit was hit or is nearby enemies
				if (_x getVariable ["inCombat", false] || {_nearbyEnemies > 0}) then {
					_spawnCtrl lbAdd (([_x] call client_fnc_getUnitName) + " (IN COMBAT)");
					_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
					_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, "inCombat"];
					_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, _icon];
					_spawnCtrl lbSetPictureColor [(lbSize _spawnCtrl) - 1, [0.51,0,0,1]];
				} else {
					_spawnCtrl lbAdd ([_x] call client_fnc_getUnitName);
					_spawnCtrl lbSetValue [(lbSize _spawnCtrl) - 1, _index];
					_spawnCtrl lbSetData [(lbSize _spawnCtrl) - 1, netID _unit];
					_spawnCtrl lbSetPicture [(lbSize _spawnCtrl) - 1, _icon];
					_spawnCtrl lbSetPictureColor [(lbSize _spawnCtrl) - 1, [0,0.3,0.6,1]];
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
  private _initialPos = getArray(_x >> "positionATL");
	private _displayName = getText(_x >> "displayName");
	private _className = getText(_x >> "className");
  private _configName = configName _x;
  private _vehicle = missionNamespace getVariable [_configName, objNull];
  private _crew = fullCrew [_vehicle, "", true];
  private _seats = count _crew;
  private _occupants = {!isNull (_x select 0)} count _crew;
	// Check whether this array of found vehicles actually containers our vehicle
	if (!isNull _vehicle && {(_seats - _occupants) > 0} && {(_vehicle distance2D _initialPos) < 50}) then {
		_vehiclesCtrl lbAdd (format ["%1 (%2/%3)",_displayName, _occupants, _seats]);
		_vehiclesCtrl lbSetData [(lbSize _vehiclesCtrl) - 1, _configName];
		_vehiclesCtrl lbSetValue [(lbSize _vehiclesCtrl) - 1, -2];
		_vehiclesCtrl lbSetPicture [(lbSize _vehiclesCtrl) - 1, getText(configFile >> "CfgVehicles" >> _className >> "Icon")];
	};
} forEach _configs;
true
