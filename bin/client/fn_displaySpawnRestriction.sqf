scriptName "fn_displaySpawnRestriction";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displaySpawnRestriction.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displaySpawnRestriction.sqf"

// Create display
30 cutRsc ["rr_keyBindingHintPermanent", "PLAIN"];

// Update text
while {cl_blockSpawnUntil - diag_tickTime > 0} do {
	((uiNamespace getVariable ["rr_keyBindingHintPermanent", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' align='center' t font='PuristaBold'><t color='#FD1A07'>%1</t> SECONDS UNTIL PUSH</t>", [cl_blockSpawnUntil - diag_tickTime, "MM:SS"] call BIS_fnc_secondsToString];
	sleep 1;
};

// Delete display
30 cutRsc ["default", "PLAIN"];