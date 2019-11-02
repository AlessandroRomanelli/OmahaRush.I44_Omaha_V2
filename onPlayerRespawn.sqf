scriptName "onPlayerRespawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: onPlayerRespawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "onPlayerRespawn.sqf"
#include "bin\utils.h"

WAIT_IF_NOT(cl_init_done);
VARIABLE_DEFAULT(sv_gameStatus, 0);
VARIABLE_DEFAULT(cl_revived, false);

if (sv_gameStatus != 2 || { cl_revived }) exitWith {};

["Player respawned"] spawn server_fnc_log;
player setVariable ["grenade_kill", nil];
player setVariable ["wasHS", false];

setPlayerRespawnTime 15;

player enableStamina false;
player forceWalk false;

VARIABLE_DEFAULT(cl_forceSwitch, false);
if (cl_forceSwitch) exitWith {};

[] spawn client_fnc_spawn;
