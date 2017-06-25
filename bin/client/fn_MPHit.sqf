scriptName "fn_MPHit";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_MPHit.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_MPHit.sqf"
if (isServer && !hasInterface) exitWith {};

_damage = _this;

// Kill
if (_damage == -0.03184) exitWith {
	27 cutRsc ["hm_kill","PLAIN"];
};

// Anything else
if (_damage < 1) then {
	25 cutRsc ["hm_hit","PLAIN"];
};

if (_damage == -0.03122) exitWith {
	26 cutRsc ["hm_headshot","PLAIN"];
};
