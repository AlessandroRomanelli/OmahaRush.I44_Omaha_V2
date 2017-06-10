scriptName "fn_pointfeed_add";
/*--------------------------------------------------------------------
	Author: Maverick (ofpectag: MAV)
    File: fn_pointfeed_add.sqf

	<Maverick Applications>
    Written by Maverick Applications (www.maverick-apps.de)
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_pointfeed_add.sqf"
if (isServer && !hasInterface) exitWith {};

_toAdd = param[0,"",[""]];
_points = param[1,0,[0]];

if (_toAdd == "") exitWith {};

// Add points to total feed
cl_pointfeed_points = cl_pointfeed_points + _points;

// Insert into feed
cl_pointfeed_text = _toAdd + "<br/>" + cl_pointfeed_text;

_finalText = "<t align='right' size='1.4' shadow='2' font='PuristaMedium' color='#FFFFFF'>" + cl_pointfeed_text + "</t>";

// Display everything
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetPosition [0.29375 * safezoneW + safezoneX, 0.715 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetPosition [0.654688 * safezoneW + safezoneX, 0.709 * safezoneH + safezoneY];
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetFade 0;
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetFade 0;
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlCommit 0;
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlCommit 0;

// Display
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetStructuredText parseText _finalText;
((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetStructuredText parseText format["<t align='left' size='1.65' shadow='2' font='PuristaBold' color='#FFFFFF'>%1</t>", round cl_pointfeed_points];

if (!isNil "cl_pointfeed_removalThread") then {
	terminate cl_pointfeed_removalThread;
};

// Play sound
playSound "kill";

cl_pointfeed_removalThread = [] spawn {
	sleep 8;
	cl_pointfeed_text = ""; // Reset own pointfeeds
	cl_pointfeed_points = 0;

	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetPosition [0.29375 * safezoneW + safezoneX, 1];
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetPosition [0.654688 * safezoneW + safezoneX, 1];
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetFade 1;
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetFade 1;
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlCommit 0.6;
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlCommit 0.6;

	sleep 1;

	// Clear display
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 0) ctrlSetStructuredText parseText "";
	((uiNamespace getVariable ["rr_pointfeed",displayNull]) displayCtrl 1) ctrlSetStructuredText parseText "";
};