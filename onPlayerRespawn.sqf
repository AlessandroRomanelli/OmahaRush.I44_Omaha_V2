scriptName "onPlayerRespawn";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: onPlayerRespawn.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "onPlayerRespawn.sqf"

WAIT_IF_NOT(cl_init_done);
if (!isNil "sv_gameStatus" && !isNil "cl_revived") then {
	if (sv_gameStatus == 2 && !cl_revived) then {
		["Player respawned"] spawn server_fnc_log;
		[format["sv_gameStatus %1 cl_revived %2", sv_gameStatus, cl_revived]] spawn server_fnc_log;
		player setVariable ["grenade_kill", nil];
		player setVariable ["wasHS", false];

		if !(missionNamespace getVariable ["cl_forceSwitch", false]) then {
			[] spawn client_fnc_spawn;
		};
		setPlayerRespawnTime 15;

		player enableStamina false;
		player forceWalk false;
	};
};
