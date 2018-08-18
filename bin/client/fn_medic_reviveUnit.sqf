scriptName "fn_medic_reviveUnit";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_medic_reviveUnit.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_medic_reviveUnit.sqf"
if (isServer && !hasInterface) exitWith {};

private _unit = param[0,objNull,[objNull]];

// Unit still dead?
if (alive _unit) exitWith {};
if (playerSide != (_unit getVariable ["side",civilian])) exitWith {};
_unit setVariable ["unitDmg", 0];


// We've done good! Give me points and a dank animation!
["<t size='1.3' color='#FFFFFF'>TEAMMATE REVIVED</t>", 100] spawn client_fnc_pointfeed_add;
[100] spawn client_fnc_addPoints;

// Revive unit
[player] remoteExec ["client_fnc_revive",_unit];
