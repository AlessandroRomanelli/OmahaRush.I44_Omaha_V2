scriptName "fn_damageHandler";
/*--------------------------------------------------------------------
	Author: A.Roman (aleromrod@gmail.com)
    File: fn_damageHandler.sqf

	<Maverick Applications>

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_damageHandler.sqf"

params [["_shooter", objNull], ["_unit", objNull], ["_damage", 100], ["_drop", 300], ["_distMax", 100], ["_distMin", 0]];

_distance = _unit distance _shooter;

if (_distance >= _distMax) then {
  _damageDealt = _damage/100 - (((_distance - _distMax)/_drop)^(5/2));
};
if (_distance < _distMax && _distance > _distMin) then {
  _damageDealt = _damage/100;
};
if (_distance < _distMin) then {
  _damageDealt = _damage/150;
};
if (_damageDealt < 1) then {
  _damageDealt remoteExec ["client_fnc_MPHit", _shooter];
};
_damageDealt
