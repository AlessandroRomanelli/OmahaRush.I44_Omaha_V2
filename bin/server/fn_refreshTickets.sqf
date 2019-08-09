scriptName "fn_refreshTickets";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_refreshTickets.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_refreshTickets.sqf"
#include "..\utils.h"

private _avgPlayersPerSide = (count allPlayers)/2;

VARIABLE_DEFAULT(sv_setting_MaxTickets,300);
VARIABLE_DEFAULT(sv_setting_MinTickets,25);
VARIABLE_DEFAULT(sv_setting_TicketsRate,10);

private _tickets = ceil (_avgPlayersPerSide * sv_setting_TicketsRate);

if (_tickets > sv_setting_MaxTickets) then {
  _tickets = sv_setting_MaxTickets;
} else {
  if (_tickets < sv_setting_MinTickets) then {
    _tickets = sv_setting_MinTickets;
  };
};

// Set tickets
sv_tickets = _tickets;
sv_tickets_total = _tickets;

// Broadcast
[["sv_tickets","sv_tickets_total"]] call server_fnc_updateVars;
