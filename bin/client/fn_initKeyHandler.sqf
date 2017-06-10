scriptName "fn_initKeyHandler";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_initKeyHandler.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initKeyHandler.sqf"

cl_soundLevel = 1;
(findDisplay 46) displayAddEventHandler ["KeyDown", {
	_h = false;

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