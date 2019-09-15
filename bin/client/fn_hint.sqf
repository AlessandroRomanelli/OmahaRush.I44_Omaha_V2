scriptName "fn_hint";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_hint.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_hint.sqf"
if (isServer && !hasInterface) exitWith {};

private _header = param[0,"",[""]];
private _msg = param[1,"",[""]];


// Nope?
if (_header == "" || _msg == "") exitWith {};

uiNamespace setVariable ["hintDisplaying", true];
// Display!
20 cutRsc ["rr_hint","PLAIN"];

// Set text
((uiNamespace getVariable ["rr_hint", displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format ["<t size='1.5' color='#FFFFFF' shadow='2' align='left'>%1</t>", _header];
((uiNamespace getVariable ["rr_hint", displayNull]) displayCtrl 2) ctrlSetStructuredText parseText format ["<t size='1' color='#FFFFFF' shadow='2' align='left'>%1</t>", _msg];

uiSleep 10;

uiNamespace setVariable ["hintDisplaying", false];
