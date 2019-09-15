scriptName "fn_disarmMCOM";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_disarmMCOM.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_disarmMCOM.sqf"
if (isServer && !hasInterface) exitWith {};

// If it wasn't armed, there's nothing to disarm!
private _status = sv_cur_obj getVariable ["status", -1];
if (_status == -1 || _status > 1) exitWith {};
if (!alive player || {cl_action_obj != sv_cur_obj}) exitWith {};

// Set disarmed
sv_cur_obj setVariable ["status", 2, true];

// Send message to everyone
["THE EXPLOSIVES HAVE BEEN DEFUSED"] remoteExecCall ["client_fnc_displayObjectiveMessage", -2];

// Give points
["<t size='1.3' color='#FFFFFF'>EXPLOSIVES DISARMED</t><br/><t size='1.0' color='#FFFFFF'>Objective Defender</t>", 425] call client_fnc_pointfeed_add;
[425] call client_fnc_addPoints;
true

//Todo Add MLG version
