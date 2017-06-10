scriptName "fn_dumpObjects";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_dumpObjects.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_dumpObjects.sqf"

_objects = allMissionObjects "";

["OBJECT DUMP ENTRIES"] call server_fnc_log;
{
	[format ["OBJECT %1 | TYPE %2 | ISLOCAL %3 | POSITION %4", str _x, typeOf _x, local _x, getPos _x]] call server_fnc_log;
} forEach _objects;

["DUMP ENTRIES CREATED"] spawn client_fnc_displayError;