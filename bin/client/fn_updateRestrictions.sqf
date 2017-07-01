scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

if ((str sv_cur_obj) == (str sv_stage1_obj)) then {
	warnAreaAtk setPos [3730.27,2384.22,2.92921];
	warnAreaAtk setTriggerArea [750, 350, 358.5, true, -1];
	warnAreaDef setPos [3597.66,2973.67,0];
	warnAreaDef setTriggerArea [750, 150, 124, true, -1];
};

if ((str sv_cur_obj) == (str sv_stage2_obj)) then {
	warnAreaAtk setPos [3121.8,2085.41,2.92918];
	warnAreaAtk setTriggerArea [750, 350, 69, true, -1];
	warnAreaDef setPos [3884.89,2627.72,0];
	warnAreaDef setTriggerArea [750, 350, 235, true, -1];
};

if ((str sv_cur_obj) == (str sv_stage3_obj)) then {
	warnAreaAtk setPos [2741,2116.05,2.92918];
	warnAreaAtk setTriggerArea [750, 350, 90, true, -1];
	warnAreaDef setPos [3596.49,2243.36,0.286148];
	warnAreaDef setTriggerArea [750, 350, 265, true, -1];
};

if ((str sv_cur_obj) == (str sv_stage4_obj)) then {
	warnAreaAtk setPos [2375.56,1936.5,2.92947];
	warnAreaAtk setTriggerArea [750, 350, 51, true, -1];
	warnAreaDef setPos [3169.92,2119.37,1.33087];
	warnAreaDef setTriggerArea [750, 350, 270, true, -1];
};

if (player getVariable "gameSide" == "defenders") then {
	[warnAreaDef, "warnLineDef"] spawn client_fnc_updateLine;
	"warnLineAtk" setMarkerPosLocal [0,0];
} else {
	[warnAreaAtk, "warnLineAtk"] spawn client_fnc_updateLine;
	"warnLineDef" setMarkerPosLocal [0,0];
};


// Update enemy base marker name
cl_enemySpawnMarker = if (player getVariable "gameSide" == "defenders") then {"mobile_respawn_attackers"} else {"mobile_respawn_defenders"};
