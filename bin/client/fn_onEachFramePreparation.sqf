scriptName "fn_onEachFramePreparation";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_onEachFramePreparation.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_onEachFramePreparation.sqf"

// Inline function to determine icon
_getIcon = {
	_unit = param[0,objNull,[objNull]];
	_icon = call {
		if (_unit getVariable ["class",""] == "medic") exitWith {"pictures\medic.paa"};
		if (_unit getVariable ["class",""] == "engineer") exitWith {"pictures\engineer.paa"};
		if (_unit getVariable ["class",""] == "support") exitWith {"pictures\support.paa"};
		"pictures\assault.paa";
	};
	_icon
};

// Variables
cl_onEachFrame_squad_members = [];
cl_onEachFrame_squad_beacons = [];
cl_onEachFrame_team_members = [];
cl_onEachFrame_team_reviveable = [];

while {true} do {
	// Temp vars
	_squad_members = [];
	_squad_beacons = [];
	_team_members = [];
	_toBeRevived = [];

	// Fill with data
	{
		if (_x != player) then {
			if (side (group _x) == side (group player)) then {
				if ((group _x) == (group player)) then {
					// Does this unit provide a beacon
					if (cl_inSpawnMenu) then {
						_beacon = _x getVariable ["assault_beacon_obj", objNull];
						if (!isNull _beacon) then {
							_squad_beacons pushBack [(getPosATLVisual _beacon), format["%1's Spawnbeacon", name _x]];
						};
					};

					// Is he alive
					if (alive _x) then {
						// The player should not be on the debug island
						if (_x distance cl_safePos > 200) then {
							_alpha = [0.75, 0.55] select (_x distance player > 50);
							_squad_members pushBack [_x, name _x, format["%1%2",MISSION_ROOT, [_x] call _getIcon], _alpha];
						};
					};
				} else {
					if (_x distance cl_safePos > 200 && alive _x) then {
						if (cl_inSpawnMenu || ((vehicle player) isKindOf "Air")) then {
							_team_members pushBack [_x, name _x, format["%1pictures\teammate.paa",MISSION_ROOT]];
						} else {
							// Only teammates within 100 meters
							if (_x distance player < 100 || _x == (driver vehicle cursorObject) || _x == (driver vehicle cursorTarget)) then {
								_team_members pushBack [_x, name _x, format["%1pictures\teammate.paa",MISSION_ROOT]];
							};
						};
					};
				};
			};
		};
	} forEach AllUnits;

	// Own beacon?
	if (cl_inSpawnMenu) then {
		_myBeacon = player getVariable ["assault_beacon_obj", objNull];
		if (!isNull _myBeacon) then {
			_squad_beacons pushBack [(getPosATLVisual _myBeacon), format["%1's Spawnbeacon", name player]];
		};
	};

	// Medics
	if (cl_class == "medic" && cl_classPerk == "defibrillator") then {
		{
			if (alive player && _x distance player < 25) then {
				if (_x getVariable ["side", sideUnknown] == playerSide) then {
					_toBeRevived pushBack [_x, format["%1pictures\revive.paa",MISSION_ROOT]];
				};
			};
		} forEach AllDeadMen;
	};

	// Overwrite variables
	cl_onEachFrame_squad_members = _squad_members;
	cl_onEachFrame_squad_beacons = _squad_beacons;
	cl_onEachFrame_team_members = _team_members;
	cl_onEachFrame_team_reviveable = _toBeRevived;
};
