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
private _d = findDisplay 5000;

// Hide everything for now
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 2) exitWith {
	{(_d displayCtrl _x) ctrlSetStructuredText parseText "<t size='0.75' color='#ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>"} forEach [2001,2002];
	cl_spawnmenu_currentWeaponSelectionState = 0;
	(_d displayCtrl 209) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
};

(_d displayCtrl 207) ctrlSetBackgroundColor [0.12,0.14,0.16,0.8];
(_d displayCtrl 209) ctrlSetBackgroundColor [0.96,0.65,0.12,0.8];

// Duhh
cl_spawnmenu_currentWeaponSelectionState = 2;

(_d displayCtrl 2002) ctrlSetStructuredText parseText "<t size='0.75' color='#ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>";
(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#75ffffff'' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO CLOSE]</t>";

(_d displayCtrl 3) ctrlRemoveAllEventHandlers "LBSelChanged";

// Show selection
(_d displayCtrl 2) ctrlShow true;
(_d displayCtrl 3) ctrlShow true;

// Clear listbox
lbClear (_d displayCtrl 3);

// Load all weapons into the listbox
private _side = ["attackers", "defenders"] select (player getVariable ["side", side player] == WEST);

private _secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> _side >> _x >> "type")) == "secondary"};
{
	private _weaponData = [_x] call client_fnc_weaponDetails;
	(_d displayCtrl 3) lbAdd (_weaponData select 1);
	(_d displayCtrl 3) lbSetPicture [(lbSize (_d displayCtrl 3)) - 1, (_weaponData select 2)];
	(_d displayCtrl 3) lbSetData [(lbSize (_d displayCtrl 3)) - 1, _x];

	if (_x == (cl_equipClassnames select 1)) then {
		(_d displayCtrl 3) lbSetCurSel ((lbSize (_d displayCtrl 3)) - 1);
	};
} forEach _secondaryWeapons;


// Give control
(_d displayCtrl 3) ctrlAddEventHandler ["LBSelChanged", {

	disableSerialization;
	_d = findDisplay 5000;
	cl_equipClassnames set [1, (_d displayCtrl 3) lbData (lbCurSel (_d displayCtrl 3))];

	// Populate the structured texts
	[] call client_fnc_populateSpawnMenu;
}];
