scriptName "fn_refreshTickets";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_refreshTickets.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_refreshTickets.sqf"

private _maxTickets = ["MaxTickets", 300] call BIS_fnc_getParamValue;
private _minTickets = ["MinTickets", 25] call BIS_fnc_getParamValue;
private _ticketRate = ["TicketsRate", 10] call BIS_fnc_getParamValue;

private _avgPlayersPerSide = (count allPlayers)/2;


private _tickets = ceil (_avgPlayersPerSide * _ticketRate);

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
