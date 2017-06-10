scriptName "fn_displayKeyBindingHint";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayKeyBindingHint.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayKeyBindingHint.sqf"

_text = param[0,"",[""]];

28 cutRsc ["rr_keyBindingHint", "PLAIN"];
((uiNamespace getVariable ["rr_keyBindingHint", displayNull]) displayCtrl 0) ctrlSetStructuredText parseText _text;