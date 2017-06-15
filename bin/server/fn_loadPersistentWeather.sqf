scriptName "fn_loadPersistentWeather";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadPersistentWeather.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadPersistentWeather.sqf"

// Time
_time = [2035,ceil random 12, ceil random 30,floor random 24,floor random 60];
setDate _time;

// Overcast
skipTime -24;
86400 setOvercast floor random 10/10;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 10;

// Set rain and fog
0 setRain floor random 10/10;
0 setFog floor random 40/100;

[] spawn {
	for "_i" from 1 to 5 step 1 do
	{
		0 setFog 0;
		sleep 60;
	};
};
