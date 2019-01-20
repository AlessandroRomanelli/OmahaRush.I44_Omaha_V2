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
private _time = ["LobbyTime", 60] call BIS_fnc_getParamValue;

// Enable global voice
0 enableChannel [true, true];

// Bring up ui for timer
60001 cutRsc ["rr_timer", "PLAIN"];

private _d = uiNamespace getVariable ["rr_timer", displayNull];

// Lets fill the scoreboard
if (true) then {
	private _allInfoAttackers = [];
	private _allInfoDefenders = [];
	private _nAttacker = 0;
	private _nDefender = 0;

	// Fill data from objects
	{
		private _name = _x getVariable ["name", "ERROR: No Name"];
		if ((_x getVariable "gameSide") == "defenders") then {
			_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name];
		} else {
			_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name];
		};
	} forEach AllPlayers;

	// Sort data
	_allInfoAttackers sort false;
	_allInfoDefenders sort false;

	private _data = if ((player getVariable ["gameSide", ""]) isEqualTo "attackers") then {
		[" ATTACKERS (%1)", " DEFENDERS (%1)", _allInfoAttackers, _allInfoDefenders]
	} else {
		[" DEFENDERS (%1)", "ATTACKERS (%1)", _allInfoDefenders, _allInfoAttackers]
	};

	// Get controls
	private _listFriends = (_d displayCtrl 1);
	private _listEnemies = (_d displayCtrl 2);
	(_d displayCtrl 1001) ctrlSetStructuredText (parseText (format[_data select 0, {(_x getVariable ["gameSide", ""]) isEqualTo (player getVariable ["gameSide", ""])} count allPlayers]));
	(_d displayCtrl 1002) ctrlSetStructuredText (parseText (format[_data select 1, {!((_x getVariable ["gameSide", ""]) isEqualTo (player getVariable ["gameSide", ""]))} count allPlayers]));

	{_x lnbAddRow ["","NAME","K","D","SCORE",""]} forEach [_listFriends, _listEnemies];

	// Fill scoreboards
	{
		_nDefender = _nDefender + 1;
		_listFriends lnbAddRow [str _nDefender, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
	} forEach (_data select 2);
	{
		_nAttacker = _nAttacker + 1;
		_listEnemies lnbAddRow [str _nAttacker, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
	} forEach (_data select 3);
};


// If we have OnTenRestart enabled, WARN THE PLAYER
if ((sv_gameCycle >= ((["RotationsPerMatch", 2] call BIS_fnc_getParamValue) - 1)) && sv_dedicatedEnvironment) then {
	(_d displayCtrl 0) ctrlSetStructuredText parseText "<t size='2' color='#FE4629' shadow='2' align='center'>THE SERVER IS CHANGING MAP</t>";
	sleep 30;
} else {
// While loop
private _restartTime = diag_tickTime + _time;
private _timeLeft = _time;
	while {_timeLeft > 0 && (sv_gameStatus in [3,4])} do {
		sleep 1;
		_timeLeft = round (_restartTime - diag_tickTime);
		(_d displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='2' color='#FFFFFF' shadow='2' align='center'>Next match begins in %1</t>", [_timeLeft, "MM:SS"] call bis_fnc_secondsToString];
	};
};

// Delete cam
cl_exitcam_object cameraEffect ["TERMINATE","BACK"];
camDestroy cl_exitcam_object;
player switchCamera "INTERNAL";

// Disable global voice
0 enableChannel [false, false];

[] spawn client_fnc_saveStatistics;

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

cl_statisticsLoaded = false;
[] call client_fnc_loadStatistics;
waitUntil {cl_statisticsLoaded && {sv_gameStatus isEqualTo 2}};

// Reset everything
[] spawn client_fnc_resetVariables;

// Restart!
[] spawn client_fnc_spawn;

// Give us points for playing :)
[] spawn {
	private _fallBackTime = [] call client_fnc_getFallbackTime;
	sleep 3;
	// Message about preparation phase
	[format ["DEFENDERS HAVE %1 SECONDS TO PREPARE", _fallBackTime]] call client_fnc_displayObjectiveMessage;
};

cl_resetPlayerRunning = false;
