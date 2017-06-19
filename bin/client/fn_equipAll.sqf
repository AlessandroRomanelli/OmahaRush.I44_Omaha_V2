scriptName "fn_equipAll";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_equipAll.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipAll.sqf"
if (isServer && !hasInterface) exitWith {};

// Give player loadout
if (player getVariable "gameSide" == "defenders") then {
	_uniform = (getText(missionConfigFile >> "Soldiers" >> "Defenders" >> "uniform"));
	_goggles = (getText(missionConfigFile >> "Soldiers" >> "Defenders" >> "goggles"));
	_vest = (getText(missionConfigFile >> "Soldiers" >> "Defenders" >> "vest"));
	_headgear = (getText(missionConfigFile >> "Soldiers" >> "Defenders" >> "headgear"));
	_backpack = (getText(missionConfigFile >> "Soldiers" >> "Defenders" >> "backpack"));

	if (_uniform != "") then {player forceAddUniform _uniform;};
	if (_goggles != "") then {player addGoggles _goggles;};
	if (_vest != "") then {player addVest _vest;};
	if (_headgear != "") then {player addHeadgear _headgear;};
	if (_backpack != "") then {removeBackpackGlobal player;player addBackpack _backpack;};
} else {
	_uniform = (getText(missionConfigFile >> "Soldiers" >> "Attackers" >> "uniform"));
	_goggles = (getText(missionConfigFile >> "Soldiers" >> "Attackers" >> "goggles"));
	_vest = (getText(missionConfigFile >> "Soldiers" >> "Attackers" >> "vest"));
	_headgear = (getText(missionConfigFile >> "Soldiers" >> "Attackers" >> "headgear"));
	_backpack = (getText(missionConfigFile >> "Soldiers" >> "Attackers" >> "backpack"));

	if (_uniform != "") then {player forceAddUniform _uniform;};
	if (_goggles != "") then {player addGoggles _goggles;};
	if (_vest != "") then {player addVest _vest;};
	if (_headgear != "") then {player addHeadgear _headgear;};
	if (_backpack != "") then {removeBackpackGlobal player;player addBackpack _backpack;};
};

// Vest perk handler
if (cl_squadPerk == "extended_vest") then {
	player addVest "V_Press_F";
};

// Smoke grenade?
if (cl_squadPerk == "smoke_grenades") then {
	for "_i" from 1 to 2 do {player addItem "SmokeShell";};
};

// Give weapons
[] spawn client_fnc_equipWeapons;

// Shared items
player addItem "ItemMap";
player assignITem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
