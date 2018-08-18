scriptName "fn_teleport";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_teleport.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
private _dest = param [0, objNull];
private _path = param [1, "tunnels"];

if (({isPlayer _x && (_x getVariable ["gameSide", "attackers"] != player getVariable ["gameSide", "defenders"])} count (getPosWorld _dest nearEntities ["Man", 20])) > 0) exitWith {
  ["Enemies detected near tunnel exit"] spawn client_fnc_displayError;
};

private _dir = random 359;
private _rdist = random 2;
private _pos = cl_safePos;
_pos set [0, (_pos select 0)+sin(_dir)*_rdist];
_pos set [1, (_pos select 1)+cos(_dir)*_rdist];

titleCut ["", "BLACK OUT", 0.5];
player allowDamage false;
sleep 0.75;
player setVariable ["isAlive", false];
player setPosATL _pos;
titleText [format ["<t color='#ffffff' size='2'>Using the %1...</t>", _path], "PLAIN", -1, true, true];
sleep 1;
titleFadeOut 0.5;
sleep 0.5;

_pos = getPosATL _dest;
_pos set [0, (_pos select 0)+sin(_dir)*_rdist];
_pos set [1, (_pos select 1)+cos(_dir)*_rdist];

player setPosATL _pos;
player setDir (getDir _dest);

titleCut ["", "BLACK IN", 0.5];
sleep 0.5;
player allowDamage true;
player setVariable ["isAlive", true];
