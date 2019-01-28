scriptName "fn_teamBalanceKick";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_teamBalanceKick.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_teamBalanceKick.sqf"
if (isServer && !hasInterface) exitWith {};

private _sideToJoin = param[0,sideUnknown,[sideUnknown]];

if (_sideToJoin == sideUnknown) exitWith {};

// Save data
[] call client_fnc_saveStatistics;
uiSleep 1;

// End mission according to side
if (_sideToJoin == WEST) then {
	endMission "JoinWEST";
} else {
	endMission "Joinindependent";
};
