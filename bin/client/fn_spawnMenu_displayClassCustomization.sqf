scriptName "fn_spawnMenu_displayClassCustomization";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displayClassCustomization.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displayClassCustomization.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Create dialog
createDialog "rr_class_customization";

// Get dialog and controls
private _d = findDisplay 8000;
private _listboxClassPerks = _d displayCtrl 0;
private _listboxSquadPerks = _d displayCtrl 1;
/* private _confirmButton = _d displayCtrl 50; */

_listboxClassPerks lbAdd "No perk";
_listboxClassPerks lbSetData [(lbSize _listboxClassPerks) - 1, ""];
_listboxSquadPerks lbAdd "No perk";
_listboxSquadPerks lbSetData [(lbSize _listboxSquadPerks) - 1, ""];

private _class = cl_class;

private _classConfigs = [];
private _squadConfigs = [];

// Fetch data from config
_squadConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "SquadPerks");
_class = _class splitString "";
_class set [0, toUpper (_class select 0)];
_class = _class joinString "";
_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> _class);

// Get current selected perk for class
private _perkNames = [cl_class] call client_fnc_getUsedPerksForClass;
//hint str _perkNames;

// Iterate through class configs and add them to the listbox
{
	private _picture = getText(_x >> "picture");
	_listboxClassPerks lbAdd (getText(_x >> "displayName"));
	_listboxClassPerks lbSetData [(lbSize _listboxClassPerks) - 1, configName _x];
	_listboxClassPerks lbSetTooltip [(lbSize _listboxClassPerks) - 1, getText(_x >> "description")];
	if (_picture != "") then {_listboxSquadPerks lbSetPicture [(lbSize _listboxClassPerks) - 1, _picture]};

	// If this is our active perk, select this entry
	if (configName _x == (_perkNames select 0)) then {
		_listboxClassPerks lbSetCurSel ((lbSize _listboxClassPerks) - 1);
	};
} forEach _classConfigs;
if ((lbCurSel _listboxClassPerks) == -1 && (lbSize _listboxClassPerks) > 0) then {
	_listboxClassPerks lbSetCurSel 0;
};

// Iterate through squad perks and add them to the listbox
{
	private _picture = getText(_x >> "picture");
	_listboxSquadPerks lbAdd (getText(_x >> "displayName"));
	_listboxSquadPerks lbSetData [(lbSize _listboxSquadPerks) - 1, configName _x];
	_listboxSquadPerks lbSetTooltip [(lbSize _listboxSquadPerks) - 1, getText(_x >> "description")];
	if (_picture != "") then {_listboxSquadPerks lbSetPicture [(lbSize _listboxSquadPerks) - 1, _picture]};

	// If this is our active perk, select this entry
	if (configName _x == (_perkNames select 1)) then {
		_listboxSquadPerks lbSetCurSel ((lbSize _listboxSquadPerks) - 1);
	};
} forEach _squadConfigs;
if ((lbCurSel _listboxSquadPerks) == -1 && (lbSize _listboxSquadPerks) > 0) then {
	_listboxSquadPerks lbSetCurSel 0;
};

// Give the listboxes their ability to edit our perks
_listboxClassPerks ctrlAddEventHandler ["LBSelChanged", {
	[cl_class] spawn client_fnc_setUsedPerksForClass;
}];
_listboxSquadPerks ctrlAddEventHandler ["LBSelChanged", {
	[cl_class] spawn client_fnc_setUsedPerksForClass;
}];
