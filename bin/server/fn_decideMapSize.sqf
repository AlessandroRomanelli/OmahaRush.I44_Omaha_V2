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
private _isDebug = getNumber(missionConfigFile >> "GeneralConfig" >> "debug") isEqualTo 1;
if (!_isDebug) then {
	if (count allPlayers < 12) exitWith {
		_size = "SmallSetting";
	};
};

_size
