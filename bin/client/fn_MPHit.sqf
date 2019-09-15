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

private _damage = _this;

// Kill
if (_damage == -0.03184) exitWith {
	27 cutRsc ["hm_kill","PLAIN"];
	playSound "hit_marker";
};

// Anything else
if (_damage > 0 && _damage < 1) exitWith {
	25 cutRsc ["hm_hit","PLAIN"];
	playSound "hit_marker";
};

if (_damage == -0.03122) exitWith {
	26 cutRsc ["hm_headshot","PLAIN"];
	playSound "head_shot";
};

true
