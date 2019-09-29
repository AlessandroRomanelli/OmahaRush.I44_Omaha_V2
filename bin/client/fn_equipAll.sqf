scriptName "fn_equipAll";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: MAV)
    File: fn_equipAll.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipAll.sqf"
if (isServer && !hasInterface) exitWith {};

private _isBeingRevived = param[0, false, [false]];

// Give player loadout
private _side = player getVariable "gameSide";
private _sideLoadout = [] call client_fnc_getCurrentSideLoadout;

private ["_uniforms", "_goggles", "_vests", "_headgears", "_backpacks"];
if (cl_class isEqualTo "medic") then {
	_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "medics" >> "uniforms"));
	if (count _uniforms == 0) then {
		_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "uniforms"));
	};
	_vests = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "medics" >> "vests"));
	if (count _vests == 0) then {
		_vests		 = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "vests"));
	};
	_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "medics" >> "headgears"));
	if (count _headgears == 0) then {
		_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "headgears"));
	};
	_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "medics" >> "backpacks"));
	if (count _backpacks == 0) then {
		_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "backpacks"));
	};
} else {
	_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "uniforms"));
	_vests		 = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "vests"));
	_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "headgears"));
	_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "backpacks"));
};
_goggles = (getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "goggles"));

if ((count _uniforms > 0) && {(uniform player) isEqualTo ""}) then {player forceAddUniform (selectRandom _uniforms)};
if (_goggles != "") then {player addGoggles _goggles;};
if ((count _vests > 0) && {(vest player) isEqualTo ""}) then {player addVest (selectRandom _vests)};
if ((count _headgears > 0) && {(headgear player) isEqualTo ""}) then {player addHeadgear (selectRandom _headgears)};
if ((count _backpacks > 0) && {(backpack player) isEqualTo ""}) then {removeBackpackGlobal player; player addBackpack (selectRandom _backpacks);};

if ((uniform player) isEqualTo "") exitWith {[] call client_fnc_equipAll};

// Give weapons
[_isBeingRevived] call client_fnc_equipWeapons;

// Shared items
player addItem "ItemMap";
player assignITem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";

true
