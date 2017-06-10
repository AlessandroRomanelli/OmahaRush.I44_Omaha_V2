scriptName "fn_spawnMenu_displayGroupManagement";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_spawnMenu_displayGroupManagement.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_spawnMenu_displayGroupManagement.sqf"
if (isServer && !hasInterface) exitWith {};

// Display the group management system
(findDisplay 5000) createDisplay "RscDisplayDynamicGroups";