scriptName "fn_loadWeather";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_loadWeather.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_loadWeather.sqf"

private _time = getArray(missionConfigFile >> "MapSettings" >> sv_mapSize >> "date");
private _fog = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "fog");
private _rain = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "rain");
private _overcast = getNumber(missionConfigFile >> "MapSettings" >> sv_mapSize >> "rain");

// Apply overcast value
// This has to be done via skipping as ArmA has to calculate the clouds
skipTime -24;
86400 setOvercast _overcast;
skipTime 24;

// Slow down ingame time
setTimeMultiplier 10;

// Apply values
setDate _time;
0 setRain _rain;
0 setFog _fog;

[_fog] spawn {
	private _fog = param[0, 0, [0]];
	private _tick = diag_tickTime;
	while {diag_tickTime - _tick < 120} do
	{
		uiSleep 1;
		0 setFog _fog;
	};
};

true
