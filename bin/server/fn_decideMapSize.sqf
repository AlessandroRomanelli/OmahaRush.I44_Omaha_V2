scriptName "fn_decideMapSize";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_decideMapSize.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_decideMapSize.sqf"
private _size = "LargeSetting";
private _threshold = ["MapPopulation", 12] call BIS_fnc_getParamValue;
if (_threshold isEqualTo 0) exitWith {"LargeSetting"};
if (_threshold isEqualTo 9999 || {count allPlayers < _threshold}) exitWith {"SmallSetting"};
_size
