scriptName "fn_getScreenCoords";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getScreenCoords.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_getScreenCoords.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

params [["_obj", objNull, [objNull]]];

if (isNull _obj) exitWith {[0,0]};

private _coords = worldToScreen (getPos _obj);

_coords set [0, - linearConversion [safeZoneX, safeZoneX + safeZoneW, _coords select 0, -1, 1]];
_coords set [1, linearConversion [safeZoneY, safeZoneY + safeZoneH, _coords select 1, -1, 1]];

_coords;
