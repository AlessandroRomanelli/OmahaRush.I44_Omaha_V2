scriptName "fn_getRandomMap";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getRandomMap.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getRandomMap.sqf"

private _isDebug = getNumber(missionConfigFile >> "GeneralConfig" >> "debug") isEqualTo 1;
if (!_isDebug) then {
	if (count allPlayers < 12) exitWith {
		"SmallSetting"
	};
};

"LargeSetting"
