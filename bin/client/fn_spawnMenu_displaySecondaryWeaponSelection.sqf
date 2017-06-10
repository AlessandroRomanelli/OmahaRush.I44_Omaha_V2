scriptName "fn_spawnMenu_displaySecondaryWeaponSelection";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displaySecondaryWeaponSelection.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displaySecondaryWeaponSelection.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
_d = findDisplay 5000;

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 2) exitWith {
	cl_spawnmenu_currentWeaponSelectionState = 0;
	{
		((findDisplay 5000) displayCtrl _x) ctrlShow false;
	} forEach [
		2,3,
		20,21,22,25,23,24,26,27,28,29
	];
};

// Hide everything for now
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

// Duhh
cl_spawnmenu_currentWeaponSelectionState = 2;
(_d displayCtrl 3) ctrlRemoveAllEventHandlers "LBSelChanged";

// Show selection
(_d displayCtrl 2) ctrlShow true;
(_d displayCtrl 3) ctrlShow true;

// Clear listbox
lbClear (_d displayCtrl 3);

// Load all weapons into the listbox
{
	if ((getText(missionConfigFile >> "Unlocks" >> format["%1", side player] >> (_x select 0) >> "type")) == "secondary") then {
		(_d displayCtrl 3) lbAdd (([(_x select 0)] call client_fnc_weaponDetails) select 1);
		(_d displayCtrl 3) lbSetPicture [(lbSize (_d displayCtrl 3)) - 1, (([(_x select 0)] call client_fnc_weaponDetails) select 2)];
		(_d displayCtrl 3) lbSetData [(lbSize (_d displayCtrl 3)) - 1, _x select 0];

		if ((_x select 0) == (cl_equipClassnames select 1)) then {
			(_d displayCtrl 3) lbSetCurSel ((lbSize (_d displayCtrl 3)) - 1);
		};
	};
} forEach cl_equipConfigurations;

// Give control
(_d displayCtrl 3) ctrlAddEventHandler ["LBSelChanged", {

	disableSerialization;
	_d = findDisplay 5000;
	cl_equipClassnames set [1, (_d displayCtrl 3) lbData (lbCurSel (_d displayCtrl 3))];

	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];