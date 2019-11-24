scriptName "fn_displayKillcam";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_displayKillcam.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayKillcam.sqf"
if (isServer && !hasInterface) exitWith {};

#define MAX_NAME_LEN 18
#include "..\utils.h"

private _fnc_trimString = {
  private _string = param [0, "", [""]];
  private _maxLen = param [1, 0, [0]];
  if (count _string > _maxLen) exitWith {
    (_string select [0,_maxLen])+"..."
  };
  _string
};

private _fnc_getFactionTexture = {
  private _unit = param [0, objNull, [objNull]];
  private _side = ["Attacker", "Defender"] select IS_DEFENDING(_unit);
  private _marker = getText(missionConfigFile >> "Vehicles" >> _side >> "marker");
  private _texture = getText(configFile >> "CfgMarkers" >> _marker >> "texture");
  _texture
};

private _fnc_getIcon = {
	private _unit = param[0,objNull,[objNull]];
  private _class = _unit getVariable ["class","assault"];
  WWRUSH_ROOT+"pictures\" + _class + ".paa"
};

private _killer = param[0,objNull,[objNull]];
private _killerName = _killer getVariable ["name", name _killer];
if (count _killerName > MAX_NAME_LEN) then {
  _killerName = [_killerName, MAX_NAME_LEN] call _fnc_trimString;
};
private _foe_score = _killer getVariable ["killed_by", 1];
private _score = _killer getVariable ["killed", 0];
private _killerWeapon = [_killer getVariable ["weapon", ""]] call client_fnc_weaponDetails;
private _health = _killer getVariable ["health", 1];
private _killerClass = _killer getVariable ["class", "assault"];

401 cutRsc ["killcam_info", "PLAIN", 0.5];

private _display = uiNamespace getVariable ["killcam_info", displayNull];
(_display displayCtrl 1100) ctrlSetStructuredText parseText(
  format["<t size='1.25' shadow=2 font='PuristaBold' valign='middle'>%1</t>", toUpper(_killerName)]);
(_display displayCtrl 1102) ctrlSetStructuredText parseText(
  format["<t size='3' shadow=2 font='PuristaBold' align='center' valign='middle'>%1</t>", ceil(_health * 100)]);
(_display displayCtrl 1103) ctrlSetStructuredText parseText(
  format["<t size='1.25' shadow=2 font='PuristaMedium' align='center' valign='middle'>%1</t>", toUpper([_killerWeapon select 1, MAX_NAME_LEN] call _fnc_trimString)]);
(_display displayCtrl 1104) ctrlSetStructuredText parseText(
  format["<t size='1.25' shadow=2 font='PuristaMedium' align='center' valign='middle'>%1</t>", toUpper(_killerClass)]);
(_display displayCtrl 1105) ctrlSetStructuredText parseText(
  format["<t size='1.5' shadow=2 font='PuristaBold' align='right' valign='middle'>%1</t>", _score]);
(_display displayCtrl 1106) ctrlSetStructuredText parseText(
  format["<t size='1.5' shadow=2 font='PuristaBold' align='left' valign='middle'>%1</t>", _foe_score]);
(_display displayCtrl 1200) ctrlSetText ([_killer] call _fnc_getFactionTexture);
(_display displayCtrl 1201) ctrlSetText (_killerWeapon select 2);
(_display displayCtrl 1202) ctrlSetText ([_killer] call _fnc_getIcon);

waitUntil { cl_inSpawnMenu || {player getVariable ["isAlive", false]}};

401 cutFadeOut 0;
