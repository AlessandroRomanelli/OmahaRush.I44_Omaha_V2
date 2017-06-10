scriptName "fn_refreshTickets";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_refreshTickets.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_refreshTickets.sqf"

_tickets = getNumber(missionConfigFile >> "Maps" >> sv_map >> "tickets");

// Set tickets
sv_tickets = _tickets;
sv_tickets_total = _tickets;

// Broadcast
[["sv_tickets","sv_tickets_total"]] spawn server_fnc_updateVars;