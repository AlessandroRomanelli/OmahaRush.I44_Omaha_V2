scriptName "fn_spawnMenu_displaySecondaryAttachmentSelection";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displaySecondaryAttachmentSelection.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displaySecondaryAttachmentSelection.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;
_d = findDisplay 5000;

// Exit if this menu is already open
if (cl_spawnmenu_currentWeaponSelectionState == 4) exitWith {
	cl_spawnmenu_currentWeaponSelectionState = 0;
	{
		((findDisplay 5000) displayCtrl _x) ctrlShow false;
	} forEach [
		2,3,
		20,21,22,25,23,24,26,27,28,29
	];
};

// Duhh
cl_spawnmenu_currentWeaponSelectionState = 4;
(_d displayCtrl 20) ctrlRemoveAllEventHandlers "LBSelChanged";
(_d displayCtrl 21) ctrlRemoveAllEventHandlers "LBSelChanged";
(_d displayCtrl 22) ctrlRemoveAllEventHandlers "LBSelChanged";

// Hide everything for now
{
	((findDisplay 5000) displayCtrl _x) ctrlShow false;
} forEach [
	2,3,
	20,21,22,25,23,24,26,27,28,29
];

// Show selection
{
	((findDisplay 5000) displayCtrl _x) ctrlShow true;
} forEach [20,21,22,25,23,24,26,27,28,29];

// Clear listbox
lbClear (_d displayCtrl 20);
lbClear (_d displayCtrl 21);
lbClear (_d displayCtrl 22);

// Give all listboxes the option "No attachment"
(_d displayCtrl 20) lbAdd "No Attachment";
(_d displayCtrl 20) lbSetData [0, ""];
(_d displayCtrl 21) lbAdd "No Attachment";
(_d displayCtrl 21) lbSetData [0, ""];
(_d displayCtrl 22) lbAdd "No Attachment";
(_d displayCtrl 22) lbSetData [0, ""];

// Inline function to get current equip entry
_getEquipEntry = {
	// Get current equip entry
	_entry = [];
	_index = -1;
	{
		_index = _index + 1;
		if (_x select 0 == (cl_equipClassnames select 1)) exitWith {
			_entry = _x;
		};
	} forEach cl_equipConfigurations;

	_entry
};

// Reserved vars that have be changed if there is an active attachment for a slot
_opticSelected = false;
_muzzleSelected = false;
_sideSelected = false;

// Load all weapons into the listbox
{
	_equippedClassname = cl_equipClassnames select 1;
	if (_x select 0 == _equippedClassname) then {
		_allUnlockedAttachments = _x select 2;

		_attachmentsConfig = (missionConfigFile >> "Unlocks" >> format["%1", side player] >> _equippedClassname >> "attachments");

		// Loop through all attachments found and put them into their listboxes
		{
			if ((getText(_attachmentsConfig >> _x >> "type")) == "optic") then {
				(_d displayCtrl 20) lbAdd (([_x] call client_fnc_weaponDetails) select 1);
				(_d displayCtrl 20) lbSetData [(lbSize (_d displayCtrl 20)) - 1, _x];
				(_d displayCtrl 20) lbSetPicture [(lbSize (_d displayCtrl 20)) - 1, (([_x] call client_fnc_weaponDetails) select 2)];

				// Select this option if its the active one
				_curEqEntry = [] call _getEquipEntry;
				if (_curEqEntry select 1 select 0 == _x) then {
					(_d displayCtrl 20) lbSetCurSel ((lbSize (_d displayCtrl 20)) - 1);
					_opticSelected = true;
				};
			};
			if ((getText(_attachmentsConfig >> _x >> "type")) == "muzzle") then {
				(_d displayCtrl 21) lbAdd (([_x] call client_fnc_weaponDetails) select 1);
				(_d displayCtrl 21) lbSetData [(lbSize (_d displayCtrl 21)) - 1, _x];
				(_d displayCtrl 21) lbSetPicture [(lbSize (_d displayCtrl 21)) - 1, (([_x] call client_fnc_weaponDetails) select 2)];

				// Select this option if its the active one
				_curEqEntry = [] call _getEquipEntry;
				if (_curEqEntry select 1 select 1 == _x) then {
					(_d displayCtrl 21) lbSetCurSel ((lbSize (_d displayCtrl 21)) - 1);
					_muzzleSelected = true;
				};
			};
			if ((getText(_attachmentsConfig >> _x >> "type")) == "side") then {
				(_d displayCtrl 22) lbAdd (([_x] call client_fnc_weaponDetails) select 1);
				(_d displayCtrl 22) lbSetData [(lbSize (_d displayCtrl 22)) - 1, _x];
				(_d displayCtrl 22) lbSetPicture [(lbSize (_d displayCtrl 22)) - 1, (([_x] call client_fnc_weaponDetails) select 2)];

				// Select this option if its the active one
				_curEqEntry = [] call _getEquipEntry;
				if (_curEqEntry select 1 select 2 == _x) then {
					(_d displayCtrl 22) lbSetCurSel ((lbSize (_d displayCtrl 22)) - 1);
					_sideSelected = true;
				};
			};
		} forEach _allUnlockedAttachments;
	};
} forEach cl_equipConfigurations;

