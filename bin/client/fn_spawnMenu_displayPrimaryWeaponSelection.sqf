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
_d = findDisplay 5000;

diag_log "0";

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 1) exitWith {
	cl_spawnmenu_currentWeaponSelectionState = 0;
	{
		((findDisplay 5000) displayCtrl _x) ctrlShow false;
	} forEach [
		2,3,
		20,21,22,25,23,24,26,27,28,29
	];
};

diag_log "1";

// Hide everything for now
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

diag_log "2";

// Duhh
cl_spawnmenu_currentWeaponSelectionState = 1;
(_d displayCtrl 3) ctrlRemoveAllEventHandlers "LBSelChanged";

// Show selection
(_d displayCtrl 2) ctrlShow true;
(_d displayCtrl 3) ctrlShow true;

// Clear listbox
lbClear (_d displayCtrl 3);

diag_log "3";
diag_log str cl_equipConfigurations;


// Load all weapons into the listbox
{
	diag_log str _x;

	// Basic check
	if (_x select 0 != "") then {

		// Add weapon to list of weapons
		if ((getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> (_x select 0) >> "type")) == "primary") then {

			diag_log "2";
			(_d displayCtrl 3) lbAdd (([(_x select 0)] call client_fnc_weaponDetails) select 1);
			(_d displayCtrl 3) lbSetPicture [(lbSize (_d displayCtrl 3)) - 1, (([(_x select 0)] call client_fnc_weaponDetails) select 2)];
			(_d displayCtrl 3) lbSetData [(lbSize (_d displayCtrl 3)) - 1, _x select 0];

			if ((_x select 0) == (cl_equipClassnames select 0)) then {
				(_d displayCtrl 3) lbSetCurSel ((lbSize (_d displayCtrl 3)) - 1);
			};
		};
	};
} forEach cl_equipConfigurations;

// Give control
(_d displayCtrl 3) ctrlAddEventHandler ["LBSelChanged", {

	disableSerialization;
	_d = findDisplay 5000;
	cl_equipClassnames set [0, (_d displayCtrl 3) lbData (lbCurSel (_d displayCtrl 3))];

	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];