scriptName "fn_loadSpawnpoints";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadSpawnpoints.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadSpawnpoints.sqf"

#define COLOR_RED [0.51,0,0,1]
#define COLOR_BLUE [0,0.3,0.6,1]

if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _d = findDisplay 5000;

// Clear listbox of any spawnpoints
private _spawnCtrl = _d displayCtrl 8;
private _vehiclesCtrl = _d displayCtrl 9;
lbClear _spawnCtrl;
lbClear _vehiclesCtrl;

private _side = player getVariable ["side", side player];
private _playerIsDefending = _side isEqualTo WEST;

private _configs = configProperties [
	missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> sv_cur_obj getVariable ["cur_stage", "Stage1"] >> "Spawns" >> ["attackers", "defenders"] select _playerIsDefending,
	"true",
	false
];

{
  _spawnCtrl lbAdd (getText(_x >> "name"));
  private _ctrlIdx = (lbSize _spawnCtrl) - 1;
	_spawnCtrl lbSetPicture [_ctrlIdx, WWRUSH_ROOT+"pictures\teammate.paa"];
	_spawnCtrl lbSetValue [_ctrlIdx, -1];
	_spawnCtrl lbSetData [_ctrlIdx, configName _x];
} forEach _configs;

private _fnc_appendBeacon = {
  params [["_unit", objNull, [objNull]], ["_index", -1, [0]]];
  _spawnCtrl lbAdd ((_unit getVariable ["name", name _unit]) + "'s Beacon");
  private _ctrlIdx = (lbSize _spawnCtrl) - 1;
  _spawnCtrl lbSetData [_ctrlIdx, "beacon"];
  _spawnCtrl lbSetValue [_ctrlIdx, _index];
  _spawnCtrl lbSetPicture [_ctrlIdx, "\a3\ui_f\data\Map\MapControl\bunker_CA.paa"];
  _spawnCtrl lbSetPictureColor [_ctrlIdx, COLOR_BLUE];
  true
};

private _fnc_appendUnit = {
  params [["_unit", objNull, [objNull]], ["_index", -1, [0]]];
  private _icon = [_unit] call client_fnc_getUnitIcon;
  // Find enemies within 25m radius
  private _nearbyEnemies = {(_unit getVariable ["side", side _unit]) != (_x getVariable ["side", side _x])} count (_unit nearEntities ["Man", 25]);
  // If the unit was hit or is nearby enemies
  if (damage _unit > 0.1 || {_nearbyEnemies > 0} || {!(_unit inArea playArea)}) exitWith {
    if !(_unit inArea playArea) then {
      _spawnCtrl lbAdd ((_unit getVariable ["name", name _unit]) + " (TOO FAR)");
    } else {
      _spawnCtrl lbAdd ((_unit getVariable ["name", name _unit]) + " (IN COMBAT)");
    };
    private _ctrlIdx = (lbSize _spawnCtrl) - 1;
    _spawnCtrl lbSetColor [_ctrlIdx, COLOR_RED];
    _spawnCtrl lbSetValue [_ctrlIdx, _index];
    _spawnCtrl lbSetData [_ctrlIdx, "inCombat"];
    _spawnCtrl lbSetPicture [_ctrlIdx, _icon];
    _spawnCtrl lbSetPictureColor [_ctrlIdx, COLOR_RED];
    true
  };


  _spawnCtrl lbAdd (_unit getVariable ["name", name _unit]);
  private _ctrlIdx = (lbSize _spawnCtrl) - 1;
  _spawnCtrl lbSetValue [_ctrlIdx, _index];
  _spawnCtrl lbSetData [_ctrlIdx, netID _unit];
  _spawnCtrl lbSetPicture [_ctrlIdx, _icon];
  _spawnCtrl lbSetPictureColor [_ctrlIdx, COLOR_BLUE];
  true
};

// Load squad members
{
  // If unit is alive AND is not the player AND (player NOT defending OR the unit is the leader OR player is the leader)
  // If the player is attacking, he can spawn on any group member, whereas if he's defending, he can only spawn on the leader
  if (alive _x && {_x inArea playArea} && {_x != player} && {!_playerIsDefending || (_x == (leader group player)) || ((leader group player) == player)}) then {
    [_x, _forEachIndex] call _fnc_appendUnit;
  };

  private _beacon = _x getVariable ["assault_beacon_obj", objNull];
  // If there is a valid beacon
  if (!isNull _beacon && {_beacon inArea playArea}) then {
    [_x, _forEachIndex] call _fnc_appendBeacon;
  };
} forEach (units group player);


// Get configs of vehicles we can spawn at (PERSISTENT ONES)
private _configs = [];
private _side = ["Attacker", "Defender"] select (_playerIsDefending);
_configs append ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "PersistentVehicles" >> _side));
_configs append ("true" configClasses (missionConfigFile >> "MapSettings" >> sv_mapSize >> "Stages" >> (sv_cur_obj getVariable ["cur_stage", "Stage1"]) >> "Vehicles" >> _side));


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
	if (!isNull _vehicle && {(_seats - _occupants) > 0} && {(_vehicle distance2D _initialPos) < 50} && {_vehicle isKindOf "Air" || {_vehicle isKindOf "Land" && _vehicle inArea playArea}}) then {
		_vehiclesCtrl lbAdd (format ["%1 (%2/%3)",_displayName, _occupants, _seats]);
    private _ctrlIdx = (lbSize _vehiclesCtrl) - 1;
		_vehiclesCtrl lbSetData [_ctrlIdx, _configName];
		_vehiclesCtrl lbSetValue [_ctrlIdx, -2];
		_vehiclesCtrl lbSetPicture [_ctrlIdx, getText(configFile >> "CfgVehicles" >> _className >> "Icon")];
	};
} forEach _configs;
true
