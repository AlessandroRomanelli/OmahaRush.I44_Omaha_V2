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

_swapItems = {
	params["_current_loadout", "_classNames", "_index", "_subindex"];
	_temp = _currentLoadout select _index;
	_temp set [_subindex, selectRandom _classNames];
	_currentLoadout set [_index, _temp];
	_currentLoadout;
};

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

if (count (_equipInfo select 1) != 0) then {
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

_side = player getVariable "gameSide";
_possibleLoadouts = (missionconfigfile >> "Soldiers" >> _side) call Bis_fnc_getCfgSubClasses;
_loadoutIdx = _side call BIS_fnc_getParamValue;
_sideLoadout = _possibleLoadouts select _loadoutIdx;

if (cl_class == "medic") then {
	_medic_uniforms = (getArray(missionConfigFile >> "Soldiers" >> format["%1", _side] >> _sideLoadout >> "medics" >> "uniforms"));
	_medic_vests = (getArray(missionConfigFile >> "Soldiers" >> format["%1", _side] >> _sideLoadout >> "medics" >> "vests"));
	_medic_headgears = (getArray(missionConfigFile >> "Soldiers" >> format["%1", _side] >> _sideLoadout >> "medics" >> "headgears"));
	_medic_backpacks = (getArray(missionConfigFile >> "Soldiers" >> format["%1", _side] >> _sideLoadout >> "medics" >> "backpacks"));

	_currentLoadout = getUnitLoadout player;
	_newLoadout = _currentLoadout;
	if (count _medic_uniforms > 0) then {_newLoadout = [_currentLoadout, _medic_uniforms, 3, 0] call _swapItems;};
	if (count _medic_vests > 0) then {_newLoadout = [_currentLoadout, _medic_vests, 4, 0] call _swapItems};
	if (count _medic_backpacks > 0) then {_newLoadout = [_currentLoadout, _medic_backpacks, 5, 0] call _swapItems};
	if (count _medic_headgears > 0) then {_newLoadout set [6, selectRandom _medic_headgears]};
	player setUnitLoadout _newLoadout;
};

if (cl_classPerk == "grenadier") then {
	if ("LIB_M1_Garand" isEqualTo (_primary select 0)) then {
		player addPrimaryWeaponItem "LIB_ACC_GL_M7";
		player addItem "LIB_1Rnd_G_Mk2";
	};
	if ("LIB_K98_Late" isEqualTo (_primary select 0)) then {
		player addPrimaryWeaponItem "LIB_ACC_GW_SB_Empty";
		player addItem "LIB_1Rnd_G_SPRGR_30";
	};

	if (_side == "defenders") then {
		for "_i" from 1 to 2 do {player addItem "LIB_shg24"};
	} else {
		for "_i" from 1 to 2 do {player addItem "LIB_US_Mk_2"};
	};
};

if (cl_classPerk == "demolition") then {
	removeBackpackGlobal player;
	if (_side == "defenders") then {
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
	if (_side == "attackers") then {
		removeBackpackGlobal player;
		player addBackpack "B_LIB_US_RocketBag_Empty";
		player addMagazine "LIB_1Rnd_60mm_M6";
		player addWeapon "LIB_M1A1_Bazooka";
		player addMagazine "LIB_1Rnd_60mm_M6";
	} else {
		removeBackpackGlobal player;
		player addBackpack "B_LIB_GER_Panzer_Empty";
		{player removeItemFromBackpack _x} forEach backpackItems player;
		player addItemToBackpack "LIB_1Rnd_RPzB";
		player addWeapon "LIB_RPzB";
		player addItemToBackpack "LIB_1Rnd_RPzB";
	};
};
