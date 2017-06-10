scriptName "fn_kill";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_kill.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_kill.sqf"
if (isServer && !hasInterface) exitWith {};

// Display hit marker
-0.03184 call client_fnc_MPHit;

_personIKilled = param[0,objNull,[objNull]];

if (playerSide == (_personIKilled getVariable ["side",civilian])) exitWith {};

// Increase kills
cl_kills = cl_kills + 1;
cl_total_kills = cl_total_kills + 1;

// Get seat in vehicle
_possibleTurrentIndex = -2;
if ((vehicle player) != player) then {
	_v = vehicle player;

	// Check if we are the driver
	if ((driver _v) == player) then {
		_possibleTurrentIndex = -1;
	};

	// Check if we are the gunner
	if ((gunner _v) == player) then {
		_possibleTurrentIndex = 0;
	};
};

// Pushback into render array
_curWeapon = if (_possibleTurrentIndex in [-1, 0]) then {
	currentWeapon (vehicle player)
} else {
	currentWeapon player
};

// Current weapon
_curWeapon = currentWeapon (vehicle player);
_reason = "KILLED";

if (_curWeapon != "") then {
	_reason = (([_curWeapon] call client_fnc_weaponDetails) select 1);
};

_points = 100;

// Any additional points?
_distanceKill = "";
if (_personIKilled distance player > 50) then {
	_distanceKill = "<br/><t size='1.0' color='#FFFFFF'>LONG RANGE KILL</t>";

	// very far shot?
	if (_personIKilled distance player > 120) then {
		_distanceKill = _distanceKill + "<br/><t size='1.0' color='#FFFFFF'>MARKSMAN BONUS</t>";
		_points = _points + 50;
	};

	// Additional points
	_points = _points + 15;
};
_objectiveKill = "";
if ((player distance sv_cur_obj) < 20 || (_personIKilled distance sv_cur_obj) < 20) then {
	if (playerSide == WEST) then {
		_objectiveKill = "<br/><t size='1.0' color='#FFFFFF'>OBJECTIVE DEFENDER</t>";
	} else {
		_objectiveKill = "<br/><t size='1.0' color='#FFFFFF'>OBJECTIVE ATTACKER</t>";
	};

	// Additional points
	_points = _points + 50;
};

// We've done good! Give me points
["<t size='1.3'>[" + _reason + "] <t color='#FE251B'>" + (_personIKilled getVariable ["name", ""]) + "</t></t>" + _distanceKill + _objectiveKill, _points] spawn client_fnc_pointfeed_add;
[_points] spawn client_fnc_addPoints;