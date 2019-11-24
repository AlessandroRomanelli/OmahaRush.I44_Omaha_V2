scriptName "fn_initKeyHandler";
/*--------------------------------------------------------------------
	Author: Maverick & A. Roman
    File: fn_initKeyHandler.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the authors!
--------------------------------------------------------------------*/
#define __filename "fn_initKeyHandler.sqf"
#define KEY_ESC 1
#define KEY_TAB 15
#define KEY_T 20
#define KEY_Y 21
#define KEY_SPACE 57
#define KEY_F1 58
#define KEY_F10 69
#define KEY_1 0x02
#define KEY_0 0x0B
#define KEY_NUMENTER 0x9C

#include "..\utils.h"

cl_scoreboardHidden = true;

cl_soundLevel = 1;
(findDisplay 46) displayAddEventHandler ["KeyUp", {
	private _DIKcode = _this select 1;
	if (_DIKcode == KEY_TAB && (sv_gameStatus in [1,2])) then {
		60001 cutRsc ["default", "PLAIN"];
	};
}];

cl_lastKeyPressed = diag_tickTime;
cl_spamCount = 0;
cl_allowActions = true;
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	private _DIKcode = _this select 1;
	private _h = false;
	if (_DIKcode == KEY_NUMENTER) then {
		VARIABLE_DEFAULT(sv_setting_InfantryFPOnly,1);
		VARIABLE_DEFAULT(sv_setting_VehicleFPOnly,0);
		_h = 	(isNull(objectParent player) && sv_setting_InfantryFPOnly == 1) ||
				(!isNull(objectParent player) && sv_setting_VehicleFPOnly == 1);
	};
	if (_DIKcode == KEY_TAB && (sv_gameStatus in [1,2])) then {
		private _scoreboardHidden = isNull (uiNamespace getVariable ["rr_scoreboard", displayNull]);
		if !(_scoreboardHidden) exitWith {};
		disableSerialization;
		60001 cutRsc ["rr_scoreboard", "PLAIN"];
		private _d = (uiNamespace getVariable ["rr_scoreboard", displayNull]);
		_h = true;
		[_d] call client_fnc_populateScoreboard;
	};

	// Earplugs
	if (_DIKcode == KEY_Y) then {
		_h = false;
		switch (cl_soundLevel) do
		{
			case 1:
			{
				cl_soundLevel = 0.5;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been reduced to 50%"] call client_fnc_displayInfo;
			};
			case 0.5:
			{
				cl_soundLevel = 0.1;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been reduced to 10%"] call client_fnc_displayInfo;
			};
			case 0.1:
			{
				cl_soundLevel = 1;
				0.5 fadeSound cl_soundLevel;
				["Soundlevel has been increased to 100%"] call client_fnc_displayInfo;
			};
		};
	};

	// Space bar to deploy parachute
	if (_DIKcode == KEY_SPACE) then {
		if (alive player && {isNull (objectParent player)} && {((getPos player) select 2) > 30} && {!(isTouchingGround (vehicle player))} && {player getVariable ["hasChute", true]}) then {
			_h = true;
			private _posPlayer = position player;
			private _dirPlayer = getDir player;
			private _velPlayer = (velocity player) vectorMultiply 0.1;
			private _para = "NonSteerable_Parachute_F" createVehicle _posPlayer;
			player moveInDriver _para;
			_para setPos _posPlayer;
			_para setVelocity _velPlayer;
			_para setDir _dirPlayer;
			player setVariable ["hasChute", false];
			["PRESS <t size='1.5'>[SPACE BAR]</t> TO CUT YOUR PARACHUTE!"] call client_fnc_displayInfo;
		} else {
			if ((typeOf (vehicle player)) isEqualTo "NonSteerable_Parachute_F") then {
				private _para = vehicle player;
				moveOut player;
				if (((getPos player) select 2) < 6) then {
					player allowDamage false;
					[] spawn {
						waitUntil{isTouchingGround player};
						player allowDamage true;
					};
				};
				[_para] spawn {
					private _para = param[0, objNull, [objNull]];
					uiSleep 5;
					deleteVehicle _para;
				};
			};
		};
	};

	/* // F1 - OBJECTS DUMP
	if (_DIKcode == 59 && (_this select 2) && (_this select 3)) then {
		_h = true;
		[] spawn client_fnc_dumpObjects;
	}; */

	// F1 to F10 - SEAT SWITCH
	if (_DIKcode > KEY_F1 && _DIKcode < KEY_F10) then {
		_h = true;
		if (!isNull (objectParent player)) then {
			[_DIKcode] call client_fnc_moveWithinVehicle;
		};
	};

	if (_DIKcode >= KEY_4 && _DIKcode <= KEY_0) then {
		_h = true;
	};


	// T - SPOTTING TARGETS
	if (_DIKcode == KEY_T) then {
		if (!cl_allowActions) exitWith {
			private _text = format ["3D SPOTTING BLOCKED FOR %1 SECONDS", round (cl_lastKeyPressed + 5 - diag_tickTime)];
			[_text] call client_fnc_displayError;
		};
		// Do not override engine key event
		_h = false;
		if (diag_tickTime - cl_lastKeyPressed < 1.5) then {
			cl_spamCount = cl_spamCount + 1;
		} else {
			cl_spamCount = 0;
		};
		if (cl_spamCount > 5) then {
			if (isNil "cl_disableKeyThread") then {
				cl_disableKeyThread = [] spawn {
					cl_allowActions = false;
					uiSleep 5;
					cl_allowActions = true;
					cl_disableKeyThread = nil;
				};
			};
		} else {
			[] call client_fnc_spotTarget;
		};
		cl_lastKeyPressed = diag_tickTime;
	};
	_h
}];

true
