scriptName "fn_equipWeapons";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_equipWeapons.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipWeapons.sqf"
if (isServer && !hasInterface) exitWith {};

// Inline function to swap an item within the loadout of a unit
private _swapItems = {
	params["_currentLoadout", "_classNames", "_index", "_subindex"];
	private _temp = _currentLoadout select _index;
	_temp set [_subindex, selectRandom _classNames];
	_currentLoadout set [_index, _temp];
	_currentLoadout;
};

// Get equip
private _equipInfo = [] call client_fnc_getLoadedEquipment;

// Get primary and secondary classnames
private _primary = _equipInfo select 0;
private _secondary = _equipInfo select 1;

// Is the unit being revived? If so, no ammo resupply
private _isBeingRevived = param[0,false,[false]];


private _side = player getVariable "gameSide";
private _sideLoadout = [] call client_fnc_getCurrentSideLoadout;

// If the player is a medic equip him with medic gear to distinguish from non medics
if (cl_class isEqualTo "medic") then {
	private _medic_uniforms = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "uniforms"));
	private _medic_vests = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "vests"));
	private _medic_headgears = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "headgears"));
	private _medic_backpacks = (getArray(missionConfigFile >> "Soldiers" >> _side >> _sideLoadout >> "medics" >> "backpacks"));

	private _currentLoadout = getUnitLoadout player;
	private _newLoadout = +_currentLoadout;
	if (count _medic_uniforms > 0) then {_newLoadout = [_currentLoadout, _medic_uniforms, 3, 0] call _swapItems;};
	if (count _medic_vests > 0) then {_newLoadout = [_currentLoadout, _medic_vests, 4, 0] call _swapItems};
	if (count _medic_backpacks > 0) then {_newLoadout = [_currentLoadout, _medic_backpacks, 5, 0] call _swapItems};
	if (count _medic_headgears > 0) then {_newLoadout set [6, selectRandom _medic_headgears]};
	player setUnitLoadout _newLoadout;

	// If he has the smoke grenades perk, equip them
	if ((cl_classPerk isEqualTo "smoke_grenades") && (!_isBeingRevived)) then {
		for "_i" from 1 to 2 do {player addItem "SmokeShell"};
	};
};

// If the player is a grenadier
if ((cl_class isEqualTo "assault") && (cl_classPerk isEqualTo "grenadier")) then {
	private _cfgRifleGrenade = (missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "RifleGrenade");
	private _rifles = getArray(_cfgRifleGrenade >> "rifles");
	private _count = if ("expl" in cl_squadPerks) then {2} else {1};

	// If the rifle is grenade launcher capable
	if (_primary in _rifles) then {
		// Add the attachment and give ammo
		player addPrimaryWeaponItem (getText(_cfgRifleGrenade >> "attachment"));
		if (!_isBeingRevived) then {
			for "_i" from 1 to _count do {player addItem (getText(_cfgRifleGrenade >> "rifleGrenade"))};
		};
	};

	//Give the grenadier some grenades, right?
	private _grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	if (!_isBeingRevived) then {
		for "_i" from 1 to _count do {player addItem _grenade};
	};
};

// If the player is a demo engineer
if ((cl_class isEqualTo "engineer") && (cl_classPerk isEqualTo "demolition")) then {
	private _backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "backpack");
	private _explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
	// Give a bigger backpack
	if !(_backpack isEqualTo "") then {
		removeBackpackGlobal player;
		player addBackpack _backpack;
	};
	// Give him his explosives charges
	private _count = if ("expl" in cl_squadPerks) then {3} else {1};
	if (!_isBeingRevived) then {
		for "_i" from 1 to _count do {player addItemToBackpack _explCharge};
	};
};

// If the player is a AT engineer
if ((cl_class isEqualTo "engineer") && (cl_classPerk isEqualTo "perkAT")) then {
	// Fetch the launcher data
	private _cfgLauncher = (missionConfigFile >> "Soldiers" >> _side >> "Launcher");
	private _backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "ATbackpack");
	private _launcher = getText(_cfgLauncher >> "weapon");
	private _ammoName = getText(_cfgLauncher >> "ammoType");
	private _ammoCount = getNumber(_cfgLauncher >> "ammoCount");
	removeBackpackGlobal player;
	// Give him a rocket launcher backpack
	player addBackpack _backpack;
	{player removeItemFromBackpack _x} forEach backpackItems player;
	// Give him 1 rounds first, the weapon and then the rest of the rounds (so that it doesn't have to reload it)
	if (!_isBeingRevived) then {
		player addMagazine _ammoName;
	};
	player addWeaponGlobal _launcher;
	if (("expl" in cl_squadPerks) && (!_isBeingRevived)) then {
		for "_i" from 2 to _ammoCount do {player addMagazine _ammoName};
	};
};

if (_primary != "") then {
	// Primary
	private _primaryAmmo = getText(missionConfigFile >> "Unlocks" >> format["%1", player getVariable "gameSide"] >> _primary >> "ammo");
	// Give ammo
	if (!_isBeingRevived) then {
		// Extended ammo perk
		if ("ammo" in cl_squadPerks) then {
			player addMagazines [_primaryAmmo, 6];
		} else {
			player addMagazines [_primaryAmmo, 3];
		};
	};
	// Give weapon
	player addWeaponGlobal _primary;
};

if (_secondary != "") then {
	private _secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _secondary >> "ammo");
	// Give ammo
	if (!_isBeingRevived) then {
		// Extended ammo perk
		if ("ammo" in cl_squadPerks) then {
			player addMagazines [_secondaryAmmo, 4];
		} else {
			player addMagazines [_secondaryAmmo, 2];
		};
	};
	// Give weapon
	player addWeaponGlobal _secondary;
};

// If someone in the squad has the frag perk, give out a grenade
if ("frag" in cl_squadPerks) then {
	private _grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	if (!_isBeingRevived) then {
		player addMagazine _grenade;
	};
};
