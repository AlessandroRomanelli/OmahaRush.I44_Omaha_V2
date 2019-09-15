scriptName "fn_decideMapSize";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_decideMapSize.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_decideMapSize.sqf"
#include "..\utils.h"
private _size = "LargeSetting";
VARIABLE_DEFAULT(sv_setting_MapPopulation, 12);
private _threshold = sv_setting_MapPopulation;
private _hasSmallSetting = count ("true" configClasses (missionConfigFile >> "MapSettings" >> "SmallSetting")) > 0;
if (_threshold isEqualTo 0 || !_hasSmallSetting) exitWith {"LargeSetting"};
private _connectedPlayers = playersNumber civilian;
if (_threshold isEqualTo 9999 || {_connectedPlayers < _threshold}) exitWith {"SmallSetting"};
_size
