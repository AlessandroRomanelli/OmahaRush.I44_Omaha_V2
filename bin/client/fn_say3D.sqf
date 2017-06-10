scriptName "fn_say3D";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_say3D.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_say3D.sqf"
if (isServer && !hasInterface) exitWith {};

(param[0,objNull,[objNull]]) say3D (param[1,"",[""]]);