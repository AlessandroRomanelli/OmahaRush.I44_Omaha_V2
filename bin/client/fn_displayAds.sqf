scriptName "fn_displayAds.sqf";
/*--------------------------------------------------------------------
	Author: A. Roman (ofpectag: RMN)
    File: fn_checkClassRestriction.sqf

    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_displayAds.sqf"
if (isServer && !hasInterface) exitWith {};

private _adsArray = getArray(missionConfigFile >> "GeneralConfig" >> "adsMessages");
private _alreadyUsedMessages = [];

// No messages? Nothing for us to do here!
if (count _adsArray isEqualTo 0) exitWith {};

// While the game is ongoing
while {sv_gameStatus == 2} do {
	// If the messages have all been displayed
	if ((count _adsArray) isEqualTo 0) then {
		// Restore the original array
		_adsArray = +_alreadyUsedMessages;
		// Reset the already used messages
		_alreadyUsedMessages = [];
	};

	// Get a random message index
	private _idx = floor (random (count _adsArray));
	// Get the message and create a duple (topText, bottomText)
	private _message = (_adsArray select _idx) splitString "%";

	// Display the Rsc
	14 cutRsc ["rr_bottomTS3", "PLAIN", 1];
	// Get the upper and lower controls
	private _dUp = ((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 1);
	private _dDown = ((uiNamespace getVariable ["rr_bottomTS3", displayNull]) displayCtrl 0);

	// Set the text of the controls to the wanted message
	_dUp ctrlSetStructuredText (parseText (format["<t size='1' color='#FFFFFF' shadow='2' align='center'>%1</t>", _message select 0]));
	_dDown ctrlSetStructuredText (parseText (format["<t size='2' color='#FFFFFF' shadow='2' align='center'>%1</t>", _message select 1]));

	// Push the original message to the alreay used array
	_alreadyUsedMessages pushBack (_adsArray select _idx);

	// Delete the message we just used from the pool of messages
	_adsArray deleteAt _idx;

	// Display for 15s (+1s for fade in)
	uiSleep 16;
	// Fade out 1s and 30s wait
	14 cutFadeout 1;
	uiSleep 31;
};

// We're done displaying ads for this round!
cl_adsDisplay = nil;
