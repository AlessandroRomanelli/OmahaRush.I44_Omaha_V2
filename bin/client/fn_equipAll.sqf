scriptName "fn_equipAll";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: MAV)
    File: fn_equipAll.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipAll.sqf"
if (isServer && !hasInterface) exitWith {};

// Give player loadout
private _side = player getVariable "gameSide";
private _sideLoadout = [] call client_fnc_getCurrentSideLoadout;

private _uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "uniforms"));
private _goggles = (getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "goggles"));
private _vests		 = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "vests"));
private _headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "headgears"));
private _backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "backpacks"));


if (count _uniforms > 0) then {player forceAddUniform (selectRandom _uniforms)};
if (_goggles != "") then {player addGoggles _goggles;};
if (count _vests > 0) then {player addVest (selectRandom _vests)};
if (count _headgears > 0) then {player addHeadgear (selectRandom _headgears)};
if (count _backpacks > 0) then {removeBackpackGlobal player; player addBackpack (selectRandom _backpacks);};

// Vest perk handler
/* if (cl_squadPerk == "extended_vest") then {
	player addVest "V_Press_F";
}; */

// Give weapons
[] spawn client_fnc_equipWeapons;

// Shared items
player addItem "ItemMap";
player assignITem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
