scriptName "fn_initKeyHandler";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_initKeyHandler.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initKeyHandler.sqf"
_h = false;
player setVariable ["scoreboardHidden", true];

cl_soundLevel = 1;
(findDisplay 46) displayAddEventHandler ["KeyUp", {
	if ((_this select 1) == 15 && (sv_gameStatus in [1,2])) then {
		player setVariable ["scoreboardHidden", true];
		60001 cutRsc ["default", "PLAIN"];
	};
}];

(findDisplay 46) displayAddEventHandler ["KeyDown", {

	if ((_this select 1) == 15 && (sv_gameStatus in [1,2])) then {
		// Lets fill the scoreboard
		if (player getVariable "scoreboardHidden") then {
			player setVariable ["scoreboardHidden", false];
			disableSerialization;
			// Bring up ui for timer
			60001 cutRsc ["rr_scoreboard", "PLAIN"];

			// Lets share our stats with the others
			player setVariable ["kills",cl_kills,true];
			player setVariable ["deaths",cl_deaths,true];
			player setVariable ["points",cl_points,true];

			_allInfoAttackers = [];
			_allInfoDefenders = [];
			_nAttacker = 0;
			_nDefender = 0;

			// Fill data from objects
			if (true) then {
				_h = true;
					{if ((_x getVariable "gameSide") == "defenders") then {
							_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], (_x getVariable ["name", ""])];
						} else {
							_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], (_x getVariable ["name", ""])];
						};
					} forEach AllPlayers;

					// Sort data
					_allInfoAttackers sort false;
					_allInfoDefenders sort false;
					// Get controls
					_listAttackers = ((uiNamespace getVariable ["rr_scoreboard", displayNull]) displayCtrl 2);
					_listDefenders = ((uiNamespace getVariable ["rr_scoreboard", displayNull]) displayCtrl 1);
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
		};
	};

	if ((_this select 1) == 1) then {
		_h = true;
		[] spawn client_fnc_saveStatistics;
	};

	// Earplugs
	if ((_this select 1) == 21) then {
		_h = true;
		switch (cl_soundLevel) do
		{
			case 1:
			{
				cl_soundLevel = 0.5;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been reduced to 50%"] spawn client_fnc_displayInfo;
			};
			case 0.5:
			{
				cl_soundLevel = 0.1;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been reduced to 10%"] spawn client_fnc_displayInfo;
			};
			case 0.1:
			{
				cl_soundLevel = 1;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been increased to 100%"] spawn client_fnc_displayInfo;
			};
		};
	};

	// F1 - OBJECTS DUMP
	if ((_this select 1) == 59) then {
		_h = true;
		[] spawn client_fnc_dumpObjects;
	};

	// Flares
	if ((_this select 1) in (actionKeys "LaunchCM")) then {
		if ((vehicle player) isKindOf "Air" && ((driver vehicle player) == player)) then {
			_h = true;
			cl_reloadFlares_thread = [vehicle player] spawn client_fnc_reloadFlares; // Deploy and reload flares
		};
	};

	_h
}];
