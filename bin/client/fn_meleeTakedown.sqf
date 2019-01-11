scriptName "fn_meleeTakedown";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_meleeTakedown.sqf

    Written by both authors
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_meleeTakedown.sqf"
if (isServer && !hasInterface) exitWith {};

private _killer = param [0, objNull, [objNull]];
player setVariable ["melee_killer", _killer];
player setDamage 1;
