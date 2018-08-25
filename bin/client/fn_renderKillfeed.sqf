scriptName "fn_renderKillfeed";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_renderKillfeed.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_renderKillfeed.sqf"
if (isServer && !hasInterface) exitWith {};

if (isNil "cl_killfeed") exitWith {};

private _out = "";
{
	private _killerName = (_x select 0) getVariable ["name", "ERROR: No Name"];
	private _weapon = if ((_x select 1) == "") then {"KILLED"} else {([_x select 1] call client_fnc_weaponDetails) select 1};
	private _killer = if (((driver vehicle (_x select 0)) getVariable ["side",civilian]) == playerSide) then {
		if (group (_x select 0) == group player) then {
			"<t color='#009D05' shadow='2' font='PuristaMedium'>" + _killerName + "<t/>"
		} else {
			"<t color='#3083F4' shadow='2' font='PuristaMedium'>" + _killerName + "<t/>"
		};
	} else {
		"<t color='#FE251B' shadow='2' font='PuristaMedium'>" + _killerName + "<t/>"
	};

	private _killedName = (_x select 2) getVariable ["name", "ERROR: No Name"];
	private _killed = if (((driver vehicle (_x select 2)) getVariable ["side",civilian]) == playerSide) then {
		if (group (_x select 2) == group player) then {
			"<t color='#009D05' shadow='2' font='PuristaMedium'>" + _killedName + "<t/>"
		} else {
			"<t color='#3083F4' shadow='2' font='PuristaMedium'>" + _killedName + "<t/>"
		};
	} else {
		"<t color='#FE251B' shadow='2' font='PuristaMedium'>" + _killedName + "<t/>"
	};

	private _distance = format ["%1m", ceil ((_x select 0) distance (_x select 2))];

	// Add to master string
	_out = _out + _killer + " <t color='#ffffff' shadow='2'>[" + _weapon + "]<t/> " + _killed + " <t color='#ffffff' shadow='2'>(" + _distance + ")<t/><br/>";
} forEach cl_killfeed;

(uiNamespace getVariable ["rr_objective_gui", displayNull] displayCtrl 10) ctrlSetStructuredText (parseText _out);
