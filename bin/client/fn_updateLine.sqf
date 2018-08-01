scriptName "fn_updateLine";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateLine.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/


#define __filename "fn_updateLine.sqf"
if (isServer && !hasInterface) exitWith {};

_size = [(triggerArea playArea) select 0, (triggerArea playArea) select 1];
_angle = (triggerArea playArea) select 2;
_pos = getPos playArea;

"playArea" setMarkerPosLocal _pos;
"playArea" setMarkerSizeLocal _size;
"playArea" setMarkerDirLocal _angle;

true
