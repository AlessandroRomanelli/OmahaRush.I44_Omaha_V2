scriptName "fn_initClass";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_initClass.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initClass.sqf"
if (isServer && !hasInterface) exitWith {};

_class = cl_equipClassnames select 2;

// Just a missionnamespace var for faster access
cl_class = _class;

// Broadcast class to all clients
player setVariable ["class", cl_class, true];

// Spawn beacon code
rc_spawnBeacon = {
	if (isNull (player getVariable ["recon_beacon_obj",objNull]) || (diag_tickTime - ((player getVariable ["recon_beacon_obj",objNull]) getVariable ["deployment_tick", 0])) > 180) then {
		if (({!isNull (_x getVariable ["recon_beacon_obj", objNull])} count (units group player)) < 1) then {
			if (player distance sv_cur_obj < 75 || (player distance (getMarkerPos cl_enemySpawnMarker)) < 100) then {
				["Your spawnbeacon may not be placed here"] spawn client_fnc_displayError;
			} else {
				_existingBeacon = (player getVariable ["recon_beacon_obj",objNull]);

				// Delete existing beacon
				if (!isNull _existingBeacon) then {
					deleteVehicle _existingBeacon;
				};

				// Create beacon :>
				_pos = player modelToWorld [0,0,0];
				_beacon = createVehicle ["Vysilacka", position player, [], 0, "CAN_COLLIDE"];
				_beacon setPosATL _pos;
				_beacon enableSimulation false;
				_beacon setDir (direction player);

				// Vars
				player setVariable ["recon_beacon_obj", _beacon, true];
				_beacon setVariable ["deployment_tick", diag_tickTime];
				_beacon setVariable ["owner", player, true];

				// Global sound queue
				[_beacon] remoteExec ["client_fnc_spawnBeaconSoundLoop"];

				// Message
				["BEACON DEPLOYED", "Your spawn beacon has been deployed. Squad members can now spawn at it. It will get destroyed upon receiving damage."] spawn client_fnc_hint;

				// Reset counter
				cl_beacon_used = 0;

				// Give beacon damage handler
				[_beacon] remoteExec ["client_fnc_beaconEventHandler", 0];
			};
		} else {
			["Your squad already has a spawn beacon placed down"] spawn client_fnc_displayError;
		};
	} else {
		//["Destroy your old beacon or wait " + (diag_tickTime - ((player getVariable ["recon_beacon_obj",objNull]) getVariable ["deployment_tick", 0])) + " more seconds to deploy a new beacon"] spawn client_fnc_displayError;
		[format["Destroy your old beacon or wait %1 more seconds to deploy a new beacon", round (180 - (diag_tickTime - ((player getVariable ["recon_beacon_obj",objNull]) getVariable ["deployment_tick", 0])))]] spawn client_fnc_displayError;
	};
};


// Recon // Allow others to destroy other beacons
(findDisplay 46) displayRemoveEventHandler ["KeyDown",player getVariable ["recon_beacon_keyhandler_id", -1]];
if (true) then {
	// Add action to deploy a spawn beacon
	_id = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_keyCode = _this select 1;
		_h = false;

		if (_keyCode == 35 && (alive player)) then {
			_myClass = player getVariable ["class",""];

			if (cursorObject isKindOf "Land_Laptop_device_F" && player distance cursorObject < 2) then {

				// Our teams beacon
				if ((([cursorObject] call client_fnc_getBeaconOwner) getVariable ["side", sideUnknown]) == playerSide || cursorObject == (player getVariable ["recon_beacon_obj", objNull])) then {
					if (([cursorObject] call client_fnc_getBeaconOwner) == player) then {
						// Were the owner, destroy it!
						deleteVehicle cursorObject;
						["You have removed your beacon"] spawn client_fnc_displayInfo;
					} else {
						// Were not the owner and its on our team, error!
						["This spawn beacon is owned by a team member"] spawn client_fnc_displayError;
						diag_log "5";
					};
				} else {
					// not on our team, destroy it!
					deleteVehicle cursorObject;
					// Points!
					["<t size='1.3' color='#FFFFFF'>SPAWN BEACON DESTROYED</t>", 15] spawn client_fnc_pointfeed_add;
					[15] spawn client_fnc_addPoints;
				};
			} else {
				// check if were recon and we have the spawnbeacon perk, then place beacon
				if (cl_class == "recon") then {
					if (cl_classPerk == "spawnbeacon") then {
						if (vehicle player == player) then {
							[] spawn rc_spawnBeacon;
						};
					};
				};
			};

			_h = true;
		};
		_h
	}];
	player setVariable ["recon_beacon_keyhandler_id", _id];
};
