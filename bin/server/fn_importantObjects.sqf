scriptName "fn_importantObjects";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_importantObjects.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_importantObjects.sqf"

if (true) exitWith {};

_types = [];

_objects = nearestObjects [sv_cur_obj, _types, 2000];

{
	_x enableSimulationGlobal false;
} forEach _objects;