scriptName "fn_spawnMenu_handleClassCustomize";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleClassCustomize.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_spawnMenu_handleClassCustomize.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

private _list = (findDisplay 5000) displayCtrl 300;
private _class = _list lbData (lbCurSel _list);


disableSerialization;

// Create dialog
createDialog "rr_class_customization";

// Get dialog and controls
private _d = findDisplay 8000;
private _listboxClassPerks = _d displayCtrl 0;
private _listboxSquadPerks = _d displayCtrl 1;
/* private _confirmButton = _d displayCtrl 50; */

_listboxSquadPerks lbAdd "No perk";
_listboxSquadPerks lbSetData [(lbSize _listboxSquadPerks) - 1, ""];

private _classConfigs = [];
private _squadConfigs = [];

// Fetch data from config
_squadConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "SquadPerks");
_class = toUpper (_class select [0,1]) + (_class select [1, count _class - 1]);
_classConfigs = "true" configClasses (missionConfigFile >> "CfgPerks" >> "ClassPerks" >> _class);


// Get current selected perk for class
private _perkNames = [_class] call client_fnc_getUsedPerksForClass;

// Iterate through class configs and add them to the listbox
{
	_listboxClassPerks lbAdd (getText(_x >> "displayName"));
	_listboxClassPerks lbSetData [(lbSize _listboxClassPerks) - 1, configName _x];
	_listboxClassPerks lbSetTooltip [(lbSize _listboxClassPerks) - 1, getText(_x >> "description")];
	_listboxClassPerks lbSetPicture [(lbSize _listboxClassPerks) - 1, format ["%1pictures\%2.paa", WWRUSH_ROOT,  toLower _class]];

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
	_listboxSquadPerks lbAdd (getText(_x >> "displayName"));
	_listboxSquadPerks lbSetData [(lbSize _listboxSquadPerks) - 1, configName _x];
	_listboxSquadPerks lbSetTooltip [(lbSize _listboxSquadPerks) - 1, getText(_x >> "description")];
	_listboxSquadPerks lbSetPicture [(lbSize _listboxSquadPerks) - 1, format ["%1pictures\%2.paa", WWRUSH_ROOT, configName _x]];
	if ((configName _x) in (cl_squadPerks - [cl_squadPerk])) then {
		_listboxSquadPerks lbSetColor [(lbSize _listboxSquadPerks) -1, [0.96,0.65,0.12,0.8]];
	};
	// If this is our active perk, select this entry
	if (configName _x == (_perkNames select 1)) then {
		_listboxSquadPerks lbSetCurSel ((lbSize _listboxSquadPerks) - 1);
	};
} forEach _squadConfigs;
if ((lbCurSel _listboxSquadPerks) == -1 && (lbSize _listboxSquadPerks) > 0) then {
	_listboxSquadPerks lbSetCurSel 0;
};

true;
