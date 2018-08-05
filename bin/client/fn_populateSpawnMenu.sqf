scriptName "fn_populateSpawnMenu";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_populateSpawnMenu.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_populateSpawnMenu.sqf"
if (isServer && !hasInterface) exitWith {};

// Arma..
disableSerialization;

// Get dialog
_d = findDisplay 5000;

// Get selected equip to be displayed
_equip = [] call client_fnc_getLoadedEquipment;
_primary = _equip select 0;
_secondary = _equip select 1;
if (_primary == "") then {
	(_d displayCtrl 5) ctrlSetStructuredText parseText "<t size='4' color='#990000' shadow='2' font='PuristaMedium' align='center'>N/A</t>";
	(_d displayCtrl 1001) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON SELECTED</t>";
	(_d displayCtrl 2002) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO SELECT]</t>";
};

if (_secondary == "") then {
	(_d displayCtrl 7) ctrlSetStructuredText parseText "<t size='4' color='#990000' shadow='2' font='PuristaMedium' align='center'>N/A</t>";
	_secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "type")) == "secondary"};
	if (count _secondaryWeapons != 0) then {
		(_d displayCtrl 1004) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON SELECTED</t>";
		(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO SELECT]</t>";
	} else {
		(_d displayCtrl 1004) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON AVAILABLE</t>";
		(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[PROGRESS TO UNLOCK MORE]</t>";
	};
};

// Validate
[] call client_fnc_validateEquipment;

// Display primary and secondary
if (_primary != "") then {
	(_d displayCtrl 5) ctrlSetStructuredText parseText ("<t align='center' shadow='2' size='5'><img image='" + (([_primary] call client_fnc_weaponDetails) select 2) + "'/></t>");
	(_d displayCtrl 1001) ctrlSetStructuredText parseText format ["<t size='1.25' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>%1</t>", (([_primary] call client_fnc_weaponDetails) select 1)];
};

if (_secondary != "") then {
	(_d displayCtrl 7) ctrlSetStructuredText parseText ("<t align='center' shadow='2' size='5'><img image='" + (([_secondary] call client_fnc_weaponDetails) select 2) + "'/></t>");
	(_d displayCtrl 1004) ctrlSetStructuredText parseText format ["<t size='1.25' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>%1</t>", (([_secondary] call client_fnc_weaponDetails) select 1)];
};

// Build primary attachments text and display
/* if (true) then {
	_prefix = "<t align='center' shadow='2' size='2.5'>";
	_suffix = "</t>";
	_center = "";

	{
		if (_x != "") then {
			_center = _center + "<img image='" + (([_x] call client_fnc_weaponDetails) select 2) + "'/>";
		}
	} forEach (_primary select 1);

	(_d displayCtrl 6) ctrlSetStructuredText parseText (_prefix + _center + _suffix);
}; */

// Build primary attachments text and display
/* if (true) then {
	_prefix = "<t align='center' shadow='2' size='2.5'>";
	_suffix = "</t>";
	_center = "";

	{
		if (_x != "") then {
			_center = _center + "<img image='" + (([_x] call client_fnc_weaponDetails) select 2) + "'/>";
		};
	} forEach (_secondary select 1);

	(_d displayCtrl 8) ctrlSetStructuredText parseText (_prefix + _center + _suffix);
}; */

// Get unlock progress
_progress = [] call client_fnc_getNextUnlockableWeapon;

_text = if ((_progress select 2) != "") then {
	format["<t align='center' shadow='2' size='4.6'><img image='%1'/></t>",([_progress select 2] call client_fnc_weaponDetails) select 2]
} else {
	""
};

// Display progress
if ((_progress select 1) != 0) then {
	(_d displayCtrl 101) progressSetPosition ((_progress select 0) / (_progress select 1));
	(_d displayCtrl 103) ctrlSetText format ["%1 EXPERIENCE POINTS REQUIRED",(_progress select 1) - (_progress select 0)];
	(_d displayCtrl 102) ctrlSetStructuredText parseText _text;
} else {
	(_d displayCtrl 101) progressSetPosition 1;
	(_d displayCtrl 103) ctrlSetText "NO UPCOMING UNLOCKS";
	(_d displayCtrl 102) ctrlSetStructuredText parseText _text;
};
