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

if (isNull _unit || _unit == player) then {
	["AMMUNITION REPLENISHED"] spawn client_fnc_displayInfo;
} else {
	[format["%1 HAS REPLENISHED YOUR AMMUNITION", (_unit getVariable ["name", ""])]] spawn client_fnc_displayInfo;
};

// Lets give us ammunition again :)
_equipInfo = [] call client_fnc_getLoadedEquipment;

if (true) then {
	// Primary
	_primary = _equipInfo select 0;
	_primaryClassname = _primary select 0;
	_primaryAttachements = _primary select 1;

	_primaryAmmo = getText(missionConfigFile >> "Unlocks" >> _primaryClassname >> "ammo");

	// Give ammo
	player addMagazines [_primaryAmmo, 2];
};

if (true) then {
	// Secondary
	_secondary = _equipInfo select 1;
	_secondaryClassname = _secondary select 0;
	_secondaryAttachements = _secondary select 1;

	_secondaryAmmo = getText(missionConfigFile >> "Unlocks" >> _secondaryClassname >> "ammo");

	// Give ammo
	player addMagazines [_secondaryAmmo, 2];
};


if (cl_class == "engineer" && cl_classPerk == "perkAA") then {
	player addMagazines ["Titan_AA", 1];
};

if (cl_class == "engineer" && cl_classPerk == "perkAT") then {
	player addMagazines ["RPG32_F", 1];
};