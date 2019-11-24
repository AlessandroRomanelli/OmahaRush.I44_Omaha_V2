scriptName "fn_populateAdminArea.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_populateAdminArea.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_populateAdminArea.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _created = params [["_adminDisplay", displayNull, [displayNull]]];

if (!_created) then {
	_adminDisplay = findDisplay 7000;
};

private _mapsPool = ((getArray(missionConfigFile >> "GeneralConfig" >> "mapsPool")) apply {[_x, (_x splitString ".") select 1]}) apply {[_x select 0, getText(configFile >> "CfgWorlds" >> _x select 1 >> "description")]};

private _mapList = _adminDisplay displayCtrl 1502;

lbClear _mapList;
{
	_x params ["_mission", "_world"];
	_mapList lbAdd _world;
	_mapList lbSetData [lbSize _mapList - 1, _mission];
} forEach _mapsPool;

private _attackersList = _adminDisplay displayCtrl 1500;
private _attackers = allPlayers select {_x getVariable ["side", side _x] == EAST};
lbClear _attackersList;
{
	_attackersList lbAdd (_x getVariable ["name", name _x]);
	_attackersList lbSetData [lbSize _attackersList - 1, netId _x];
} forEach _attackers;

(_adminDisplay displayCtrl 1001) ctrlSetText format ["Attackers [%1]", count _attackers];

private _defendersList = _adminDisplay displayCtrl 1501;
private _defenders = allPlayers select {_x getVariable ["side", side _x] == WEST};
lbClear _defendersList;
{
	_defendersList lbAdd (_x getVariable ["name", name _x]);
	_defendersList lbSetData [lbSize _defendersList - 1, netId _x];
} forEach _defenders;

(_adminDisplay displayCtrl 1002) ctrlSetText format ["Defenders [%1]", count _defenders];
