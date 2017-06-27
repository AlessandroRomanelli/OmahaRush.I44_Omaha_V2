scriptName "fn_damageHandler";
/*--------------------------------------------------------------------
	Author: A.Roman (aleromrod@gmail.com)
    File: fn_damageHandler.sqf

	<Maverick Applications>

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_damageHandler.sqf"

//Shooter
_s = param[0, objNull, [objNull]];
//Target
_u = param[1, objNull, [objNull]];
//Base damage
_dmg = param[2, 100];
//Distance at which damage should start to drop
_dMax = param[3, 100];
_dMin = param[4, 0];

if ((driver vehicle _s) getVariable ["side",sideUnknown] == (_u getVariable ["side",sideUnknown]) && (_s != player)) exitWith {};
//Get the time of last hit
_lastHit = _u getVariable ["lastHit", 0];
//If the time between last hit and new hit is more than 1/10 of a second
if ((diag_tickTime - _lastHit) > 0.1) then {
  //If the target is more than _dMax meters away from the shooter, decrease the damage;
  if (_u distance _s >= _dMax) then {
    _dmg = _dmg/(20+(_u distance _s)*0.75);
  };
  if (_u distance _s < _dMax && _u distance _s > _dMin) then {
    _dmg = _dmg/_dmg;
  };
  if (_u distance _s < _dMin) then {
    _dmg = random[0.7,0.8,0.7];
  };
  //Get the current damage of the victim, if the variable is undefined, sets it to 0
  _unitHP = _u getVariable ["unitDmg", 0];
  //Sets the damage of the unit to its current HP + the damage caused
  _u setDamage (_unitHP + _dmg);
  //Send a hit marker to the shooter
  if (_unitHP + _dmg < 1) then {
    _dmg remoteExec ["client_fnc_MPHit", _s];
  };

  if (_unitHP + _dmg >= 1 && _u getVariable ["isAlive", true]) then {
   _u setVariable ["isAlive", false];
   if (!(_u getVariable["wasHS", false])) then {
     [_u, false] remoteExec ["client_fnc_kill",_s];
   } else {
     [_u, true] remoteExec ["client_fnc_kill",_s];
   };
  };
  //Store the new unit HP
  _u setVariable ["unitDmg", _unitHP + _dmg];
  //Store the time of last hit
  _u setVariable ["lastHit", diag_tickTime];
};
