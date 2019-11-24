scriptName "fn_resetPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_resetPlayer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_resetPlayer.sqf"
#include "..\utils.h"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Make sure we dont run twice
if (missionNamespace getVariable ["cl_resetPlayerRunning", false]) exitWith {};
cl_resetPlayerRunning = true;

// Start a countdown until the next match starts

// Enable global voice
0 enableChannel [true, false];

// Bring up ui for timer
60001 cutRsc ["rr_timer", "PLAIN"];

private _d = uiNamespace getVariable ["rr_timer", displayNull];
[_d] call client_fnc_populateScoreboard;

VARIABLE_DEFAULT(sv_setting_RotationsPerMatch, 2);

// If we have OnTenRestart enabled, WARN THE PLAYER
if ((sv_gameCycle >= (sv_setting_RotationsPerMatch - 1)) && sv_dedicatedEnvironment) then {
	(_d displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FE4629' shadow='2' align='center'>THE SERVER IS CHANGING MAP</t>";
	uiSleep 30;
} else {
// While loop
VARIABLE_DEFAULT(sv_setting_LobbyTime, 30);
private _restartTime = diag_tickTime + sv_setting_LobbyTime;
private _timeLeft = sv_setting_LobbyTime;
	while {_timeLeft > 0 && (sv_gameStatus in [3,4])} do {
		uiSleep 1;
		_timeLeft = round (_restartTime - diag_tickTime);
		(_d displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='2' color='#FFFFFF' shadow='2' align='center'>Next match begins in %1</t>", [_timeLeft, "MM:SS"] call bis_fnc_secondsToString];
	};
};

// Delete cam
cl_exitcam_object cameraEffect ["TERMINATE","BACK"];
camDestroy cl_exitcam_object;
player switchCamera "INTERNAL";

// Disable global voice
0 enableChannel false;

[] spawn client_fnc_saveStatistics;

/* player setVariable ["gameSide", (
  [
    ["defenders", "attackers"],
    ["attackers", "defenders"]
  ] select (sv_gameCycle % 2 == 0)
) select (side player == WEST), true]; */

[] call client_fnc_loadStatistics;
waitUntil {sv_gameStatus isEqualTo 2};

// Reset everything
[] call client_fnc_resetVariables;

// Restart!
[] spawn client_fnc_spawn;

// Give us points for playing :)
[] spawn {
	private _fallBackTime = [] call client_fnc_getFallbackTime;
	uiSleep 3;
	// Message about preparation phase
	[format ["DEFENDERS HAVE %1 SECONDS TO PREPARE", _fallBackTime]] call client_fnc_displayObjectiveMessage;
};

cl_resetPlayerRunning = false;
