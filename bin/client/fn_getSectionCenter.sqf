scriptName "fn_getSectionCenter";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_getSectionCenter.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getSectionCenter.sqf"

private _pos1 = param[0,[],[[]]];
private _pos2 = param[1,[],[[]]];

private _ret = [0,0,0];

_ret set[0,((_pos2 select 0) + (_pos1 select 0))/2];
_ret set[1,((_pos2 select 1) + (_pos1 select 1))/2];
_ret set[2,((_pos2 select 2) + (_pos1 select 2))/2];

_ret;
