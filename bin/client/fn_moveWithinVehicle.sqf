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

private _fnc_indexToRole = {
  params [["_index", 0, [0]], ["_vehicle", objNull, [objNull]]];
  if (isNull _vehicle) exitWith {""};
  private _count = 0;
  private _crew = fullCrew [_vehicle, "", true];
  private _gunnerCount = {_x select 1 == "gunner"} count _crew;
  private _commanderCount = {_x select 1 == "commander"} count _crew;
  private _turretsCount = {_x select 1 == "turret"} count _crew;
  private _cargoCount = {_x select 1 == "cargo"} count _crew;
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
	_x params ["_unit", "_unitRole", "_cargoIdx", "_turretPath"];
	private _index = if (_role == "Cargo") then {_cargoIdx} else {_turretPath},
	if ((_unit == objNull) || (!alive _unit)) exitWith {
		if (_role == "Cargo" || _role == "Turret") exitWith {
			player action ["moveTo"+_role, _vehicle, _index];
		};
		player action ["moveTo"+_role, _vehicle];
	}
} forEach _slotsOfRole;

true
