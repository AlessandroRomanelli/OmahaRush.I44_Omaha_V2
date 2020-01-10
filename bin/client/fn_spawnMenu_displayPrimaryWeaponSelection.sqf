scriptName "fn_spawnMenu_displayPrimaryWeaponSelection";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displayPrimaryWeaponSelection.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displayPrimaryWeaponSelection.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _d = findDisplay 5000;

uiNamespace getVariable ["wwr_loadout_right_col", controlNull] ctrlShow false;

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 1) exitWith {
	cl_spawnmenu_currentWeaponSelectionState = 0;
	(_d displayCtrl 207) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
};


(_d displayCtrl 209) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
(_d displayCtrl 207) ctrlSetBackgroundColor [0.96,0.65,0.12,0.8];


// Duhh
cl_spawnmenu_currentWeaponSelectionState = 1;


// Show selection
(_d displayCtrl 2) ctrlShow true; // Background

private _listBox = _d displayCtrl 3;
_listBox ctrlShow true; // List of options

// Clear listbox
lbClear _listBox;

private _side = GAMESIDE(player);

private _primaryWeapons = [];
{
	if (getText(missionConfigFile >> "Unlocks" >> _side >> _x >> "type") isEqualTo "primary") then {
		_primaryWeapons pushBackUnique _x;
	};
} forEach cl_equipConfigurations;
// Load all weapons into the listbox
{
	// Basic check
	if (_x != "") then {
		// Add weapon to list of weapons
		private _allowedClasses = getArray(missionConfigFile >> "Unlocks" >> _side >> _x >> "roles");
		if (cl_class in _allowedClasses) then {
			private _weaponData = [_x] call client_fnc_weaponDetails;
			(_d displayCtrl 3) lbAdd (_weaponData select 1);
			(_d displayCtrl 3) lbSetPicture [(lbSize (_d displayCtrl 3)) - 1, (_weaponData select 2)];
			(_d displayCtrl 3) lbSetData [(lbSize (_d displayCtrl 3)) - 1, _x];
		};
	};
} forEach _primaryWeapons;

_listBox lbSetCurSel (profileNamespace getVariable [format["rr_prefPWeaponIdx_%1_%2", cl_class, cl_faction], 0]);

uiNamespace getVariable ["wwr_loadout_right_col", controlNull] ctrlShow true;


true
