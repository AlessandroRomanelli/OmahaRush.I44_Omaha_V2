scriptName "fn_incomingMissile";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_incomingMissile.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_incomingMissile.sqf"

// Only run when were the pilot
if ((driver vehicle player) != player) exitWith {};

// Warn player about the missile
["MISSLE INCOMING"] spawn client_fnc_displayError;

[] spawn {
	for "_i" from 1 to 20 step 1 do
	{
		playSound "missile_incoming";
		sleep 0.2;
	};
};

// If we havent deployed countermeasures yet, tell us to
if !((vehicle player) getVariable ["flares_deployed", false]) then {
	[] spawn client_fnc_displayCountermeasureKeys;
};