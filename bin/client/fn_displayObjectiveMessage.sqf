scriptName "fn_displayObjectiveMessage";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayObjectiveMessage.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayObjectiveMessage.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Create layer (at the very top)
50000 cutRsc ["rr_objectivemessage","PLAIN"];

// Get display
_d = uiNamespace getVariable ["rr_objectivemessage",displayNull];

// Display text
(_d displayCtrl 0) ctrlSetStructuredText parseText ("<t size='4' color='#FFFFFF' shadow='2' align='center'>" + (param[0,"",[""]]) + "</t>");