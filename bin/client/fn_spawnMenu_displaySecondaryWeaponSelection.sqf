scriptName "fn_spawnMenu_displaySecondaryWeaponSelection";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displaySecondaryWeaponSelection.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displaySecondaryWeaponSelection.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

disableSerialization;
private _d = findDisplay 5000;

uiNamespace getVariable ["wwr_loadout_right_col", controlNull] ctrlShow false;

private _secondaryWeapons = cl_equipConfigurations findIf {(getText(missionConfigFile >> 'Unlocks' >> GAMESIDE(player) >> _x >> 'type')) == 'secondary'};
// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 2 || _secondaryWeapons < 0) exitWith {
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

// Show selection
(_d displayCtrl 2) ctrlShow true;

private _listBox = _d displayCtrl 3;
_listBox ctrlShow true;

// Clear listbox
lbClear _listBox;

// Load all weapons into the listbox
private _side = GAMESIDE(player);

private _secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> _side >> _x >> "type")) == "secondary"};
{
	private _weaponData = [_x] call client_fnc_weaponDetails;
	_listBox lbAdd (_weaponData select 1);
	private _i = lbSize _listBox - 1;
	_listBox lbSetPicture [_i, _weaponData select 2];
	_listBox lbSetData [_i, _weaponData select 0];

	if (_x == (cl_equipClassnames select 1)) then {
		_listBox lbSetCurSel _i;
	};
} forEach _secondaryWeapons;

uiNamespace getVariable ["wwr_loadout_right_col", controlNull] ctrlShow true;
