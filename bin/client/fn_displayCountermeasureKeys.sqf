scriptName "fn_displayCountermeasureKeys";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_displayCountermeasureKeys.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayCountermeasureKeys.sqf"

_keys = actionKeysNamesArray "LaunchCM";

_keysText = "";
for "_i" from 0 to (count _keys - 1) step 1 do
{
	if (_i == (count _keys - 1)) then {
		_keysText = _keysText + (_keys select _i);
	} else {
		_keysText = _keysText + (_keys select _i) + ", ";
	};
};

["<t size='1' color='#FFFFFF' shadow='2' align='center' t font='PuristaBold'>PRESS <t color='#FD1A07'>" + _keysText + "</t> TO DEPLOY COUNTERMEASURES</t>"] spawn client_fnc_displayKeyBindingHint;