scriptName "fn_loadWeather";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadWeather.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadWeather.sqf"

_time = getArray(missionConfigFile >> "Maps" >> sv_map >> "date");
_fog = getNumber(missionConfigFile >> "Maps" >> sv_map >> "fog");
_rain = getNumber(missionConfigFile >> "Maps" >> sv_map >> "rain");
_overcast = getNumber(missionConfigFile >> "Maps" >> sv_map >> "rain");

// Apply overcast value
// This has to be done via skipping as ArmA has to calculate the clouds
skipTime -24;
86400 setOvercast _overcast;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 0.1;

// Apply values
setDate _time;
0 setRain _rain;
0 setFog _fog;

[_fog] spawn {
	_tick = diag_tickTime;
	while {diag_tickTime - _tick < 120} do
	{
		sleep 1;
		0 setFog (_this select 0);
	};
};