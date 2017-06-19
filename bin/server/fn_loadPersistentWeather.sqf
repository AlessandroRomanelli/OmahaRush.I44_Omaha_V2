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
_time = [2035,ceil random 12, ceil random 30,floor random [0, 12, 24],floor random 60];
setDate _time;
_fog = floor random 40/100;

// Overcast
skipTime -24;
86400 setOvercast floor random 10/10;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 10;

// Set rain and fog
0 setRain floor random 10/10;
setWind [floor random 25/10, floor random 25/10, false];
0 setFog _fog;

[_fog] spawn {
	_fog = param [0];
	for "_i" from 1 to 5 step 1 do
	{
    0 setFog _fog;
		sleep 60;
	};
};
