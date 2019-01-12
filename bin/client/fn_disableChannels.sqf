scriptName "fn_disableChannels";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_disableChannels.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_disableChannels.sqf"
if (isServer && !hasInterface) exitWith {};

0 enableChannel false;
1 enableChannel true;
2 enableChannel false;
3 enableChannel true;
4 enableChannel true;
5 enableChannel true;

true
