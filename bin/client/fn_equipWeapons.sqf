scriptName "fn_equipWeapons";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_equipWeapons.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_equipWeapons.sqf"
if (isServer && !hasInterface) exitWith {};

private _fnc_equipBayo = {
	private _primary = param [0, "", [""]];
	if (_primary == "") exitWith {false};
	private _result = false;
	private _compatibles = getArray(configFile >> "CfgWeapons" >> _primary >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
	private _idx = _compatibles findIf {["bayo", _x] call BIS_fnc_inString};
	if (_idx > -1) then {
		player addPrimaryWeaponItem (_compatibles select _idx);
		_result = true;
	};
	_result
};

// Get equip
private _equipInfo = player getVariable ["loaded_equipment", [cl_equipClassnames select 0, cl_equipClassnames select 1]];

// Get primary and secondary classnames
private _primary = _equipInfo select 0;
private _secondary = _equipInfo select 1;

// Is the unit being revived? If so, no ammo resupply
private _isBeingRevived = param[0,false,[false]];


private _side = player getVariable "gameSide";
private _sideLoadout = [] call client_fnc_getCurrentSideLoadout;
private _str = "1";

// Smoke grenades to those who have the class perk
if ((cl_classPerk isEqualTo "smoke_grenades") && (!_isBeingRevived)) then {
	_str = _str + "2";
	for "_i" from 1 to 2 do {player addItem "SmokeShell"};
};
// Engineer
if (cl_class isEqualTo "engineer") then {
	_str = _str + "3";
	// Demo Engineer Loadout
	if (cl_classPerk isEqualTo "demolition") then {
		_str = _str + "4";
		private _backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "backpack");
		private _explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
		// Give a bigger backpack
		if !(_backpack isEqualTo "") then {
			_str = _str + "5";
			removeBackpackGlobal player;
			player addBackpack _backpack;
		};
		// Give him his explosives charges
		private _count = if ("expl" in cl_squadPerks) then {2} else {1};
		if (!_isBeingRevived) then {
			_str = _str + "6";
			for "_i" from 1 to _count do {player addItemToBackpack _explCharge};
		};
	};

	// AT Engineer loadout
	if (cl_classPerk isEqualTo "perkAT") then {
		_str = _str + "7";
		// Fetch the launcher data
		private _cfgLauncher = (missionConfigFile >> "Soldiers" >> _side >> "Launcher");
		private _backpack = getText(missionConfigFile >> "Soldiers" >> _side >> "Loadouts" >> _sideLoadout >> "ATbackpack");
		private _launcher = getText(_cfgLauncher >> "weapon");
		private _ammoName = getText(_cfgLauncher >> "ammoType");
		private _ammoCount = getNumber(_cfgLauncher >> "ammoCount");
		removeBackpack player;
		// Give him a rocket launcher backpack
		player addBackpack _backpack;
		{player removeItemFromBackpack _x} forEach (backpackItems player);
		// Give him 1 rounds first, the weapon and then the rest of the rounds (so that it doesn't have to reload it)
		if (!_isBeingRevived) then {
			_str = _str + "8";
			player addMagazine _ammoName;
		};
		player addWeapon _launcher;
		if (("expl" in cl_squadPerks) && (!_isBeingRevived)) then {
			_str = _str + "9";
			for "_i" from 2 to _ammoCount do {player addMagazine _ammoName};
		};
	};
};

systemChat _str;

if (_primary != "") then {
	// Primary
	private _primaryAmmo = getText(missionConfigFile >> "Unlocks" >> format["%1", player getVariable ["gameSide", "attackers"]] >> _primary >> "ammo");
	// Give ammo
	if (!_isBeingRevived) then {
		// Extended ammo perk
		if ("ammo" in cl_squadPerks) then {
			player addMagazines [_primaryAmmo, 6];
		} else {
			player addMagazines [_primaryAmmo, 4];
		};
	};
	// Give weapon
	player removeWeapon (primaryWeapon player);
	player addWeapon _primary;
};

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
	} else {
		[_primary] call _fnc_equipBayo;
	};
} else {
	[_primary] call _fnc_equipBayo;
};

if (_secondary != "") then {
	private _secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> (player getVariable ["gameSide", "attackers"]) >> _secondary >> "ammo");
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
	player removeWeapon (handgunWeapon player);
	player addWeapon _secondary;
};

if (!(cl_classPerk isEqualTo "grenadier" || {"frag" in cl_squadPerks}) || _isBeingRevived) exitWith {};
private _count = if (cl_classPerk isEqualTo "grenadier" && {"frag" in cl_squadPerks}) then {2} else {1};
private _grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
private _currentNades = count ((itemsWithMagazines player) select {_x isEqualTo _grenade});
for "_i" from _currentNades to _count do {
	player addItem _grenade
};

true
