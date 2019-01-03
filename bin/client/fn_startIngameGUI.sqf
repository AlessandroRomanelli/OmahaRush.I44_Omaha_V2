scriptName "fn_startIngameGUI";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_startIngameGUI.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_startIngameGUI.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Start the ingame gui
300 cutRsc ["playerHUD","PLAIN"];
disableSerialization;

if (isNil "rr_spawn_bottom_right_hud_ran") then {
	rr_spawn_bottom_right_hud_ran = true;
};
