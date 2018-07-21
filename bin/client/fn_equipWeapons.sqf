scriptName "fn_equipWeapons";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_equipWeapons.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipWeapons.sqf"
if (isServer && !hasInterface) exitWith {};

// Get equip
_equipInfo = [] call client_fnc_getLoadedEquipment;

// No mags? (Revive)
_noMags = param[0,false,[false]];

if (true) then {
	// Primary
	_primary = _equipInfo select 0;
	_primaryClassname = _primary select 0;
	_primaryAttachements = _primary select 1;

	_primaryAmmo = getText(missionConfigFile >> "Unlocks" >> format["%1", player getVariable "gameSide"] >> _primaryClassname >> "ammo");

	// Give ammo
	if (!_noMags) then {
		// Extended ammo perk
		if (cl_squadPerk == "extended_ammo") then {
			player addMagazines [_primaryAmmo, 6];
		} else {
			player addMagazines [_primaryAmmo, 4];
		};
	};

	// Give weapon
	player addWeaponGlobal _primaryClassname;

	// Add attachments
	{
		player addPrimaryWeaponItem _x;
	} forEach _primaryAttachements;

	// Sniper scope perk
	/*if (cl_classPerk == "assault_scope") then {
		player addPrimaryWeaponItem "optic_KHS_blk";
	};*/
};

if (true) then {
	// Secondary
	_secondary = _equipInfo select 1;
	_secondaryClassname = _secondary select 0;
	_secondaryAttachements = _secondary select 1;

	_secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _secondaryClassname >> "ammo");

	// Give ammo
	if (!_noMags) then {
		// Extended ammo perk
		if (cl_squadPerk == "extended_ammo") then {
			player addMagazines [_secondaryAmmo, 6];
		} else {
			player addMagazines [_secondaryAmmo, 4];
		};
	};

	// Give weapon
	player addWeaponGlobal _secondaryClassname;

	// Add attachments
	{
		player addHandgunItem _x;
	} forEach _secondaryAttachements;
};


/*if (cl_class == "engineer" && cl_classPerk == "perkAA") then {
	player addBackpack "B_Kitbag_rgr";

	// Extended ammo perk
	if (cl_squadPerk == "extended_ammo") then {
		player addMagazines ["Titan_AA", 2];
	} else {
		player addMagazines ["Titan_AA", 1];
	};
	player addWeapon "launch_B_Titan_tna_F";
};*/

_primary = _equipInfo select 0;
_primaryAttachements = _primary select 1;

if (cl_classPerk == "grenadier") then {
	if ("LIB_M1_Garand" isEqualTo (_primary select 0)) then {
		player addPrimaryWeaponItem "LIB_ACC_GL_M7";
		player addItem "LIB_1Rnd_G_Mk2";
	};
	if ("LIB_K98_Late" isEqualTo (_primary select 0)) then {
		player addPrimaryWeaponItem "LIB_ACC_GW_SB_Empty";
		player addItem "LIB_1Rnd_G_SPRGR_30";
	};

	if (player getVariable "gameSide" == "defenders") then {
		for "_i" from 1 to 2 do {player addItem "LIB_shg24"};
	} else {
		for "_i" from 1 to 2 do {player addItem "LIB_US_Mk_2"};
	};
};

if (cl_classPerk == "demolition") then {
	removeBackpackGlobal player;
	if (player getVariable "gameSide" == "defenders") then {
		removeBackpackGlobal player;
		player addBackpack "B_LIB_GER_SapperBackpack_empty";
		for "_i" from 1 to 3 do {player addItemToBackpack "LIB_Ladung_Small_MINE_mag";};
	} else {
		removeBackpackGlobal player;
		player addBackpack "B_LIB_US_Backpack";
		for "_i" from 1 to 3 do {player addItemToBackpack "LIB_Ladung_Small_MINE_mag";};
	};
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	switch (player getVariable "gameSide") do {
		case "attackers": {
			removeBackpackGlobal player;
			player addBackpack "B_LIB_US_RocketBag_Empty";
			player addMagazine "LIB_1Rnd_60mm_M6";
			player addWeapon "LIB_M1A1_Bazooka";
			player addMagazine "LIB_1Rnd_60mm_M6";
		};
		case "defenders": {
			removeBackpackGlobal player;
			player addBackpack "B_LIB_GER_Panzer_Empty";
			{player removeItemFromBackpack _x} forEach backpackItems player;
			player addItemToBackpack "LIB_1Rnd_RPzB";
			player addWeapon "LIB_RPzB";
			player addItemToBackpack "LIB_1Rnd_RPzB";
		};
	};
};
