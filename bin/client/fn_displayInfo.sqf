scriptName "fn_displayInfo";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayInfo.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayInfo.sqf"

disableSerialization;
private _text = param[0,"",[""]];

// Display error rsc
35 cutRsc ["rr_errorText","PLAIN"];

private _display = uiNamespace getVariable ["errorText", displayNull];

(_display displayCtrl 0) ctrlSetStructuredText parseText format ["<t size='1.5' align='center' shadow='2' font='PuristaMedium' color='#ffffff'>%1</t>", _text];

true
