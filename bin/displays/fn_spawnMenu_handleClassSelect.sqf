scriptName "fn_spawnMenu_handleClassSelect";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleClassSelect.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_handleClassSelect.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

params [["_ctrl", controlNull], ["_index", -1]];

disableSerialization;

if (_index == -1) exitWith {};

private _classSelected = _ctrl lbData _index;
private _side = GAMESIDE(player);
private _weaponAllowedClasses = getArray(missionConfigFile >> "Unlocks" >> _side >> (cl_equipClassNames select 0) >> "roles");
if !(_classSelected in _weaponAllowedClasses) then {
	private _weapon = profileNamespace getVariable [format["rr_prefPWeapon_%1_%2", _classSelected, cl_faction], ""];
	((findDisplay 5000) displayCtrl 3) lbSetCurSel (profileNamespace getVariable [format["rr_prefPWeaponIdx_%1_%2", _classSelected, cl_faction], 0]);
	cl_equipClassnames set [0, _weapon];
};

// Save preferred class index
profileNamespace setVariable ["rr_class_preferredIndex", _index];

// Save class so any other scripts can instantly get our currently selected class // Please note that broadcasting this will be done only when actually spawning
if (_classSelected != "") then {
	cl_class = _classSelected;
};

[] call client_fnc_populateSpawnMenu;
if (cl_spawnmenu_currentWeaponSelectionState == 1) then {
	cl_spawnmenu_currentWeaponSelectionState = 0; // Nothing open
	[] call client_fnc_spawnMenu_displayPrimaryWeaponSelection;
};
[] call client_fnc_populateSpawnMenu;
