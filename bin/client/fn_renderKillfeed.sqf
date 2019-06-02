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

private _fnc_getColorForObj = {
	private _obj = param [0, objNull, [objNull]];
	if (isNull _obj) exitWith {"#FFFFFF"};
	private _color = "";
	private _sameSide = ((effectiveCommander vehicle _obj) getVariable ["side",civilian]) isEqualTo playerSide;
	private _sameGroup = (group _obj) isEqualTo (group player);
	if (_sameSide) then {
		if (_sameGroup) then {
			_color = '#009D05';
		} else {
			_color = '#3083F4';
		};
	} else {
		_color = '#FE251B';
	};
	_color
};

private _out = "";
{
	private _killer = (_x select 0) call BIS_fnc_objectFromNetId;
	private _kname = format["<t color='%1' shadow='2' font='PuristaMedium'>%2<t/>", [_killer] call _fnc_getColorForObj, [_killer] call client_fnc_getUnitName];
	systemChat _kname;
	private _victim = (_x select 2) call BIS_fnc_objectFromNetId;
	private _vname = format["<t color='%1' shadow='2' font='PuristaMedium'>%2<t/>", [_victim] call _fnc_getColorForObj, [_victim] call client_fnc_getUnitName];
	systemChat _vname;
	private _weapon = if ((_x select 1) == "") then {"KILLED"} else {([_x select 1] call client_fnc_weaponDetails) select 1};

	private _distance = format ["%1m", ceil (_killer distance _victim)];

	private _wasMelee = _x select 3;
	if (_wasMelee) then {
		_weapon = "KNIFE";
	};

	// Add to master string
	if (!isNull _killer) then {
		if (_killer isEqualTo _victim) then {
			_out = _out + _vname + " <t color='#ffffff' shadow='2'>COMMITTED SUICIDE<t/><br/>";
		} else {
			_out = _out + _kname + " <t color='#ffffff' shadow='2'>[" + _weapon + "]<t/> " + _vname + " <t color='#ffffff' shadow='2'>(" + _distance + ")<t/><br/>";
		};
	} else {
		_out = _out + _vname + " <t color='#ffffff' shadow='2'>DIED<t/><br/>";
	};
} forEach cl_killfeed;

(uiNamespace getVariable ["rr_objective_gui", displayNull] displayCtrl 10) ctrlSetStructuredText (parseText _out);
true
