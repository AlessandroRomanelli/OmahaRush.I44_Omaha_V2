scriptName "fn_monitorSquad";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_monitorSquad.sqf

    Written by Maverick A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_monitorSquad.sqf"
if (isServer && !hasInterface) exitWith {};

while {player getVariable ["isAlive", false]} do {
  _squadSize = count (units group player);
  waitUntil{sleep 5; _squadSize != count (units group player)};
  cl_squadPerks = [] call client_fnc_getSquadPerks;
};

true
