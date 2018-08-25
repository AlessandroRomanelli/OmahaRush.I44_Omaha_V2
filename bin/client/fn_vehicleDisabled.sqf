scriptName "fn_vehicleDisabled";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_vehicleDisabled.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_vehicleDisabled.sqf"

private _points = _this;


if (_points == 500) exitWith {
  27 cutRsc ["hm_kill","PLAIN"];
  ["<t size='1.3' color='#FFFFFF'>TANK DESTROYED</t>", _points] spawn client_fnc_pointfeed_add;
  [_points] spawn client_fnc_addPoints;
};
if (_points == 300) exitWith {
  27 cutRsc ["hm_kill","PLAIN"];
  ["<t size='1.3' color='#FFFFFF'>ARMOR DESTROYED</t>", _points] spawn client_fnc_pointfeed_add;
  [_points] spawn client_fnc_addPoints;
};
if (_points == 150) exitWith {
  27 cutRsc ["hm_kill","PLAIN"];
  ["<t size='1.3' color='#FFFFFF'>VEHICLE DESTROYED</t>", _points] spawn client_fnc_pointfeed_add;
  [_points] spawn client_fnc_addPoints;
};
if (_points == 200) exitWith {
  25 cutRsc ["hm_hit","PLAIN"];
  ["<t size='1.3' color='#FFFFFF'>ARMOR DISABLED</t>", _points] spawn client_fnc_pointfeed_add;
  [_points] spawn client_fnc_addPoints;
};
if (_points == 100) exitWith {
  25 cutRsc ["hm_hit","PLAIN"];
  ["<t size='1.3' color='#FFFFFF'>VEHICLE DISABLED</t>", _points] spawn client_fnc_pointfeed_add;
  [_points] spawn client_fnc_addPoints;
};
