scriptName "fn_spawnMenu_loadClasses";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_loadClasses.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_loadClasses.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Spawn menu display listbox
_d = findDisplay 5000;
_l = _d displayCtrl 300;

// Allow listbox selection changes to update our "customize class" button (some classes are not customizeable atm so theres no reason for people to be able to click it)
_l ctrlAddEventHandler ["LBSelChanged", {
	_classSelected = (_this select 0) lbData (_this select 1);

	_weaponAllowedClasses = getArray(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> cl_equipClassNames select 0 >> "roles");
	if !(_classSelected in _weaponAllowedClasses) then {
		_faction = getText(missionConfigFile >> "Unlocks" >> player getVariable "gameSide" >> "faction");
		_weapon = profileNamespace getVariable [format["rr_prefPWeapon_%1_%2", _classSelected, _faction], ""];
		(_d displayCtrl 3) lbSetCurSel (profileNamespace getVariable [format["rr_prefPWeaponIdx_%1_%2", cl_class, _faction], 0]);
		cl_equipClassnames set [0, _weapon];
	};

	((findDisplay 5000) displayCtrl 301) ctrlSetText "CHANGE CLASS/SQUAD PERKS";
	((findDisplay 5000) displayCtrl 301) ctrlEnable true;

	// Customizeable button
	/* switch (_class) do
	{
		case "medic":
		{
			((findDisplay 5000) displayCtrl 301) ctrlSetText "CHANGE CLASS/SQUAD PERKS";
			((findDisplay 5000) displayCtrl 301) ctrlEnable true;
		};

		case "support":
		{
			((findDisplay 5000) displayCtrl 301) ctrlSetText "CHANGE CLASS/SQUAD PERKS";
			((findDisplay 5000) displayCtrl 301) ctrlEnable true;
		};

		case "assault":
		{
			((findDisplay 5000) displayCtrl 301) ctrlSetText "CHANGE CLASS/SQUAD PERKS";
			((findDisplay 5000) displayCtrl 301) ctrlEnable true;
		};

		case "engineer":
		{
			((findDisplay 5000) displayCtrl 301) ctrlSetText "CHANGE CLASS/SQUAD PERKS";
			((findDisplay 5000) displayCtrl 301) ctrlEnable true;
		};
	}; */

	// Save preferred class index
	profileNamespace setVariable ["rr_class_preferredIndex", (_this select 1)];

	// Save class so any other scripts can instantly get our currently selected class // Please note that broadcasting this will be done only when actually spawning
	cl_class = _classSelected;

	if (cl_spawnmenu_currentWeaponSelectionState != 0) then {
		cl_spawnmenu_currentWeaponSelectionState = 0; // Nothing open
		[] spawn client_fnc_spawnMenu_displayPrimaryWeaponSelection;
	};
	[] spawn client_fnc_populateSpawnMenu;
}];

// Add default classes
// Assault
_l lbAdd "Assault";
_l lbSetData [(lbSize _l) - 1, "assault"];

// Medic
_l lbAdd "Medic";
_l lbSetData [(lbSize _l) - 1, "medic"];

// Support
_l lbAdd "Support";
_l lbSetData [(lbSize _l) - 1, "support"];

// Engineer
_l lbAdd "Engineer";
_l lbSetData [(lbSize _l) - 1, "engineer"];

// Recon
_l lbAdd "Recon";
_l lbSetData [(lbSize _l) - 1, "recon"];

// Get preferred class index from profileNamespace
_i = profileNamespace getVariable ["rr_class_preferredIndex", 0];

// Select listbox item
_l lbSetCurSel _i;

// Allow our sweet sour dank memes so I learned how to bunny hop button to be able to open the menu depending on our selected class
((findDisplay 5000) displayCtrl 301) ctrlAddEventHandler ["ButtonDown", {
	_class = ((findDisplay 5000) displayCtrl 300) lbData (lbCurSel ((findDisplay 5000) displayCtrl 300));
	[_class] spawn client_fnc_spawnMenu_displayClassCustomization;
}];
