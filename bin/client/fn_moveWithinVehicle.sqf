scriptName "fn_moveWithinVehicle";
/*--------------------------------------------------------------------
	Author: A. Roman

    File: fn_moveWithinVehicle.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_moveWithinVehicle.sqf"

if (isServer && !hasInterface) exitWith {};

params [["_DIKcode", 0, [0]]];

if (_DIKcode isEqualTo 0) exitWith {};

private _fnc_indexToRole = {
  params [["_index", 0, [0]], ["_vehicle", objNull, [objNull]]];
  if (_vehicle isEqualTo objNull) exitWith {""};
  private _count = 0;
  private _gunnerCount = count fullCrew [_vehicle, "gunner", true];
  private _commanderCount = count fullCrew [_vehicle, "commander", true];
  private _turretsCount = count fullCrew [_vehicle, "turret", true];
  private _cargoCount = count fullCrew [_vehicle, "cargo", true];
  if (_index == _count) exitWith {"driver"};
  if (_index > _count && _index <= _count + _gunnerCount) exitWith {"gunner"};
  _count = _count + _gunnerCount;
  if (_index > _count && _index <= _count + _commanderCount) exitWith {"commander"};
  _count = _count + _commanderCount;
  if (_index > _count && _index <= _count + _turretsCount) exitWith {"turret"};
  _count = _count + _turretsCount;
  if (_index > _count && _index <= _count + _cargoCount) exitWith {"cargo"};
  ""
};

private _fnc_switchSeat = {
  params [["_role", "", [""]], ["_vehicle", objNull, [objNull]], ["_turretIndexes", [], [[]]]];
  moveOut player;
  if (_role == "driver") exitWith {
    player moveInDriver _vehicle;
  };
  if (_role == "gunner") exitWith {
    player moveInGunner _vehicle;
  };
  if (_role == "commander") exitWith {
    player moveInCommander _vehicle;
  };
  if (_role == "turret") exitWith {
    player moveInTurret [_vehicle, _turretIndexes];
  };
  if (_role == "cargo") exitWith {
    player moveInCargo _vehicle;
  };
  player moveInAny _vehicle;
};

private _vehicle = vehicle player;
private _index = _DIKcode - 59;
private _role = [_index] call _fnc_indexToRole;
private _slotsOfRole = fullCrew [_vehicle, _role, true];

{
  if (_x select 0 == objNull) exitWith {
    [_role, _vehicle, (_slotsOfRole select _forEachIndex) select 3] spawn _fnc_switchSeat;
  }
} forEach _slotsOfRole;
