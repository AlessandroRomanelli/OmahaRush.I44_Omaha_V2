scriptName "fn_spawnMenu_handleWeaponSelection";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleWeaponSelection.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_handleWeaponSelection.sqf"
if (isServer && !hasInterface) exitWith {};

params [["_ctrl", controlNull], ["_index", -1]];

disableSerialization;

private _weapon = _ctrl lbData _index;

if (cl_spawnmenu_currentWeaponSelectionState == 1) then {
	cl_equipClassnames set [0, _weapon];
	profileNamespace setVariable [format["rr_prefPWeaponIdx_%1_%2", cl_class, cl_faction], _index];
	profileNamespace setVariable [format["rr_prefPWeapon_%1_%2", cl_class, cl_faction], _weapon];
	// Populate the structured texts
	[] call client_fnc_populateSpawnMenu;
};

if (cl_spawnmenu_currentWeaponSelectionState == 2) then {
	cl_equipClassnames set [1, _weapon];
	// Populate the structured texts
	[] call client_fnc_populateSpawnMenu;
};
