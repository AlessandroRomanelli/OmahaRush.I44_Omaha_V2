scriptName "fn_vehicleDisabled";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_vehicleDisabled.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_vehicleDisabled.sqf"

["<t size='1.3' color='#FFFFFF'>VEHICLE DISABLED</t>", 85] spawn client_fnc_pointfeed_add;
[85] spawn client_fnc_addPoints;