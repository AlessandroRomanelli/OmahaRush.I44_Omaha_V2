scriptName "fn_initKeyHandler";
/*--------------------------------------------------------------------
	Author: Maverick & A. Roman
    File: fn_initKeyHandler.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the authors!
--------------------------------------------------------------------*/
#define __filename "fn_initKeyHandler.sqf"
private _h = false;
cl_scoreboardHidden = true;

cl_soundLevel = 1;
(findDisplay 46) displayAddEventHandler ["KeyUp", {
	private _DIKcode = _this select 1;
	if (_DIKcode == 15 && (sv_gameStatus in [1,2])) then {
		cl_scoreboardHidden = true;
		60001 cutRsc ["default", "PLAIN"];
	};
}];

cl_lastKeyPressed = diag_tickTime;
cl_spamCount = 0;
cl_allowActions = true;

(findDisplay 46) displayAddEventHandler ["KeyDown", {
	private _DIKcode = _this select 1;
	if (_DIKcode == 15 && (sv_gameStatus in [1,2])) then {
		// Lets fill the scoreboard
		if !(cl_scoreboardHidden) exitWith {};
		if (cl_scoreboardHidden) then {
			cl_scoreboardHidden = false;
			disableSerialization;
			// Bring up ui for timer
			60001 cutRsc ["rr_scoreboard", "PLAIN"];

			private _d = (uiNamespace getVariable ["rr_scoreboard", displayNull]);

			private _allInfoAttackers = [];
			private _allInfoDefenders = [];

			// Fill data from objects
			_h = true;
			{
				private _name = (_x getVariable ["name", "ERROR: No Name"]);
				private _classInitial = [_x getVariable ["class", ""]] call {
					private _class = param [0, "", [""]];
					if (_class isEqualTo "medic") exitWith {"M"};
					if (_class isEqualTo "assault") exitWith {"A"};
					if (_class isEqualTo "engineer") exitWith {"E"};
					if (_class isEqualTo "support") exitWith {"S"};
					if (_class isEqualTo "recon") exitWith {"R"};
					"";
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

			private _data = if ((player getVariable ["gameSide", ""]) isEqualTo "attackers") then {
				[" ATTACKERS (%1)", " DEFENDERS (%1)", _allInfoAttackers, _allInfoDefenders]
			} else {
				[" DEFENDERS (%1)", "ATTACKERS (%1)", _allInfoDefenders, _allInfoAttackers]
			};
			// Get controls
			(_d displayCtrl 0) ctrlSetStructuredText (parseText "<t shadow='2'>SCOREBOARD</t>");
			(_d displayCtrl 1001) ctrlSetStructuredText (parseText (format[_data select 0, {(_x getVariable ["gameSide", ""]) isEqualTo (player getVariable ["gameSide", ""])} count allPlayers]));
			(_d displayCtrl 1002) ctrlSetStructuredText (parseText (format[_data select 1, {!((_x getVariable ["gameSide", ""]) isEqualTo (player getVariable ["gameSide", ""]))} count allPlayers]));
			private _listFriendlies = (_d displayCtrl 1);
			private _listEnemies = (_d displayCtrl 2);
			{_x lnbAddRow ["","NAME","K","D","SCORE",""]} forEach [_listFriendlies, _listEnemies];

			// Fill scoreboards
			{
			/* _listDefenders lnbAddRow [str _nDefender, (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)]; */
			_listFriendlies lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
			} forEach (_data select 2);
			{
				_listEnemies lnbAddRow [(_x select 4), (_x select 3), str (_x select 1), str (_x select 2), str (_x select 0)];
			} forEach (_data select 3);
		};
	};

	// Earplugs
	if (_DIKcode == 21) then {
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

	// Space bar to deploy parachute
	if (_DIKcode == 57) then {
		if ((isNull (objectParent player)) && {((getPos player) select 2) > 30} && {!(isTouchingGround (vehicle player))} && {player getVariable ["hasChute", true]}) then {
			_h = true;
			private _posPlayer = position player;
			private _dirPlayer = getDir player;
			private _velPlayer = velocity player;
			{_velPlayer set [_forEachIndex, _x/5]} forEach _velPlayer;
			private _para = "NonSteerable_Parachute_F" createVehicle _posPlayer;
			player moveInDriver _para;
			_para setPos _posPlayer;
			_para setVelocity _velPlayer;
			_para setDir _dirPlayer;
			player setVariable ["hasChute", false];
			["PRESS <t size='1.5'>[SPACE BAR]</t> TO CUT YOUR PARACHUTE!"] spawn client_fnc_displayInfo;
		} else {
			if ((typeOf (vehicle player)) isEqualTo "NonSteerable_Parachute_F") then {
				private _para = vehicle player;
				moveOut player;
				[_para] spawn {
					private _para = param[0, objNull, [objNull]];
					sleep 5;
					deleteVehicle _para;
				};
			};
		};
	};

	// F1 - OBJECTS DUMP
	if (_DIKcode == 59) then {
		_h = true;
		[] spawn client_fnc_dumpObjects;
	};

	// T - SPOTTING TARGETS
	if (_DIKcode == 20 && cl_allowActions) then {
		_h = true;
		if (diag_tickTime - cl_lastKeyPressed < 3) then {
			cl_spamCount = cl_spamCount + 1;
		} else {
			cl_spamCount = 0;
		};
		if (cl_spamCount > 5) then {
			if (isNil "cl_disableKeyThread") then {
				cl_disableKeyThread = [] spawn {
					cl_allowActions = false;
					sleep 5;
					cl_allowActions = true;
					cl_disableKeyThread = nil;
				};
			};
		} else {
			[] spawn client_fnc_spotTarget;
		};
	};
	cl_lastKeyPressed = diag_tickTime;
	_h
}];
