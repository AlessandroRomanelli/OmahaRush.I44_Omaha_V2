scriptName "fn_log";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_log.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_log.sqf"

if (getNumber(missionConfigFile >> "GeneralConfig" >> "debug") == 1) then {
	diag_log format["Rush-Redux-Server-Log: %1",param[0,"",[""]]];
};