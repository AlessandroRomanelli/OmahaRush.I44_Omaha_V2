scriptName "fn_spawnMenu_loadClasses";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_spawnMenu_handleClassSelect.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_loadClasses.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

disableSerialization;

private _isRefreshing = param[0, false, [false]];

// Spawn menu display listbox
private _d = findDisplay 5000;
private _l = _d displayCtrl 300;

VARIABLE_DEFAULT(sv_setting_ClassLimits, 1);
private _classRestrictionEnabled = sv_setting_ClassLimits == 1;

private _countClassPlayers = {
	private _class = param[0, "", [""]];
	private _sameSidePlayers = allPlayers select {if ((player getVariable ["side", sideUnknown]) isEqualTo (_x getVariable ["side", sideUnknown])) then {true}};
	private _sameClassPlayers = _sameSidePlayers select {if (_x getVariable ["class", "medic"] isEqualTo _class) then {true}};
	private _classLimit = (missionNamespace getVariable [format ["sv_setting_ClassLimits_%1", _class], 10])/10;
	private _maxClassPlayers = if(_classLimit != 1) then {floor (((count allPlayers)/2) * _classLimit)} else {-1};
	[count _sameClassPlayers, _maxClassPlayers, player in _sameClassPlayers];
};

if (!_isRefreshing) then {
	((findDisplay 5000) displayCtrl 301) ctrlSetText "CUSTOMIZE CLASS & PERKS";
	((findDisplay 5000) displayCtrl 301) ctrlEnable true;

	lbClear _l;

	{
		_l lbAdd _x;
		_l lbSetData [_forEachIndex, toLower _x];
		_l lbSetPicture [_forEachIndex, format ["%1pictures\%2.paa", WWRUSH_ROOT, toLower _x]];
	} forEach ["Assault", "Medic", "Support", "Engineer", "Recon"];

	// Get preferred class index from profileNamespace
	private _i = profileNamespace getVariable ["rr_class_preferredIndex", 0];

	// Select listbox item
	_l lbSetCurSel _i;
} else {
	private _supportData = ["support"] call _countClassPlayers;
	private _engineerData = ["engineer"] call _countClassPlayers;
	private _reconData = ["recon"] call _countClassPlayers;

	if (_classRestrictionEnabled) then {
		if !(_supportData select 1 isEqualTo -1) then {
			_l lbSetText [(lbSize _l) - 3, format ["Support (%1/%2)", _supportData select 0, _supportData select 1]];
			if ((_supportData select 0) >= (_supportData select 1) && !(_supportData select 2)) then {
				_l lbSetColor [(lbSize _l) - 3, [1,0,0,1]];
			} else {
				_l lbSetColor [(lbSize _l) - 3, [1, 1, 1, 0.5]];
			};
		};
		if !(_engineerData select 1 isEqualTo -1) then {
			_l lbSetText [(lbSize _l) - 2, format ["Engineer (%1/%2)", _engineerData select 0, _engineerData select 1]];
			if ((_engineerData select 0) >= (_engineerData select 1) && !(_engineerData select 2)) then {
				_l lbSetColor [(lbSize _l) - 2, [1,0,0,1]];
			} else {
				_l lbSetColor [(lbSize _l) - 2, [1, 1, 1, 0.5]];
			};
		};
		if !(_reconData select 1 isEqualTo -1) then {
			_l lbSetText [(lbSize _l) - 1, format ["Recon (%1/%2)", _reconData select 0, _reconData select 1]];
			if ((_reconData select 0) >= (_reconData select 1) && !(_reconData select 2)) then {
				_l lbSetColor [(lbSize _l) - 1, [1,0,0,1]];
			} else {
				_l lbSetColor [(lbSize _l) - 1, [1, 1, 1, 0.5]];
			};
		};
	};
};
true
