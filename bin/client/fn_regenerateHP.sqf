scriptName "fn_regenerateHP";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_regenerateHP.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_regenerateHP.sqf"
if (isServer && !hasInterface) exitWith {};

// Lets regenerate HP after 5 seconds of not taking damage
uiSleep 5;

// Not in combat anymore (DISABLED FOR NETWORK PERFORMANCE)
/* player setVariable ["inCombat",nil,true]; */

// Regenerate HP
while {damage player > 0} do {
	player setDamage ((damage player) - 0.02);
	// Set overall damage but don't allow damage to unwanted selections
	{
			player setHit [_x, 0];
	} forEach ((getAllHitPointsDamage player) select 1);
	uiSleep 0.2;
};

// Reset assists
cl_assistsInfo = [];
