scriptName "fn_updateRestrictions";
/*--------------------------------------------------------------------
	Author: SSgt. A. Roman
    File: fn_updateRestrictions.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_updateRestrictions.sqf"
if (isServer && !hasInterface) exitWith {};

switch (str sv_cur_obj) do {
  case (str sv_stage1_obj): {
		_atkArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Area" >> "Attacker" >> "area"));
		_atkArea set [3, true];
		_defArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Area" >> "Defender" >> "area"));
		_defArea set [3, true];
		area_atk setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Area" >> "Attacker" >> "positionATL"));
		area_atk setTriggerArea _atkArea;
		area_def setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage1" >> "Area" >> "Defender" >> "positionATL"));
		area_def setTriggerArea _defArea;
  };
	case (str sv_stage2_obj): {
		_atkArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Area" >> "Attacker" >> "area"));
	 	_atkArea set [3, true];
	 	_defArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Area" >> "Defender" >> "area"));
	 	_defArea set [3, true];
	 	area_atk setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Area" >> "Attacker" >> "positionATL"));
	 	area_atk setTriggerArea _atkArea;
	 	area_def setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage2" >> "Area" >> "Defender" >> "positionATL"));
	 	area_def setTriggerArea _defArea;
	};
	case (str sv_stage3_obj): {
		_atkArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Area" >> "Attacker" >> "area"));
		_atkArea set [3, true];
		_defArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Area" >> "Defender" >> "area"));
		_defArea set [3, true];
		area_atk setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Area" >> "Attacker" >> "positionATL"));
		area_atk setTriggerArea _atkArea;
		area_def setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage3" >> "Area" >> "Defender" >> "positionATL"));
		area_def setTriggerArea _defArea;
	};
	case (str sv_stage4_obj): {
		_atkArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Area" >> "Attacker" >> "area"));
		_atkArea set [3, true];
		_defArea = (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Area" >> "Defender" >> "area"));
		_defArea set [3, true];
		area_atk setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Area" >> "Attacker" >> "positionATL"));
		area_atk setTriggerArea _atkArea;
		area_def setPos (getArray(missionConfigFile >> "Maps" >> sv_map >> "Stages" >> "Stage4" >> "Area" >> "Defender" >> "positionATL"));
		area_def setTriggerArea _defArea;
	};
};

if (player getVariable ["gameSide", "defenders"] == "defenders") then {
	[area_def, "playArea"] spawn client_fnc_updateLine;
} else {
	[area_atk, "playArea"] spawn client_fnc_updateLine;
};


// Update enemy base marker name
cl_enemySpawnMarker = if (player getVariable "gameSide" == "defenders") then {"mobile_respawn_attackers"} else {"mobile_respawn_defenders"};
