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

private _list = (findDisplay 5000) displayCtrl 300;
private _class = _list lbData (lbCurSel _list);

if (_class == "") exitWith {};

// Get from display
private _d = findDisplay 8000;
if (isNull _d) exitWith {};

private _lbClass = _d displayCtrl 0;
private _lbSquad = _d displayCtrl 1;

// Save class
private _dataArray = [];

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

// Get data from profilenamespace
profileNamespace setVariable [format ["rr_perks_%1", _class], _dataArray];
true
