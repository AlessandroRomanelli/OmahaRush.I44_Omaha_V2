scriptName "fn_vehicleDisabled";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_vehicleDisabled.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_vehicleDisabled.sqf"

params [["_points", 0, [0]], ["_wasDestroyed", false, [false]], ["_vehString", "VEHICLE", ["VEHICLE"]]];

private _view = if (_wasDestroyed) then {"hm_kill"} else {"hm_hit"};

27 cutRsc [_view, "PLAIN"];
[format ["<t size='1.3' color='#FFFFFF'>%1 DESTROYED</t>", _vehString], _points] call client_fnc_pointfeed_add;
[_points] call client_fnc_addPoints;
