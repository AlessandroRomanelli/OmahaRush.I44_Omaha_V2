scriptName "fn_setUsedPerksForClass";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_setUsedPerksForClass.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setUsedPerksForClass.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

_class = param[0,"",[""]];
if (_class == "") exitWith {};

// Get from display
_d = findDisplay 8000;
if (isNull _d) exitWith {};

_lbClass = _d displayCtrl 0;
_lbSquad = _d displayCtrl 1;

// Save class
_dataArray = [];

if ((lbCurSel _lbClass) != -1) then {
	_dataArray set [0, _lbClass lbData (lbCurSel _lbClass)];
} else {
	_dataArray set [0, ""];
};
if ((lbCurSel _lbSquad) != -1) then {
	_dataArray set [1, _lbSquad lbData (lbCurSel _lbSquad)];
} else {
	_dataArray set [1, ""];
};

//hint str _dataArray;

// Get data from profilenamespace
switch (_class) do
{
	case "medic":
	{
		profileNamespace setVariable ["rr_perks_medic", _dataArray];
	};
	case "support":
	{
		profileNamespace setVariable ["rr_perks_support", _dataArray];
	};
	case "assault":
	{
		profileNamespace setVariable ["rr_perks_assault", _dataArray];
	};
	case "engineer":
	{
		profileNamespace setVariable ["rr_perks_engineer", _dataArray];
	};
};