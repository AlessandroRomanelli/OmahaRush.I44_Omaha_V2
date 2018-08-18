scriptName "fn_updateLine";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateLine.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_updateLine.sqf"
if (isServer && !hasInterface) exitWith {};

private _marker = param[0, "", [""]];

private _size = [(triggerArea playArea) select 0, (triggerArea playArea) select 1];
private _angle = (triggerArea playArea) select 2;
private _pos = getPos playArea;

_marker setMarkerPosLocal _pos;
_marker setMarkerSizeLocal _size;
_marker setMarkerDirLocal _angle;

true
