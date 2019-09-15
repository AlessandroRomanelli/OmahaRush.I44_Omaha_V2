scriptName "fn_getUnitIcon";
/*--------------------------------------------------------------------
	Author: A. Roman
    File: fn_getUnitIcon.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_getUnitIcon.sqf"

if (isServer && !hasInterface) exitWith {};

private _unit = param [0, objNull, [objNull]];
private _class = _unit getVariable ["class", ""];

if (isNull (objectParent _unit)) exitWith {
  if (_unit isEqualTo (leader group _unit)) exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManCommander_ca.paa"};
  if (_class isEqualTo "medic") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManMedic_ca.paa"};
  if (_class isEqualTo "assault") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManLeader_ca.paa"};
  if (_class isEqualTo "engineer") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManEngineer_ca.paa"};
  if (_class isEqualTo "support") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManMG_ca.paa"};
  if (_class isEqualTo "recon") exitWith {"\a3\ui_f\data\Map\VehicleIcons\iconManLeader_ca.paa"};
  "\a3\ui_f\data\Map\VehicleIcons\iconMan_ca.paa"
};

getText(configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "Icon")
