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
cl_scoreboardHidden = true;

cl_soundLevel = 1;
(findDisplay 46) displayAddEventHandler ["KeyUp", {
	if ((_this select 1) == 15 && (sv_gameStatus in [1,2])) then {
		cl_scoreboardHidden = true;
		60001 cutRsc ["default", "PLAIN"];
	};
}];

(findDisplay 46) displayAddEventHandler ["KeyDown", {
	if ((_this select 1) == 15 && (sv_gameStatus in [1,2])) then {
		// Lets fill the scoreboard
		if !(cl_scoreboardHidden) exitWith {};
		if (cl_scoreboardHidden) then {
			cl_scoreboardHidden = false;
			disableSerialization;
			// Bring up ui for timer
			60001 cutRsc ["rr_scoreboard", "PLAIN"];

			_allInfoAttackers = [];
			_allInfoDefenders = [];
			_nAttacker = 0;
			_nDefender = 0;

			// Fill data from objects
			_h = true;
			{
				if ((_x getVariable "gameSide") == "defenders") then {
					_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], name _x];
				} else {
					_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], name _x];
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

	_h
}];
