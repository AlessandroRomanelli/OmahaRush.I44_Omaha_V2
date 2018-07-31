scriptName "fn_setSquadPerks";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_setSquadPerks.sqf

    Written by Maverick A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_setSquadPerks.sqf"
if (isServer && !hasInterface) exitWith {};

_availableSquadPerks = (missionConfigFile >> "CfgPerks" >> "SquadPerks") call bis_fnc_getCfgSubClasses;
_idx = _availableSquadPerks find cl_squadPerk;
if (player getVariable ["squadPerk", -1] != _idx) then {
  player setVariable ["squadPerk",_idx,true];
};

true
