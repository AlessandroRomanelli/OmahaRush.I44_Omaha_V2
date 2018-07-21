scriptName "fn_teleport";
/*--------------------------------------------------------------------
	Author: Roman
    File: fn_teleport.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
_dest = param [0, objNull];

if (({isPlayer _x && (_x getVariable ["gameSide", "attackers"] != player getVariable ["gameSide", "defenders"])} count (getPosWorld _dest nearEntities ["Man", 20])) > 0) exitWith {
  ["Enemies detected near tunnel exit"] spawn client_fnc_displayError;
};

_dir = random 359;
_rdist = random 2;
_pos = cl_safePos;
_pos set [0, (_pos select 0)+sin(_dir)*_rdist];
_pos set [1, (_pos select 1)+cos(_dir)*_rdist];

titleCut ["", "BLACK OUT", 0.5];
player allowDamage false;
sleep 0.75;
player setVariable ["isAlive", false];
player setPosWorld _pos;
titleText ["<t color='#ffffff' size='2'>Using the Tunnels...</t>", "PLAIN", -1, true, true];
sleep 1;
titleFadeOut 0.5;
sleep 0.5;

_pos = getPosWorld _dest;
_pos set [0, (_pos select 0)+sin(_dir)*_rdist];
_pos set [1, (_pos select 1)+cos(_dir)*_rdist];

player setPosWorld _pos;
player setDir (getDir _dest);

titleCut ["", "BLACK IN", 0.5];
sleep 0.5;
player allowDamage true;
player setVariable ["isAlive", true];
