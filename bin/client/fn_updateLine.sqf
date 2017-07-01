scriptName "fn_updateLine";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateLine.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
_trigger = param[0, objNull];
_marker = param[1, ""];

#define __filename "fn_updateLine.sqf"
if (isServer && !hasInterface) exitWith {};

_a = (triggerArea _trigger) select 2;
_p = getPos _trigger;
_w = ((getMarkerSize _marker) select 1);
_d = ((triggerArea _trigger) select 1);
_t = _p;
_t set [0, (_p select 0) + ((_d - _w) * sin _a)];
_t set [1, (_p select 1) + ((_d - _w) * cos _a)];
_marker setMarkerPosLocal _t;
_marker setMarkerDirLocal _a;
