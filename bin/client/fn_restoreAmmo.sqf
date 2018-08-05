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

_unit = param[0,objNull,[objNull]];
_side = player getVariable "gameSide";

if (isNull _unit || _unit == player) then {
	["AMMUNITION REPLENISHED"] spawn client_fnc_displayInfo;
} else {
	[format["%1 HAS REPLENISHED YOUR AMMUNITION", _unit getVariable ["name", "ERROR: No Name"]]] spawn client_fnc_displayInfo;
};

// Lets give us ammunition again :)
_equipInfo = [] call client_fnc_getLoadedEquipment;

_primary = _equipInfo select 0;
if (_primary != "") then {
	// Primary
	_primaryClassname = _primary select 0;
	_primaryAttachements = _primary select 1;

	_primaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _primaryClassname >> "ammo");

	// Give ammo
	player addMagazines [_primaryAmmo, 2];
};

_secondary = _equipInfo select 1;
if (_secondary != "") then {
	// Secondary
	_secondaryClassname = _secondary select 0;
	_secondaryAttachements = _secondary select 1;

	_secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> _side >> _secondaryClassname >> "ammo");

	// Give ammo
	player addMagazines [_secondaryAmmo, 2];
};

if (cl_classPerk == "grenadier") then {
	_currentWeapon = _primary select 0;
	_cfgRifleGrenade = (missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "RifleGrenade");
	_rifles = getArray(_cfgRifleGrenade >> "rifles");
	if (_currentWeapon in _rifles) then {
		player addItem (getText(_cfgRifleGrenade >> "rifleGrenade"));
	};

	_grenade = getText(missionConfigFile >> "Soldiers" >> _side >> "Grenade" >> "weapon");
	player addItem _grenade;
};

if (cl_classPerk == "demolition") then {
	_explCharge = getText(missionConfigFile >> "Soldiers" >> _side >> "ExplosiveCharge" >> "weapon");
	player addItemToBackpack _explCharge;
};

if ("smoke_grenades" in cl_squadPerks) then {
	player addItem "SmokeShell";
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	_ammoName = getText(missionConfigFile >> "Soldiers" >> _side >> "Launcher" >> "ammoType");
	player addMagazines [_ammo, 1];
};
