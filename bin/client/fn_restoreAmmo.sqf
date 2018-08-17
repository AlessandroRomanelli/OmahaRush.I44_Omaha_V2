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
	[format["%1 HAS REPLENISHED YOUR AMMUNITION", _unit getVariable ["name", "ERROR: No Name"]]] spawn client_fnc_displayInfo;
};

// Lets give us ammunition again :)
private _equipInfo = [] call client_fnc_getLoadedEquipment;

private _primary = _equipInfo select 0;
if (_primary != "") then {
	// Primary
	private _primaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _primary >> "ammo");
	// Give ammo
	player addMagazines [_primaryAmmo, 2];
};

private _secondary = _equipInfo select 1;
if (_secondary != "") then {
	// Secondary
	private _secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _secondary >> "ammo");

	// Give ammo
	player addMagazines [_secondaryAmmo, 2];
};

if (cl_classPerk == "grenadier") then {
	private _currentWeapon = _primary select 0;
	private _cfgRifleGrenade = (missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "RifleGrenade");
	private _rifles = getArray(_cfgRifleGrenade >> "rifles");
	if (_currentWeapon in _rifles) then {
		player addItem (getText(_cfgRifleGrenade >> "rifleGrenade"));
	};
	private _grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	player addItem _grenade;
};

if (cl_classPerk == "demolition") then {
	private _explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
	player addItemToBackpack _explCharge;
};

if (cl_class == "medic" && cl_classPerk == "smoke_grenades") then {
	player addItem "SmokeShell";
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	private _ammo = getText(missionConfigFile >> "Soldiers" >> _side >> "Launcher" >> "ammoType");
	player addMagazines [_ammo, 1];
};
