scriptName "fn_getUnitName";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getUnitName.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUnitName.sqf"

private _unit = param [0, objNull, [objNull]];

if (local _unit) exitWith {
  name _unit
};

if (isRemoteExecuted && {local _unit}) exitWith {
  diag_log ("DEBUG: Remote execution for name of: " + name _unit);
  if (remoteExecutedOwner isEqualTo 0 || remoteExecutedOwner == clientOwner) exitWith {};
  _unit setVariable ["name", name _unit, remoteExecutedOwner];
};

if (isNull _unit || !isPlayer _unit) exitWith {"ERROR: NULL UNIT"};
private _name = _unit getVariable ["name", ""];
if (_name isEqualTo "") then {
  if ((diag_tickTime - (_unit getVariable ["last_query", diag_tickTime])) > 30) then {
    _unit setVariable ["last_query", diag_tickTime];
    [_unit] remoteExec ["client_fnc_getUnitName", _unit];
  };
  _name = "WARNING: Name Pending";
};

_name
