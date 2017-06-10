scriptName "fn_startIngameGUI";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_startIngameGUI.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_startIngameGUI.sqf"
if (isServer && !hasInterface) exitWith {};

disableSerialization;

// Start the ingame gui
300 cutRsc ["playerHUD","PLAIN"];
disableSerialization;

if (isNil "rr_spawn_bottom_right_hud_ran") then {
	rr_spawn_bottom_right_hud_ran = true;
	//["rr_spawn_bottom_right_hud_renderer", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	//["rr_spawn_bottom_right_hud_renderer", "onEachFrame", {
	/*onEachFrame {
		disableSerialization;
		_hud = uiNameSpace getVariable ["playerHUD",displayNull];
		_HUD_currentAmmo = _hud displayCtrl 100;
		_HUD_reserveAmmo = _hud displayCtrl 101;
		_HUD_firemode = _hud displayCtrl 102;
		_HUD_healthPlus = _hud displayCtrl 103;
		_HUD_healthPoints = _hud displayCtrl 104;
		_HUD_grenades = _hud displayCtrl 105;
		_HUD_slashBetweenAmmo = _hud displayCtrl 106;

		_currentAmmo = 0;
		_reserveAmmo = 0;
		_grenades    = 0;
		_fireMode = "";

		_mode = currentWeaponMode gunner vehicle player;
		if (typeName _mode == "STRING") then {
			if (_mode == "Single") then {_fireMode = "SNGL"};
			if (_mode in ["Burst","Burst2rnd"]) then {_fireMode = "BRST"};
			if (_mode == "FullAuto" OR _mode == "manual") then {_fireMode = "AUTO"};
		} else {_fireMode = "---"};

		if (vehicle player == player || ((driver vehicle player != player) && (gunner vehicle player != player) && (commander vehicle player != player))) then {
			{
				if ((_x select 0) == (currentMagazine player) AND (_x select 2)) then
				{
					_currentAmmo = (_x select 1);
				};
				if ((_x select 0) == (currentMagazine player) AND !(_x select 2)) then
				{
					_reserveAmmo = _reserveAmmo + (_x select 1);
				};
				if ((_x select 0) == "HandGrenade") then
				{
					_grenades = _grenades + 1;
				};
			} forEach (magazinesAmmoFull player);
		} else {
			if (driver (vehicle player) == player) then {
				_currentAmmo = (vehicle player) ammo (currentWeapon (vehicle player));
				_reserveAmmo = 0;
			} else {
				//if (gunner (vehicle player) == player) then {
					//_currentAmmo = (vehicle player) ammo (currentWeapon (vehicle player));
					//_reserveAmmo = 0;
				//};
				_currentAmmo = 0; // TODO
				_reserveAmmo = 0;
			};
		};

		_size = if (_currentAmmo < 1000) then {3.8} else {2.7};

		_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
		_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
		_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
		_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
		_HUD_grenades     ctrlSetText format ["%1m", currentZeroing player];
	};*/
	//}] call BIS_fnc_addStackedEventHandler;
};