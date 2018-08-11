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
				_name = (_x getVariable ["name", "ERROR: No Name"]);
				_classInitial = [_x getVariable ["class", "medic"]] call {
					_class = param [0, "", [""]];
					if (_class isEqualTo "medic") exitWith {"M"};
					if (_class isEqualTo "assault") exitWith {"A"};
					if (_class isEqualTo "engineer") exitWith {"E"};
					if (_class isEqualTo "support") exitWith {"S"};
					if (_class isEqualTo "recon") exitWith {"R"};
					"?";
				};
				if ((_x getVariable "gameSide") == "defenders") then {
					_allInfoDefenders pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name, _classInitial];
				} else {
					_allInfoAttackers pushBack [_x getVariable ["points", 0], _x getVariable ["kills", 0], _x getVariable ["deaths", 0], _name, _classInitial];
				};
			} forEach AllPlayers;

			// Sort data
			_allInfoAttackers sort false;
			_allInfoDefenders sort false;
			// Get controls
			_title = ((uiNamespace getVariable ["rr_scoreboard", displayNull]) displayCtrl 0);
			_title ctrlSetStructuredText (parseText "<t shadow='2'>SCOREBOARD</t>");
			_listAttackers = ((uiNamespace getVariable ["rr_scoreboard", displayNull]) displayCtrl 2);
			_listDefenders = ((uiNamespace getVariable ["rr_scoreboard", displayNull]) displayCtrl 1);
			_listDefenders lnbAddRow ["","NAME","K","D","SCORE",""];
			_listAttackers lnbAddRow ["","NAME","K","D","SCORE",""];

			// Fill scoreboards
			{
			_nDefender = _nDefender + 1;
			/* _listDefenders lnbAddRow [str _nDefender, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)]; */
			_listDefenders lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
			} forEach _allInfoDefenders;
			{
				_nAttacker = _nAttacker + 1;
				_listAttackers lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
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