// If any listbox has no active selection, select the "no attachment" option
if (!_opticSelected) then {
	(_d displayCtrl 20) lbSetCurSel 0;
};
if (!_muzzleSelected) then {
	(_d displayCtrl 21) lbSetCurSel 0;
};
if (!_sideSelected) then {
	(_d displayCtrl 22) lbSetCurSel 0;
};

// Give control ability to change the equip array to each listbox
// Listbox Sights
(_d displayCtrl 20) ctrlAddEventHandler ["LBSelChanged", {
	disableSerialization;
	_d = findDisplay 5000;
	_curSelWeapon = cl_equipClassnames select 1;
	_attachmentToAdd = (_d displayCtrl 20) lbData (lbCurSel (_d displayCtrl 20));

	// Get current equip entry
	_entry = [];
	_index = -1;
	{
		_index = _index + 1;
		if (_x select 0 == _curSelWeapon) exitWith {
			_entry = _x;
		};
	} forEach cl_equipConfigurations;

	// Get loaded attachments entry
	_attachmentsEntry = _entry select 1;

	// Edit lowest entry
	_attachmentsEntry set [0, _attachmentToAdd];

	// Put back into first parent array
	_entry set [1, _attachmentsEntry];
	cl_equipConfigurations set [_index, _entry];

	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];

// Listbox Muzzles
(_d displayCtrl 21) ctrlAddEventHandler ["LBSelChanged", {
	disableSerialization;
	_d = findDisplay 5000;
	_curSelWeapon = cl_equipClassnames select 1;
	_attachmentToAdd = (_d displayCtrl 21) lbData (lbCurSel (_d displayCtrl 21));

	// Get current equip entry
	_entry = [];
	_index = -1;
	{
		_index = _index + 1;
		if (_x select 0 == _curSelWeapon) exitWith {
			_entry = _x;
		};
	} forEach cl_equipConfigurations;

	// Get loaded attachments entry
	_attachmentsEntry = _entry select 1;

	// Edit lowest entry
	_attachmentsEntry set [1, _attachmentToAdd];

	// Put back into first parent array
	_entry set [1, _attachmentsEntry];
	cl_equipConfigurations set [_index, _entry];

	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];

// Listbox Sides
(_d displayCtrl 22) ctrlAddEventHandler ["LBSelChanged", {
	disableSerialization;
	_d = findDisplay 5000;
	_curSelWeapon = cl_equipClassnames select 1;
	_attachmentToAdd = (_d displayCtrl 22) lbData (lbCurSel (_d displayCtrl 22));

	// Get current equip entry
	_entry = [];
	_index = -1;
	{
		_index = _index + 1;
		if (_x select 0 == _curSelWeapon) exitWith {
			_entry = _x;
		};
	} forEach cl_equipConfigurations;

	// Get loaded attachments entry
	_attachmentsEntry = _entry select 1;

	// Edit lowest entry
	_attachmentsEntry set [2, _attachmentToAdd];

	// Put back into first parent array
	_entry set [1, _attachmentsEntry];
	cl_equipConfigurations set [_index, _entry];

	// Populate the structured texts
	[] spawn client_fnc_populateSpawnMenu;
}];