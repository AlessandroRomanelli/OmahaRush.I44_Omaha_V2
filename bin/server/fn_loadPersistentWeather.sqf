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
_time = [2035,6,6,7,40];
setDate _time;

// Overcast
skipTime -24;
86400 setOvercast 0;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 0.1;

// Set rain and fog
0 setRain 0;
0 setFog 0;

[] spawn {
	for "_i" from 1 to 5 step 1 do
	{
		0 setFog 0;
		sleep 60;
	};
};