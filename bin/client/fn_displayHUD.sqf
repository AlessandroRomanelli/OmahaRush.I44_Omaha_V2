// MERGE OF INGAME GUI
private _hud = uiNameSpace getVariable ["playerHUD",displayNull];
private _HUD_currentAmmo = _hud displayCtrl 100;
private _HUD_reserveAmmo = _hud displayCtrl 101;
private _HUD_firemode = _hud displayCtrl 102;
private _HUD_healthPoints = _hud displayCtrl 104;
private _HUD_zeroing = _hud displayCtrl 105;
private _HUD_grenades = _hud displayCtrl 107;
private _HUD_typeGrenade = _hud displayCtrl 108;
private _HUD_weaponName = _hud displayCtrl 1100;

private _groupUnits = units (group player);

private _getHUDTextColor = {
  private _unit = param [0, objNull, [objNull]];
  if (_unit getVariable ["inCombat", false]) exitWith {
    ["#ffcc99", "#66513d"]
  };
  if (_unit getVariable ["isAlive", true]) exitWith {
    ["#aaffaa", "#446644"]
  };
  ["#ffaaaa", "#664444"]
};

private _getHUDArrayColor = {
  private _unit = param [0, objNull, [objNull]];
  if (_unit getVariable ["inCombat", false]) exitWith {
    [[1, 0.8, 0.6, 1], [0.4, 0.32, 0.24]]
  };
  if (_unit getVariable ["isAlive", true]) exitWith {
    [[0.66, 1, 0.66, 1], [0.26, 0.4, 0.26, 1]]
  };
  [[1, 0.66, 0.66, 1], [0.4, 0.26, 0.26, 1]]
};

private _getTeamIcon = {
  private _unit = param [0, objNull, [objNull]];
  private _perkIdx = _unit getVariable ["squadPerk", -1];
  if (_perkIdx isEqualTo -1) exitWith {"pictures\noperk.paa"};
  private _availableSquadPerks = (missionConfigFile >> "CfgPerks" >> "SquadPerks") call bis_fnc_getCfgSubClasses;
  private _squadPerk = _availableSquadPerks select _perkIdx;
  private _icon = "pictures\"+_squadPerk+".paa";
  _icon
};

for "_i" from 0 to 4 do {
  private _teamMateName = _hud displayCtrl (2100 + _i);
  private _teamMateIcon = _hud displayCtrl (2200 + _i);
  private _teamMateLeader = _hud displayCtrl (2300 + _i);
  if (_i < count _groupUnits) then {
    private _unit = _groupUnits select _i;
    private _colors = [_unit] call _getHUDTextColor;
    private _name = _unit getVariable["name", "ERROR: No Name"];
    _teamMateName ctrlSetStructuredText parseText (format ["<t size='1.15' shadow='1' shadowColor='%1' color='%2' font='PuristaLight' align='right'>%3</t>", _colors select 1, _colors select 0, _name]);
    private _arrayColors = [_unit] call _getHUDArrayColor;
    _teamMateIcon ctrlSetText ([_unit] call _getTeamIcon);
    _teamMateIcon ctrlSetTextColor (_arrayColors select 0);
    if (_unit isEqualTo (leader (group player))) then {
      _teamMateLeader ctrlSetTextColor (_arrayColors select 0);
    } else {
      _teamMateLeader ctrlSetTextColor [0,0,0,0];
    }
  } else {
    _teamMateName ctrlSetStructuredText parseText "";
    _teamMateIcon ctrlSetText "pictures\noperk.paa";
    _teamMateIcon ctrlSetTextColor [0,0,0,0.25];
    _teamMateLeader ctrlSetTextColor [0,0,0,0];
  };
};

private _currentAmmo = 0;
private _reserveAmmo = 0;
private _grenades    = 0;
private _fireMode = "";

private _mode = currentWeaponMode (gunner (vehicle player));
if (_mode isEqualType "STRING") then {
  if (_mode == "Single") then {_fireMode = "SNGL"};
  if (_mode in ["Burst","Burst2rnd"]) then {_fireMode = "BRST"};
  if (_mode == "FullAuto" OR _mode == "manual") then {_fireMode = "AUTO"};
} else {_fireMode = "---"};

if ((isNull objectParent player) || {(assignedVehicleRole player select 0) isEqualTo "cargo"}) then {
  {
    if ((_x select 0) == (currentMagazine player) AND (_x select 2)) then
    {
      _currentAmmo = (_x select 1);
    };
    if ((_x select 0) == (currentMagazine player) AND !(_x select 2)) then
    {
      _reserveAmmo = _reserveAmmo + (_x select 1);
    };
    if ((_x select 0) isEqualTo ((currentThrowable player) select 0)) then
    {
      _grenades = _grenades + 1;
    };
  } forEach (magazinesAmmoFull player);
} else {
  if (driver (vehicle player) == player && {!((vehicle player) isKindOf "Air")}) then {
    _currentAmmo = format ["%1", abs (floor (speed (vehicle player)))];
    _reserveAmmo = format ["%1°", floor getDir (vehicle player)];
    _fireMode = "KM/H";
  } else {
    _currentAmmo = (vehicle player) ammo (currentWeapon (vehicle player));
    _reserveAmmo = [] call {
      private _ammoLeft = 0 - ((vehicle player) ammo (currentWeapon (vehicle player)));
      {if ((_x select 0) isEqualto (currentMagazine (vehicle player))) then {_ammoLeft = _ammoLeft + (_x select 1)}} forEach magazinesAmmo (vehicle player);
      _ammoLeft
    };
  };
};

private _grenadeIcon = if (toLower ((currentThrowable player) select 0) in ["lib_us_mk_2", "lib_shg24", "lib_rg42"]) then {"pictures\grenade.paa"} else {"pictures\smoke.paa"};
if ((currentThrowable player) isEqualto []) then {_grenadeIcon = "";};

if (_grenades isEqualTo 0) then {_grenades = ""};

private _weaponName = getText(configFile >> "cfgWeapons" >> currentWeapon (vehicle player) >> "displayName");

_HUD_currentAmmo  ctrlSetText format ["%1",_currentAmmo];
_HUD_reserveAmmo  ctrlSetText format ["%1",_reserveAmmo];
_HUD_firemode     ctrlSetStructuredText parseText format ["<t align='left' size='1'>[</t><t align='center' size='1'>%1</t><t align='right' size='1'>]</t>",_fireMode];
_HUD_healthPoints ctrlSetText format ["%1",floor((1-(damage player))*100)];
_HUD_zeroing  		ctrlSetText format ["%1m", currentZeroing player];
_HUD_typeGrenade	ctrlSetText _grenadeIcon;
_HUD_grenades			ctrlSetText format ["%1", _grenades];
_HUD_weaponName		ctrlSetText _weaponName;
