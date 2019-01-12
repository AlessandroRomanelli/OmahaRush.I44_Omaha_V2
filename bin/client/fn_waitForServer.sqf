scriptName "fn_waitForServer";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_waitForServer.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_waitForServer.sqf"
if (isServer && !hasInterface) exitWith {};

player setVariable ["playerInitOK", true, true];
// Apparently the server isnt done selecting a map yet
60000 cutRsc ["waitingForPlayers", "PLAIN"];
cl_waitingThread = addMissionEventHandler["EachFrame", {
  private _display = uiNamespace getVariable ["waitingForPlayers", displayNull];
  private _connectedCtrl = _display displayCtrl 1101;
  private _readyCtrl = _display displayCtrl 1102;
  private "_color";
  private _players = playersNumber WEST + playersNumber INDEPENDENT;
  private _readyPlayers = {_x getVariable ["playerInitOK", false]} count allPlayers;
  if (_readyPlayers < round(_players*0.4)) then {
    _color = "#FF0000";
  } else {
    if (_readyPlayers >= round(_players*0.4) && _readyPlayers < round(_players*0.8)) then {
      _color = "#FFFF00";
    } else {
      _color = "#00FF00";
    };
  };
  _connectedCtrl ctrlSetStructuredText (parseText (format ["CONNECTED: %1", _players]));
  _readyCtrl ctrlSetStructuredText (parseText (format ["READY: <t color='%2'>%1</t>", _readyPlayers, _color]));
}];

waitUntil{sv_gameStatus isEqualTo 2};
removeMissionEventHandler ["EachFrame", cl_waitingThread];
// Cycle..
60000 cutText ["", "PLAIN"];

[] call client_fnc_spawn;
