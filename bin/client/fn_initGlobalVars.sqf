scriptName "fn_initGlobalVars";
/*--------------------------------------------------------------------
	Author: Roman (ofpectag: RMN)
    File: fn_initGlobalVars.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initGlobalVars.sqf"
#include "..\utils.h"

if (isServer && !hasInterface) exitWith {};

VARIABLE_DEFAULT(cl_kills, 0);
VARIABLE_DEFAULT(cl_deaths, 0);
VARIABLE_DEFAULT(cl_points, 0);
VARIABLE_DEFAULT(cl_killfeed, []);
VARIABLE_DEFAULT(cl_spawn_tick, 0);
VARIABLE_DEFAULT(cl_timelineevents, []);
VARIABLE_DEFAULT(cl_revived, false);
VARIABLE_DEFAULT(cl_inSpawnMenu, false);
VARIABLE_DEFAULT(cl_beacon_used, 0);
VARIABLE_DEFAULT(cl_groupSize, -1);
VARIABLE_DEFAULT(cl_class, "");
VARIABLE_DEFAULT(cl_assistsInfo, []);
VARIABLE_DEFAULT(cl_classPerk, "");
VARIABLE_DEFAULT(cl_squadPerk, "");
VARIABLE_DEFAULT(cl_squadPerks, []);
VARIABLE_DEFAULT(cl_actionIDs, []);
VARIABLE_DEFAULT(cl_pointsBelowMinimumPlayers, 0);
VARIABLE_DEFAULT(cl_enemySpawnMarker, "");
VARIABLE_DEFAULT(cl_onEachFrame_squad_members, []);
VARIABLE_DEFAULT(cl_onEachFrame_squad_beacons, []);
VARIABLE_DEFAULT(cl_onEachFrame_team_members, []);
VARIABLE_DEFAULT(cl_onEachFramePreparationID, -1);
VARIABLE_DEFAULT(cl_onEachFrameIconRenderedID, -1);
VARIABLE_DEFAULT(cl_eventObserverID, -1);
VARIABLE_DEFAULT(cl_mapObserverID, -1);
VARIABLE_DEFAULT(cl_mapSetup, false);
VARIABLE_DEFAULT(cl_equipConfigurations, []);
VARIABLE_DEFAULT(cl_equipClassnames, []);

cl_equipClassnames set [0, ""];
cl_equipClassnames set [1, ""];
true
