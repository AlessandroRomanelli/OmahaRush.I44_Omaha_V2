scriptName "fn_refreshTickets";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_refreshTickets.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_refreshTickets.sqf"

_maxTickets = paramsArray#0;
_minTickets = paramsArray#1;

_attackers = (count allPlayers)/2;

_ticketRate = paramsArray#2;

_tickets = ceil (_attackers * _ticketRate);

if (_tickets > _maxTickets) then {
  _tickets = _maxTickets;
} else {
  if (_tickets < _minTickets) then {
    _tickets = _minTickets;
  };
};

// Set tickets
sv_tickets = _tickets;
sv_tickets_total = _tickets;

// Broadcast
[["sv_tickets","sv_tickets_total"]] spawn server_fnc_updateVars;
