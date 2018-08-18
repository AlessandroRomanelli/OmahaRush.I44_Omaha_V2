scriptName "fn_spawnMenu_displayPrimaryWeaponSelection";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displayPrimaryWeaponSelection.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displayPrimaryWeaponSelection.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _d = findDisplay 5000;

diag_log "0";

// Hide everything for now
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 1) exitWith {
	{(_d displayCtrl _x) ctrlSetStructuredText parseText "<t size='0.75' color='#ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>"} forEach [2001,2002];
	cl_spawnmenu_currentWeaponSelectionState = 0;
	(_d displayCtrl 207) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
};

(_d displayCtrl 209) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
(_d displayCtrl 207) ctrlSetBackgroundColor [0.96,0.65,0.12,0.8];

diag_log "2";

// Duhh
cl_spawnmenu_currentWeaponSelectionState = 1;
(_d displayCtrl 3) ctrlRemoveAllEventHandlers "LBSelChanged";

(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>";
(_d displayCtrl 2002) ctrlSetStructuredText parseText "<t size='0.75' color='#75ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO CLOSE]</t>";

// Show selection
(_d displayCtrl 2) ctrlShow true; // Background
(_d displayCtrl 3) ctrlShow true; // List of options

// Clear listbox
lbClear (_d displayCtrl 3);

diag_log "3";
diag_log str cl_equipConfigurations;

private _primaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "type")) == "primary"};
// Load all weapons into the listbox
{
	diag_log str _x;

	// Basic check
	if (_x != "") then {

		// Add weapon to list of weapons
		private _allowedClasses = getArray(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> _x >> "roles");
		if (cl_class in _allowedClasses) then {

			diag_log "2";
			(_d displayCtrl 3) lbAdd (([_x] call client_fnc_weaponDetails) select 1);
			(_d displayCtrl 3) lbSetPicture [(lbSize (_d displayCtrl 3)) - 1, (([_x] call client_fnc_weaponDetails) select 2)];
			(_d displayCtrl 3) lbSetData [(lbSize (_d displayCtrl 3)) - 1, _x];
			/* if ((_x select 0) == (cl_equipClassnames select 0)) then {
				(_d displayCtrl 3) lbSetCurSel ((lbSize (_d displayCtrl 3)) - 1);
			}; */
		};
	};
} forEach _primaryWeapons;

private _faction = getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> "faction");
(_d displayCtrl 3) lbSetCurSel (profileNamespace getVariable [format["rr_prefPWeaponIdx_%1_%2", cl_class, _faction], 0]);

// Give control
(_d displayCtrl 3) ctrlAddEventHandler ["LBSelChanged", {
	disableSerialization;
	_d = findDisplay 5000;
	private _idx = lbCurSel (_d displayCtrl 3);
	cl_equipClassnames set [0, (_d displayCtrl 3) lbData _idx];
	_faction = getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> "faction");
	profileNamespace setVariable [format["rr_prefPWeaponIdx_%1_%2", cl_class, _faction], _idx];
	profileNamespace setVariable [format["rr_prefPWeapon_%1_%2", cl_class, _faction], (cl_equipClassNames select 0)];
	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];
