scriptName "fn_init";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_init.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_init.sqf"
if (isServer && !hasInterface) exitWith {};

// Did the init run already?
if (!isNil "cl_init_ran") exitWith {};
cl_init_ran = true;

// Skip the briefing screen whenever possible
if (hasInterface) then {
    0 = [] spawn {
        waitUntil {
            if (getClientState == "BRIEFING READ") exitWith {true};
            if (!isNull findDisplay 53) exitWith {
                ctrlActivate (findDisplay 53 displayCtrl 1);
                findDisplay 53 closeDisplay 1;
                true
            };
            false
        };
    };
};

// Player name
player setVariable ["name", name player, true];

// Time played to make sure the auto team balancer knows our jointime
player setVariable ["joinServerTime", serverTime, true];

// Wait for the client to be ready for deployment
waitUntil {(!isNull (findDisplay 46)) AND (isNull (findDisplay 101)) AND (!isNull player) AND (alive player) AND !dialog};

// Disable saving
enableSaving [false, false];

// Check if this player should be able to join the team
[] call client_fnc_instantTeamBalanceCheck;

// Wait for the server to be ready
if (isNil "sv_serverReady") then {
	sv_serverReady = false;
};
waitUntil {sv_serverReady && !isNil "sv_usingDatabase"};

// Get progress from server..
if (sv_usingDatabase) then {
	cl_statisticsLoaded = false;
	[] call client_fnc_loadStatistics;
	waitUntil {cl_statisticsLoaded};
} else {
	cl_total_kills = 0;
	cl_total_deaths = 0;
	cl_exp = 100000000;
	cl_equipConfigurations = [];
	cl_equipClassnames = ["",""];
};

// Get initial spawn position to teleport the player to (e.g. in spawn menu)
cl_safePos = getPos player;

// Respawn info for spawn menu
cl_revived = false;

// Init event handlers
[] spawn client_fnc_setupEventHandlers;

// Get initial view and object view distance
cl_objViewDistance = getObjectViewDistance;
cl_viewDistance = viewDistance;

// Do all the cool stuff!
[] spawn client_fnc_resetVariables;

// Give onEachFrame data
[] spawn client_fnc_onEachFramePreparation;

// Used for determining if a player is on our side since side _x returns civilian if someone is dead
player setVariable ["side", playerSide, true];

if (sv_gameCycle % 2 == 0) then {
  if (playerSide == WEST) then {
    player setVariable ["gameSide", "defenders", true];
  } else {
    player setVariable ["gameSide", "attackers", true];
  };
} else {
  if (playerSide == WEST) then {
    player setVariable ["gameSide", "attackers", true];
  } else {
    player setVariable ["gameSide", "defenders", true];
  };
};




// Init group client
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

// If this is the debug mode, just unlock everything
if (getNumber(missionConfigFile >> "GeneralConfig" >> "debug") == 1) then {
	//cl_exp = 10000000000;
};

// Create markers
if (player getVariable "gameSide" == "defenders") then {
	_marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
	_marker1 setMarkerTypeLocal "b_unknown";
	_marker1 setMarkerTextLocal " Defenders HQ";

	_marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
	_marker2 setMarkerTypeLocal "o_unknown";
	_marker2 setMarkerTextLocal " Attackers HQ";
} else {
	_marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
	_marker1 setMarkerTypeLocal "o_unknown";
	_marker1 setMarkerTextLocal " Defenders HQ";

	_marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
	_marker2 setMarkerTypeLocal "b_unknown";
	_marker2 setMarkerTextLocal " Attackers HQ";
};

// Objective markers
_marker2 = createMarkerLocal ["objective",[0,0]];
_marker2 setMarkerTypeLocal "mil_objective";
_marker2 setMarkerTextLocal " Objective";
_marker2 setMarkerColorLocal "ColorBlack";

// Safepos markers (make sure units will not plop up on the battlefield)
_safeMarker1 = createMarkerLocal ["respawn_defenders", cl_safePos];
_safeMarker1 = createMarkerLocal ["respawn_attackers", cl_safePos];

// Markers
[true] spawn client_fnc_updateMarkers;

// Get time from server IF the match is already going or is about to, if not, it doesnt really matter
if (sv_gameStatus in [1,2]) then {
	cl_matchTime = 0;
	[player] remoteExec ["server_fnc_getMatchTime", 2];
};

CHBN_adjustBrightness = 1;

// Keyhandler
[] spawn client_fnc_initKeyHandler;

// Fuck off?
player enableStamina false;
player forceWalk false;

// Jump to client cycle position via sv_gameStatus
if (sv_gameStatus == 1) exitWith {
	// Map is being selected / prepared
	[] spawn client_fnc_waitForServer;
};
if (sv_gameStatus == 2) exitWith {
	// The game is ongoing
	[] spawn client_fnc_spawn;
};
if (sv_gameStatus in [3,4]) exitWith {
	// The game has been finished, just wait I guess
	[] spawn client_fnc_waitingForMatchToEnd;
};
