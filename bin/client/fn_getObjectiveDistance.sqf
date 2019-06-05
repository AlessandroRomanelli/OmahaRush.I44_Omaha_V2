scriptName "fn_getObjectiveDistance";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_getObjectiveDistance.sqf

    Written by A. Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getObjectiveDistance.sqf"

private _obj = param[0,objNull,[objNull]];
private _distance = _obj getVariable ["action_dist", -1];
if (_distance > -1) exitWith {_distance};

private ["_getObjectSize", "_sizes", "_width", "_length", "_dir", "_max", "_x", "_y"];

_getObjectSize = {
  private ["_obj", "_bbr", "_p1", "_p2", "_width", "_length"];
  _obj = param[0, objNull, [objNull]];
  _bbr = boundingBoxReal _obj;
  _p1 = _bbr select 0;
  _p2 = _bbr select 1;
  _width = abs((_p1 select 0) - (_p2 select 0));
  _length = abs((_p1 select 1) - (_p2 select 1));
  [_width/2, _length/2]
};

_sizes = [_obj] call _getObjectSize;
_width = 0;
_length = 0;
if (_sizes select 0 > _sizes select 1) then {
  _width = (_sizes select 1)/2;
  _length = (_sizes select 0)/2;
} else {
  _width = (_sizes select 0)/2;
  _length = (_sizes select 1)/2;
};
_dir = _obj getRelDir player;
_max = sqrt(_width^2 + _length^2);
_x = abs(_max * sin(_dir)) min _width;
_y = abs(_max * cos(_dir)) min _length;
_distance = sqrt((_x^2) + (_y^2));
_obj setVariable ["action_dist", _distance];

_distance
