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
private _night = (round random 1) == 1;

private _time = if (_night) then {
  [1944,6,23, (19 + (floor (random 10))) % 24,0]
} else {
  [1944,6,23, (5 + (floor (random 14))),0]
};
setDate _time;
private _fog = (round random [0, 0, 20])/100;

// Overcast
skipTime -24;
86400 setOvercast (round random [0,1,10])/10;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 4;

// Set rain and fog
0 setRain ((floor random [0,0,10])/10);
setWind [(floor random 10)/10, (floor random 10)/10, false];
0 setWindDir random 359;
0 setFog _fog;


86400 setOvercast (round random [0,1,10])/10;
86400 setRain ((floor random [0,0,10])/10);
86400 setFog _fog;

true
