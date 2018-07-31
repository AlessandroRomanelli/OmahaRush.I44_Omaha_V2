scriptName "fn_updateLine";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateLine.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_updateLine.sqf"
if (isServer && !hasInterface) exitWith {};

params [["_trigger", objNull], ["_marker", ""]];

_size = [(triggerArea _trigger) select 0, (triggerArea _trigger) select 1];
_angle = (triggerArea _trigger) select 2;
_pos = getPos _trigger;

_marker setMarkerPosLocal _pos;
_marker setMarkerSizeLocal _size;
_marker setMarkerDirLocal _angle;

nil
