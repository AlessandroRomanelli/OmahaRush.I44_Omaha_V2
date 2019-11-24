scriptName "fn_getCurrentSideLoadout";
/*--------------------------------------------------------------------
	Author: A.Roman (ofpectag: RMN)
    File: fn_getCurrentSideLoadout.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getCurrentSideLoadout.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

// Give player loadout
private _side = GAMESIDE(player);
private _possibleLoadouts = (missionconfigfile >> "Soldiers" >> _side >> "Loadouts") call Bis_fnc_getCfgSubClasses;
private _loadoutIdx = _side call BIS_fnc_getParamValue;
private _sideLoadout = _possibleLoadouts select _loadoutIdx;

_sideLoadout
