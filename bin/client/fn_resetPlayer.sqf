scriptName "fn_resetPlayer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_resetPlayer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_resetPlayer.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Make sure we dont run twice
if (missionNamespace getVariable ["cl_resetPlayerRunning", false]) exitWith {};
cl_resetPlayerRunning = true;

// Start a countdown until the next match starts
_time = "LobbyTime" call bis_fnc_getParamValue;

// Enable global voice
0 enableChannel [true, true];

// Bring up ui for timer
60001 cutRsc ["rr_timer", "PLAIN"];

// Lets fill the scoreboard
if (true) then {
	_allInfoAttackers = [];
	_allInfoDefenders = [];
	_nAttacker = 0;
	_nDefender = 0;

	// Fill data from objects
	{
		_name = _x getVariable ["name", "ERROR: No Name"];
		if ((_x getVariable "gameSide") == "defenders") then {
			_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name];
		} else {
			_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name];
		};
	} forEach AllPlayers;

	// Sort data
	_allInfoAttackers sort false;
	_allInfoDefenders sort false;

	// Get controls
	_listAttackers = ((uiNamespace getVariable ["rr_timer", displayNull]) displayCtrl 2);
	_listDefenders = ((uiNamespace getVariable ["rr_timer", displayNull]) displayCtrl 1);
	_listAttackers lnbAddRow ["#","","K","D","SCORE",""];
	_listDefenders lnbAddRow ["#","","K","D","SCORE",""];

	// Fill scoreboards
	{
		_nDefender = _nDefender + 1;
		_listDefenders lnbAddRow [str _nDefender, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
	} forEach _allInfoDefenders;
	{
		_nAttacker = _nAttacker + 1;
		_listAttackers lnbAddRow [str _nAttacker, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
	} forEach _allInfoAttackers;
};


// If we have OnTenRestart enabled, WARN THE PLAYER
if ((sv_gameCycle >= (("RotationsPerMatch" call bis_fnc_getParamValue) - 1)) && sv_dedicatedEnvironment) then {
	((uiNamespace getVariable ["rr_timer", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FE4629' shadow='2' align='center'>THE SERVER IS CHANGING MAP</t>";
	sleep 30;
} else {
// While loop
	while {_time > 0} do {
		sleep 1;
		_time = _time - 1;

		((uiNamespace getVariable ["rr_timer", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='2' color='#FFFFFF' shadow='2' align='center'>Next match begins in %1</t>", [_time, "MM:SS"] call bis_fnc_secondsToString];
	};
};

// Delete cam
cl_exitcam_object cameraEffect ["TERMINATE","BACK"];
camDestroy cl_exitcam_object;
player switchCamera "INTERNAL";

// Disable global voice
0 enableChannel [false, false];


// Reset everything
[] spawn client_fnc_resetVariables;

// Do not allow spawning within the first 30 seconds
_fallBackTime = "FallBackSeconds" call bis_fnc_getParamValue;
cl_blockSpawnUntil = diag_tickTime + _fallBackTime;
cl_blockSpawnForSide = "attackers";
[] spawn client_fnc_displaySpawnRestriction;


// Restart!
[] spawn client_fnc_spawn;

// Restart match timer
_roundTime = ceil (("RoundTime" call bis_fnc_getParamValue) * 60);
[_roundTime + _fallBackTime, _fallBackTime] call client_fnc_initMatchTimer;

// Give us points for playing :)
[] spawn {
	_fallBackTime = "FallBackSeconds" call bis_fnc_getParamValue;
	sleep 3;
	// Message about preparation phase
	[format ["DEFENDERS HAVE %1 SECONDS TO PREPARE", _fallBackTime]] spawn client_fnc_displayObjectiveMessage;
};

cl_resetPlayerRunning = false;
