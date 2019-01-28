scriptName "fn_restoreAmmo";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_restoreAmmo.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_restoreAmmo.sqf"
if (isServer && !hasInterface) exitWith {};

private _unit = param[0,objNull,[objNull]];
private _side = player getVariable "gameSide";

if (isNull _unit || _unit == player) then {
	["AMMUNITION REPLENISHED"] spawn client_fnc_displayInfo;
} else {
	[format["%1 HAS REPLENISHED YOUR AMMUNITION", [_unit] call client_fnc_getUnitName]] spawn client_fnc_displayInfo;
};

playSound3D [WWRUSH_ROOT+"sounds\reload.ogg", player];

private _rearmMagazines = {
	private _magName = param[0, "", [""]];
	private _weaponType = param[1, "", [""]];
	private _weapon = if (_weaponType isEqualTo "primary") then {primaryWeapon player} else {handgunWeapon player};
	private _magBulletCount = getNumber(configFile >> "cfgMagazines" >> _magName >> "count");
	private _targetBulletCount = if ("ammo" in cl_squadPerks) then {6*_magBulletCount} else {4*_magBulletCount};
	private _currentMags = (magazinesAmmoFull player) select {(_x select 0) isEqualTo _magName};
	private _currentBulletCount = 0;
	{
			_currentBulletCount = _currentBulletCount + (_x select 1);
	} forEach _currentMags;
	private _minimumMags = floor (_currentBulletCount/_magBulletCount);
	private _leftovers = _currentBulletCount - (_minimumMags*_magBulletCount);
	player removeMagazines _magName;
	player removeWeapon _weapon;
	player addMagazines [_magName, _minimumMags];
	if (_leftovers > 0) then { player addMagazine [_magName, _leftovers]; };
	player addWeapon _weapon;
	private _bulletsNeeded = if ((_targetBulletCount - _currentBulletCount) < 0) then {0} else {_targetBulletCount - _currentBulletCount};
	private _magsNeeded = _bulletsNeeded/_magBulletCount;
	// Give ammo
	if (_magsNeeded > 0 && _magsNeeded < 2) then {
		player removeMagazines _magName;
		player removeWeapon _weapon;
		player addMagazines [_magName, _targetBulletCount/_magBulletCount];
		player addWeapon _weapon;
	};
	if (_magsNeeded >= 2) then {
		player addMagazines [_magName, 2];
	}
};

private _items = [];
_items append (backpackItems player);
_items append (vestItems player);
_items append (uniformItems player);

// Lets give us ammunition again :)
private _equipInfo = [] call client_fnc_getLoadedEquipment;

private _primary = _equipInfo select 0;
if (_primary != "") then {
	// Primary
	private _primaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _primary >> "ammo");
	private _primaryWeaponMags = getArray(configFile >> "CfgWeapons" >> primaryWeapon player >> "magazines");
	if (_primaryAmmo in _primaryWeaponMags) then {
		[_primaryAmmo, "primary"] call _rearmMagazines;
	} else {
		[_primaryWeaponMags select 0, "primary"] call _rearmMagazines;
	};
};

private _secondary = _equipInfo select 1;
if (_secondary != "") then {
	// Secondary
	private _secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _secondary >> "ammo");
	private _secondaryWeaponMags = getArray(configFile >> "CfgWeapons" >> handgunWeapon player >> "magazines");
	if (_secondaryAmmo in _secondaryWeaponMags) then {
		[_secondaryAmmo, "secondary"] call _rearmMagazines;
	} else {
		[_secondaryWeaponMags select 0, "secondary"] call _rearmMagazines;
	};
	// Give ammo
};

if (cl_classPerk == "grenadier") then {
	private _cfgRifleGrenade = (missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "RifleGrenade");
	private _rifles = getArray(_cfgRifleGrenade >> "rifles");
	private _maxGrenades = if ("expl" in cl_squadPerks) then {2} else {1};
	private _rifleGrenadeName = getText(_cfgRifleGrenade >> "rifleGrenade");
	private _currentRifleGrenades = {(_x select 0) isEqualTo _rifleGrenadeName} count (magazinesAmmoFull player);
	if (_currentRifleGrenades < _maxGrenades && _primary in _rifles) then {
		player addPrimaryWeaponItem (getText(_cfgRifleGrenade >> "attachment"));
		player addMagazine _rifleGrenadeName;
	};
	private _handGrenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	private _currentHandGrenades = {(_x select 0) isEqualTo _handGrenade} count (magazinesAmmoFull player);
	if (_currentHandGrenades < _maxGrenades) then {
		player addItem _handGrenade;
	};
};

if (cl_classPerk == "demolition") then {
	private _explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
	private _maxExplosives = if ("expl" in cl_squadPerks) then {3} else {1};

	private _currentExplosives = {_x isEqualTo _explCharge} count _items;
	if (_currentExplosives < _maxExplosives) then {
		player addItemToBackpack _explCharge;
	};
};

if (cl_class == "medic" && cl_classPerk == "smoke_grenades") then {
	private _smokeName = "SmokeShell";
	private _currentSmokes = {_x isEqualTo _smokeName} count _items;
	if (_currentSmokes < 2) then {
		player addItem _smokeName;
	};
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	private _ammo = getText(missionConfigFile >> "Soldiers" >> _side >> "Launcher" >> "ammoType");
	private _max = getNumber(missionConfigFile >> "Soldiers" >> _side >> "Launcher" >> "ammoCount");
	private _currentRockets = {(_x select 0) isEqualTo _ammo} count (magazinesAmmo player);
	if (_currentRockets == 0) then {
		player addMagazines [_ammo, 1];
	} else {
		if (("expl" in cl_squadPerks) && {_currentRockets < _max}) then {
			player addMagazines [_ammo, 1];
		};
	};
};

if ("frag" in cl_squadPerks) then {
	private _handGrenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	private _currentHandGrenades = {(_x select 0) isEqualTo _handGrenade} count (magazinesAmmoFull player);
	if (_currentHandGrenades < 1) then {
		player addItem _handGrenade;
	};
};

true
