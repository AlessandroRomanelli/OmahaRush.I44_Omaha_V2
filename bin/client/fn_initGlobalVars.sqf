scriptName "fn_initGlobalVars";
/*--------------------------------------------------------------------
	Author: Roman (ofpectag: RMN)
    File: fn_initGlobalVars.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initGlobalVars.sqf"
if (isServer && !hasInterface) exitWith {};

cl_kills = 0;
cl_deaths = 0;
cl_points = 0;
cl_killfeed = [];
cl_spawn_tick = 0;
cl_timelineevents = [];
cl_revived = false;
cl_inSpawnMenu = false;
cl_beacon_used = 0;
cl_groupSize = -1;
cl_class = "";
cl_assistsInfo = [];
cl_classPerk = "";
cl_squadPerk = "";
cl_squadPerks = [];
cl_actionIDs = [];
cl_mcomDefAtt = 0;
cl_pointsBelowMinimumPlayers = 0;
cl_enemySpawnMarker = "";
cl_blockTimer = false;
TEMPWARNING = nil;
cl_onEachFrame_squad_members = [];
cl_onEachFrame_squad_beacons = [];
cl_onEachFrame_team_members = [];
cl_onEachFrame_team_reviveable = [];

true
