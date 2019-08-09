scriptName "fn_init";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV) & A. Roman
    File: fn_init.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_init.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

// Did the init run already?
if (!isNil "cl_init_ran") exitWith {};
cl_init_ran = true;
cl_init_done = false;

// Wait for the client to be ready for deployment
waitUntil {(!isNull (findDisplay 46)) AND (isNull (findDisplay 101)) AND (!isNull player) AND (alive player) AND !dialog};

// Disable saving
enableSaving [false, false];
enableRadio false;

// Wait for the server to be ready
VARIABLE_DEFAULT(sv_serverReady,false);

waitUntil {sv_serverReady && !isNil "sv_usingDatabase"};


[] call client_fnc_initGlobalVars;

"sv_settings" addPublicVariableEventHandler client_fnc_updateParams;

// Disable raytracing
disableRemoteSensors true;

// Player name
player setVariable ["name", name player, true];

[player] remoteExec ["server_fnc_assignSide", 2];
waitUntil {side player != civilian};

// Used for determining if a player is on our side since side _x returns civilian if someone is dead
player setVariable ["side", side player, true];

player setVariable ["gameSide", (
	[
		["defenders", "attackers"],
		["attackers", "defenders"]
	] select (sv_gameCycle % 2 == 0)
) select (side player == WEST), true];

cl_statisticsLoaded = false;
[] call client_fnc_loadStatistics;
waitUntil {cl_statisticsLoaded};

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
[] call client_fnc_resetVariables;

// Give onEachFrame data
[] call client_fnc_onEachFramePreparation;

// Init group client
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

// If this is the debug mode, just unlock everything
/* if (getNumber(missionConfigFile >> "GeneralConfig" >> "debug") == 1) then {
	cl_exp = 10000000000;
}; */

private _marker1 = createMarkerLocal ["mobile_respawn_defenders",[0,0]];
_marker1 setMarkerTypeLocal (["o_unknown","b_unknown"] select ((player getVariable "gameSide") == "defenders"));
_marker1 setMarkerTextLocal " Defenders HQ";

private _marker2 = createMarkerLocal ["mobile_respawn_attackers",[0,0]];
_marker1 setMarkerTypeLocal (["b_unknown","o_unknown"] select ((player getVariable "gameSide") == "defenders"));
_marker2 setMarkerTextLocal " Attackers HQ";

// Objective markers
private _marker3 = createMarkerLocal ["objective",[0,0]];
_marker3 setMarkerTypeLocal "mil_objective";
_marker3 setMarkerTextLocal " Objective";
_marker3 setMarkerColorLocal "ColorBlack";

// Trigger restricted area
private _marker4 = createMarkerLocal ["playArea", [0,0]];
_marker4 setMarkerTypeLocal "Empty";
_marker4 setMarkerTextLocal "";
_marker4 setMarkerShapeLocal "RECTANGLE";
_marker4 setMarkerBrushLocal "SolidBorder";
_marker4 setMarkerColorLocal "ColorWEST";
_marker4 setMarkerAlphaLocal 0.4;
_marker4 setMarkerSizeLocal [0, 0];
_marker4 setMarkerDirLocal 0;

createMarkerLocal ["respawn_guerrila", [50,0]];
createMarkerLocal ["respawn_west", [0,50]];
createMarkerLocal ["respawn_east", [50,50]];

private _trigger = createTrigger ["EmptyDetector", [0,0,0], false];
_trigger setTriggerArea [1, 1, 0, true, -1];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setTriggerStatements ['(player getVariable ["isAlive", false]) && this', "", ""];

missionNamespace setVariable ["playArea", _trigger];


// Safepos markers (make sure units will not plop up on the battlefield)
/* private _safeMarker1 = createMarkerLocal ["respawn_defenders", cl_safePos];
private _safeMarker2 = createMarkerLocal ["respawn_attackers", cl_safePos]; */

CHBN_adjustBrightness = 0.66;

// Keyhandler
[] spawn client_fnc_initKeyHandler;

// Fuck off?
player enableStamina false;
player forceWalk false;

cl_init_done = true;

// Jump to client cycle position via sv_gameStatus
if (sv_gameStatus == 1) exitWith {
	// Map is being selected / prepared
	[] call client_fnc_waitForServer;
};
if (sv_gameStatus == 2) exitWith {
	// The game is ongoing
	[] call client_fnc_spawn;
};
if (sv_gameStatus in [3,4]) exitWith {
	// The game has been finished, just wait I guess
	[] call client_fnc_waitingForMatchToEnd;
};
