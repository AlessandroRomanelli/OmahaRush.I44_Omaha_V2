scriptName "fn_armMCOM";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_armMCOM.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_armMCOM.sqf"
if (isServer && !hasInterface) exitWith {};

if (sv_cur_obj getVariable ["armed",false]) exitWith {};
if (!alive player) exitWith {};

// Set armed
sv_cur_obj setVariable ["armed",true,true];

// Give points
["<t size='1.3' color='#FFFFFF'>EXPLOSIVES ARMED</t><br/><t size='1.0' color='#FFFFFF'>Objective Attacker</t>", 225] spawn client_fnc_pointfeed_add;
[225] spawn client_fnc_addPoints;

// Animate
[sv_cur_obj,1] call BIS_fnc_dataTerminalAnimate;

// Inform everyone that the mcom has been planted
[player] remoteExec ["client_fnc_MCOMarmed", 0];
