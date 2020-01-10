scriptName "fn_populateSpawnMenu";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_populateSpawnMenu.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_populateSpawnMenu.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

// Arma..
disableSerialization;

// Get dialog
private _d = findDisplay 5000;
private _list = _d displayCtrl 300;
private _class = _list lbData (lbCurSel _list);


private _side = SIDEOF(player);

// Get selected equip to be displayed
[] call client_fnc_getLoadedEquipment;
private _equip = player getVariable ["loaded_equipment", [cl_equipClassnames select 0, cl_equipClassnames select 1]];

_equip params ["_primary", "_secondary"];
private _perkData = [_class] call client_fnc_getUsedPerksForClass;

if (_primary == "") then {
	(_d displayCtrl 5) ctrlSetStructuredText parseText "<t size='4' color='#990000' shadow='2' font='PuristaMedium' align='center'>N/A</t>";
	(_d displayCtrl 1001) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON SELECTED</t>";
	(_d displayCtrl 2002) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>";
};

if (_secondary == "") then {
	(_d displayCtrl 7) ctrlSetStructuredText parseText "<t size='4' color='#990000' shadow='2' font='PuristaMedium' align='center'>N/A</t>";
	private _secondaryWeapons = cl_equipConfigurations select {(getText(missionConfigFile >> "Unlocks" >> GAMESIDE(player) >> _x >> "type")) == "secondary"};
	if (count _secondaryWeapons != 0) then {
		(_d displayCtrl 1004) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON SELECTED</t>";
		(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[CLICK ABOVE TO OPEN]</t>";
	} else {
		(_d displayCtrl 1004) ctrlSetStructuredText parseText "<t size='1.25' color='#990000' shadow='2' font='PuristaMedium' align='center'>NO WEAPON AVAILABLE</t>";
		(_d displayCtrl 2001) ctrlSetStructuredText parseText "<t size='0.75' color='#FFFFFF' shadow='2' font='PuristaMedium' align='center'>[PROGRESS TO UNLOCK MORE]</t>";
	};
};

if (_class != "") then {
	(_d displayCtrl 201) ctrlSetText (format ["%1pictures\%2.paa", WWRUSH_ROOT, _class]);
	if (count _perkData > 0 && {(_perkData select 0) != ""}) then {
		private _perkCfg = missionConfigfile >> "CfgPerks" >> "ClassPerks" >> _class >> _perkData select 0;
		(_d displayCtrl 200) ctrlSetTooltip (getText(_perkCfg >> "description"));
		(_d displayCtrl 202) ctrlSetText (toUpper getText(_perkCfg >> "displayName"));
	} else {
		(_d displayCtrl 202) ctrlSetText "NO CLASS PERK";
	};
};

if (count _perkData > 0 && {(_perkData select 1) != ""}) then {
	(_d displayCtrl 204) ctrlSetText (format ["%1pictures\%2.paa", WWRUSH_ROOT, (_perkData select 1)]);
	private _perkCfg = missionConfigfile >> "CfgPerks" >> "SquadPerks" >> _perkData select 1;
	(_d displayCtrl 205) ctrlSetText (toUpper getText(_perkCfg >> "displayName"));
	(_d displayCtrl 203) ctrlSetTooltip (getText(_perkCfg >> "description"));
} else {
	(_d displayCtrl 204) ctrlSetText (WWRUSH_ROOT + "pictures\noperk.paa");
	(_d displayCtrl 205) ctrlSetText "NO SQUAD PERK";
};

// Validate
[] call client_fnc_validateEquipment;

// Display primary and secondary
private _details = [];
if (_primary != "") then {
	_details = [_primary] call client_fnc_weaponDetails;
	(_d displayCtrl 5) ctrlSetText (_details select 2);
	(_d displayCtrl 1005) ctrlSetText (_details select 1);
};

if (_secondary != "") then {
	_details = [_secondary] call client_fnc_weaponDetails;
	(_d displayCtrl 7) ctrlSetText (_details select 2);
	(_d displayCtrl 1007) ctrlSetText (_details select 1);
};

// Change the faction flag
private _flagCtrl = _d displayCtrl 1205;
private _marker = getText(missionConfigFile >> "Vehicles" >> ["Attacker", "Defender"] select (_side == WEST) >> "marker");
_flagCtrl ctrlSetText (getText(configFile >> "CfgMarkers" >> _marker >> "texture"));

// Get unlock progress
private _progress = [] call client_fnc_getNextUnlockableWeapon;

private _text = if ((_progress select 2) != "") then {
	format["<t align='center' shadow='2' size='4.6'><img image='%1'/></t>",([_progress select 2] call client_fnc_weaponDetails) select 2]
} else {
	""
};

// Display progress
if ((_progress select 1) != 0) then {
	(_d displayCtrl 101) progressSetPosition ((_progress select 0) / (_progress select 1));
	(_d displayCtrl 103) ctrlSetText format ["%1 EXPERIENCE POINTS REQUIRED",(_progress select 1) - (_progress select 0)];
	(_d displayCtrl 102) ctrlSetStructuredText parseText _text;
} else {
	(_d displayCtrl 101) progressSetPosition 1;
	(_d displayCtrl 103) ctrlSetText "NO UPCOMING UNLOCKS";
	(_d displayCtrl 102) ctrlSetStructuredText parseText _text;
};

true
