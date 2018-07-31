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

params [["_victim", objNull], ["_wasHS", false]];

// Increase kills
cl_kills = cl_kills + 1;
cl_total_kills = cl_total_kills + 1;

player setVariable ["kills",cl_kills,true];

// Get seat in vehicle
_seat = -2;
if !(isNull objectParent player) then {
	_v = vehicle player;

	// Check if we are the driver
	if ((driver _v) == player) then {
		_seat = -1;
	};

	// Check if we are the gunner
	if ((gunner _v) == player) then {
		_seat = 0;
	};
};

// Pushback into render array
_curWeapon = if (_seat in [-1, 0]) then {
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

// Display hit marker
_HSkill = "";
if (_wasHS) then {
	-0.03122 call client_fnc_MPHit;
	_HSkill = "<br/><t size='1.0' color='#FFFFFF'>HEADSHOT BONUS</t>";
	_points = _points + 50;
} else {
	-0.03184 call client_fnc_MPHit;
};

// Any additional points?
_distanceKill = "";
if (_victim distance player > 50) then {
	_distanceKill = "<br/><t size='1.0' color='#FFFFFF'>LONG RANGE KILL</t>";

	// very far shot?
	if (_victim distance player > 120) then {
		_distanceKill = _distanceKill + "<br/><t size='1.0' color='#FFFFFF'>MARKSMAN BONUS</t>";
		_points = _points + 50;
	};

	_distanceKill = _distanceKill + format ["<t size='0.85' color='#FFFFFF'> [%1m]</t>", floor (_victim distance player)];
	// Additional points
	_points = _points + 15;
};
_objectiveKill = "";
if ((player distance sv_cur_obj) < 20 || (_victim distance sv_cur_obj) < 20) then {
	if (player getVariable "gameSide" == "defenders") then {
		_objectiveKill = "<br/><t size='1.0' color='#FFFFFF'>OBJECTIVE DEFENDER</t>";
	} else {
		_objectiveKill = "<br/><t size='1.0' color='#FFFFFF'>OBJECTIVE ATTACKER</t>";
	};

	// Additional points
	_points = _points + 50;
};

// We've done good! Give me points
/* ["<t size='1.3'>[" + _reason + "] <t color='#FE251B'>" + (_victim getVariable ["name", ""]) + "</t></t>" + _HSkill + _distanceKill + _objectiveKill, _points] spawn client_fnc_pointfeed_add; */
["<t size='1.3'>[" + _reason + "] <t color='#FE251B'>" + name _victim + "</t></t>" + _HSkill + _distanceKill + _objectiveKill, _points] spawn client_fnc_pointfeed_add;
[_points] spawn client_fnc_addPoints;
