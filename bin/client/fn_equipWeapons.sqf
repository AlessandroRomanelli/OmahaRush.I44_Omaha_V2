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

_primary = _equipInfo select 0;
if (count _primary != 0) then {
	// Primary
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
};

_secondary = _equipInfo select 1;
if (count _secondary != 0) then {
	// Secondary
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

_side = player getVariable "gameSide";
_sideLoadout = [] call client_fnc_getCurrentSideLoadout;
if (cl_class == "medic") then {
	_medic_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "uniforms"));
	_medic_vests = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "vests"));
	_medic_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "headgears"));
	_medic_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "backpacks"));

	_currentLoadout = getUnitLoadout player;
	_newLoadout = +_currentLoadout;
	if (count _medic_uniforms > 0) then {_newLoadout = [_currentLoadout, _medic_uniforms, 3, 0] call _swapItems;};
	if (count _medic_vests > 0) then {_newLoadout = [_currentLoadout, _medic_vests, 4, 0] call _swapItems};
	if (count _medic_backpacks > 0) then {_newLoadout = [_currentLoadout, _medic_backpacks, 5, 0] call _swapItems};
	if (count _medic_headgears > 0) then {_newLoadout set [6, selectRandom _medic_headgears]};
	player setUnitLoadout _newLoadout;
};

if (cl_classPerk == "grenadier") then {
	_currentWeapon = _primary select 0;
	_cfgRifleGrenade = (missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "RifleGrenade");
	_rifles = getArray(_cfgRifleGrenade >> "rifles");
	_count = if (cl_squadPerk == "extended_ammo") then {2} else {4};
	if (_currentWeapon in _rifles) then {
		player addPrimaryWeaponItem (getText(_cfgRifleGrenade >> "attachment"));
		for "_i" from 1 to _count do {player addItem (getText(_cfgRifleGrenade >> "rifleGrenade"))};
	};

	_grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	for "_i" from 1 to _count do {player addItem _grenade};
};

if (cl_classPerk == "demolition") then {
	removeBackpackGlobal player;
	_backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "backpack");
	_explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
	player addBackpack _backpack;
	_count = if (cl_squadPerk == "extended_ammo") then {1} else {3};
	for "_i" from 1 to _count do {player addItemToBackpack _explCharge};
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	_cfgLauncher = (missionConfigFile >> "Soldiers" >> _side >> "Launcher");
	_backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "ATbackpack");
	_launcher = getText(_cfgLauncher >> "weapon");
	_ammoName = getText(_cfgLauncher >> "ammoType");
	_ammoCount = getNumber(_cfgLauncher >> "ammoCount");
	removeBackpackGlobal player;
	player addBackpack _backpack;
	{player removeItemFromBackpack _x} forEach backpackItems player;
	[player, _launcher, _ammoCount, _ammoName] call BIS_fnc_addWeapon;
};
