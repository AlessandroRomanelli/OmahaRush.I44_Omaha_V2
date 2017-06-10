scriptName "fn_waitingForMatchToEnd";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_waitingForMatchToEnd.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_waitingForMatchToEnd.sqf"
if (isServer && !hasInterface) exitWith {};

// Wait for others to finish their game, since we are jip
60000 cutRsc ["rr_black", "PLAIN"];
60001 cutRsc ["rr_timer", "PLAIN"];

// Wait display text
((uiNamespace getVariable ["rr_timer", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format "<t size='2' color='#FFFFFF' shadow='2' align='center'>Waiting for match to end</t>";

// Wait...
waitUntil {!(sv_gameStatus in [3,4])};

// spawn?
[] spawn client_fnc_spawn;