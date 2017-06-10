scriptName "fn_evaluateAssistInfo";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_evaluateAssistInfo.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_evaluateAssistInfo.sqf"
if (isServer && !hasInterface) exitWith {};

_info = param[0,[],[[]]];
_killer = param[1,objNull,[objNull]];

// No data, no passing
["Assistinfo called -1"] call server_fnc_log;
if (count _info == 0) exitWith {};

// We killed this person, how about not giving us even more points for assisting this kill
["Assistinfo called"] call server_fnc_log;
if (_killer == player) exitWith {};

["Evaluating assists.."] call server_fnc_log;
[str _info] call server_fnc_log;

// Get all data from the array regarding us
_myData = [];
{
	if ((_x select 0) == player) then {
		_myData = _x;
	};
} forEach _info;

["Assists detected"] call server_fnc_log;
[str _myData] call server_fnc_log;

// We did not assist? :(
if (count _myData == 0) exitWith {["No own data"] call server_fnc_log;};

// Round decimals
_damage = _myData select 1;
_damage = round (_damage * (10 ^ 2)) / (10 ^ 2);
if (_damage >= 1) then {_damage = 1;};
_myData set [1, _damage];


// Yay, we assisted! Display points'n'shit
if ((_myData select 1) > 0.15) then {
	["Damage was greater 0.15"] call server_fnc_log;
	if ((_myData select 1) < 0.8) then {
		// Regular assist
		[format["<t size='1.3' color='#FFFFFF'>%1 DAMAGE KILL ASSIST</t>",(_myData select 1) * 100], (_myData select 1) * 100] spawn client_fnc_pointfeed_add;
		[(_myData select 1) * 100] spawn client_fnc_addPoints;
	} else {
		// We inflicted so much damage, why not count it as a kill?
		[format["<t size='1.3' color='#FFFFFF'>%1 DAMAGE KILL ASSIST</t><br/><t size='1.0' color='#FFFFFF'>ASSIST COUNTS AS KILL</t>",(_myData select 1) * 100], (_myData select 1) * 100] spawn client_fnc_pointfeed_add;
		[(_myData select 1) * 100] spawn client_fnc_addPoints;

		// Add a kill
		cl_kills = cl_kills + 1;
		cl_total_kills = cl_total_kills + 1;
	};
} else {
	["Damage wasn't greater 0.15"] call server_fnc_log;
};