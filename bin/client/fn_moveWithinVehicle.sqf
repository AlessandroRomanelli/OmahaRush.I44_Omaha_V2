scriptName "fn_moveWithinVehicle";
/*--------------------------------------------------------------------
	Author: A. Roman

    File: fn_moveWithinVehicle.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_moveWithinVehicle.sqf"

if (isServer && !hasInterface) exitWith {};

params [["_DIKcode", 0, [0]]];

if (_DIKcode < 59 || _DIKcode > 68) exitWith {};

systemChat format ["Invoked moveWithinVehicle with key: %1", _DIKcode];

private _fnc_indexToRole = {
  params [["_index", 0, [0]], ["_vehicle", objNull, [objNull]]];
  if (_vehicle isEqualTo objNull) exitWith {""};
  private _count = 0;
  private _gunnerCount = count fullCrew [_vehicle, "gunner", true];
  private _commanderCount = count fullCrew [_vehicle, "commander", true];
  private _turretsCount = count fullCrew [_vehicle, "turret", true];
  private _cargoCount = count fullCrew [_vehicle, "cargo", true];
  if (_index == _count) exitWith {"Driver"};
  if (_index > _count && _index <= _count + _gunnerCount) exitWith {"Gunner"};
  _count = _count + _gunnerCount;
  if (_index > _count && _index <= _count + _commanderCount) exitWith {"Commander"};
  _count = _count + _commanderCount;
  if (_index > _count && _index <= _count + _turretsCount) exitWith {"Turret"};
  _count = _count + _turretsCount;
  if (_index > _count && _index <= _count + _cargoCount) exitWith {"Cargo"};
  ""
};

private _vehicle = vehicle player;
private _index = _DIKcode - 59;
private _role = [_index, _vehicle] call _fnc_indexToRole;
private _slotsOfRole = fullCrew [_vehicle, _role, true];

if (_role == "") exitWith {};

{
  private _unit = _x select 0;
  private _index = if (_role == "Cargo") then {_x select 2} else {_x select 3},
  if ((_unit == objNull) || (!alive _unit)) exitWith {
    if (_role == "Cargo") exitWith {
      player action ["moveToCargo", _vehicle, _index];
    };
    if (_role == "Turret") exitWith {
      player action ["moveToTurret", _vehicle, _index];
    };
    player action [format ["moveTo%1", _role]];
  }
} forEach _slotsOfRole;
