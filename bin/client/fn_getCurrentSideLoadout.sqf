scriptName "fn_getCurrentSideLoadout";
/*--------------------------------------------------------------------
	Author: Roman (ofpectag: RMN)
    File: fn_getCurrentSideLoadout.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getCurrentSideLoadout.sqf"
if (isServer && !hasInterface) exitWith {};

// Give player loadout
_side = player getVariable "gameSide";
_possibleLoadouts = (missionconfigfile >> "Soldiers" >> _side >> "Loadouts") call Bis_fnc_getCfgSubClasses;
_loadoutIdx = _side call BIS_fnc_getParamValue;
_sideLoadout = _possibleLoadouts select _loadoutIdx;

_sideLoadout
