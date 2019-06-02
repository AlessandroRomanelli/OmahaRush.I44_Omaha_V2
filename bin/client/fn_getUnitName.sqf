scriptName "fn_getUnitName";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getUnitName.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUnitName.sqf"

if (isRemoteExecuted && remoteExecutedOwner != clientOwner) exitWith {
  systemChat (str remoteExecutedOwner);
  player setVariable ["name", name player, remoteExecutedOwner];
  "RETRIEVING NAME.."
};

private _unit = param [0, objNull, [objNull]];
if (player == _unit || local _unit) exitWith {name _unit};
if (isNull _unit || !isPlayer _unit) exitWith {"ERROR: NULL UNIT"};
systemChat str (format["Getting the name of: ", name _unit]);
private _name = _unit getVariable ["name", ""];
if (_name isEqualTo "") then {
  systemChat "Name was null";
  if (diag_tickTime - (_unit getVariable ["last_query", diag_tickTime]) > 10) then {
    _unit setVariable ["last_query", diag_tickTime];
    [] remoteExec ["client_fnc_getUnitName", _unit];
  };
  _name = "WARNING: Name Pending";
};

_name
