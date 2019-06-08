#define BG_COLOR {0.12,0.14,0.16,0.8}
#define TEAM_COLOR {0.18,0.51,0.95, 1}
#define ENEMY_COLOR {0.4,0,0,1}
#define ACCENT_COLOR {0.96,0.65,0.12,0.8}

class default
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0;

	class controlsBackground {};

	class controls
	{};
};

class rr_spawn
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=1;
	fadein=0;
	duration = 1;

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = -1;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_black
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999;
	onLoad = "uiNamespace setVariable ['rr_black',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = 0;
			x = 1 * safezoneW + safezoneX;
			y = 1 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_timer
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=2;
	duration = 9999999;
	onLoad = "uiNamespace setVariable ['rr_timer',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.088 * safezoneH;
		};

		/* SCOREBOARD */
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.247962 * safezoneW + safezoneX;
			y = 0.34534 * safezoneH + safezoneY;
			w = 0.499125 * safezoneW;
			h = 0.462 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscStructuredText_1001: RscStructuredText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = TEAM_COLOR;
		};
		class RscStructuredText_1002: RscStructuredText
		{
			idc = 1002;
			text = ""; //--- ToDo: Localize;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4,0,0,1};
		};
		class RscText_10023: RscText
		{
			idc = -1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = BG_COLOR;
			shadow = 2;
		};
		class RscText_10024: RscText
		{
			idc = -1;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = BG_COLOR;
			shadow = 2;
		};
		class RscText_1003: RscListNBox
		{
			idc = 1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = TEAM_COLOR;
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
		class RscText_1004: RscListNBox
		{
			idc = 2;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = ACCENT_COLOR;
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
	};
};

class rr_scoreboard
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 9999999;
	onLoad = "uiNamespace setVariable ['rr_scoreboard',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			text = "";
			size = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.245 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "center";
				valign = "middle";
			};
		};

		/* SCOREBOARD */
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.247962 * safezoneW + safezoneX;
			y = 0.34534 * safezoneH + safezoneY;
			w = 0.499125 * safezoneW;
			h = 0.462 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscStructuredText_1001: RscStructuredText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = TEAM_COLOR;
		};
		class RscStructuredText_1002: RscStructuredText
		{
			idc = 1002;
			text = ""; //--- ToDo: Localize;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.249562 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.4,0,0,1};
		};
		class RscText_10023: RscText
		{
			idc = -1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = BG_COLOR;
			shadow = 2;
		};
		class RscText_10024: RscText
		{
			idc = -1;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;
			colorBackground[] = BG_COLOR;
			shadow = 2;
		};
		class RscText_1003: RscListNBox
		{
			idc = 1;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = TEAM_COLOR;
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
		class RscText_1004: RscListNBox
		{
			idc = 2;
			x = 0.497938 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.249563 * safezoneW;
			h = 0.4378 * safezoneH;

			colorBackground[] = ACCENT_COLOR;
			columns[] = {0.001, 0.06, 0.6, 0.7, 0.8};
			color[] = {1, 1, 1, 1};
			colorScrollbar[] = {0.95, 0.95, 0.95, 1};
			colorSelect[] = {0.95, 0.95, 0.95, 1};
			colorSelect2[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground[] = {0, 0, 0, 1};
			colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			maxHistoryDelay = 1;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
			soundSelect[] = {"", 0.1, 1};
			period = 1;
		};
	};
};

class rr_restrictedArea
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.1;
	onLoad = "uiNamespace setVariable ['rr_restrictedArea',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.298905 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {1,0,0,0.1};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {1,0,0,0.15};
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "<t size='3.5' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>TURN BACK</t><br/><t size='2' color='#FFFFFF' shadow='2' align='center'>YOU ARE LEAVING THE BATTLEFIELD</t>"; //--- ToDo: Localize;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
		class timer: RscStructuredText
		{
			idc = 1101;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			colorActive[] = {-1,-1,-1,0};
		};
	};
};

class rr_restrictedAreaSpawn
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.1;
	onLoad = "uiNamespace setVariable ['rr_restrictedAreaSpawn',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.298905 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {1,0,0,0.3};
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.308 * safezoneH;
			colorBackground[] = {1,0,0,0.3};
		};
		class text: RscStructuredText
		{
			idc = 0;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.381563 * safezoneW;
			h = 0.286 * safezoneH;
			text = "<br/><t size='2' color='#FFFFFF' shadow='2' align='center' font='PuristaBold'>ENEMY HQ NEARBY</t><br/><t size='1.3' color='#FFFFFF' shadow='2' align='center'>LEAVE NOW OR YOU WILL BE KILLED</t>";
		};
	};
};

class rr_keyBindingHint
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.5;
	fadein=0;
	duration = 5;
	onLoad = "uiNamespace setVariable ['rr_keyBindingHint',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "PRESS X TO DEPLOY COUNTERMEASURES"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

class rr_keyBindingHintPermanent
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_keyBindingHintPermanent',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class text: RscStructuredText
		{
			idc = 0;
			text = "PRESS X TO DEPLOY COUNTERMEASURES"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};

class rr_topRightWarning
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_topRightWarning',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.645406 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};

class rr_bottomTS3
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.5;
	fadein=1;
	duration = 999999999999;
	onLoad = "uiNamespace setVariable ['rr_bottomTS3',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class bottom_line: RscStructuredText
		{
			idc = 0;
			text = ""; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class top_line: RscStructuredText
		{
			idc = 1;
			text = ""; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class rr_spawnPlayer
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.3;
	duration = 0.3;

	class controlsBackground {};

	class controls
	{
		class blackbackground: RscText
		{
			idc = -1;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,2};
		};
	};
};

class rr_weaponUnlockSingle
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.3;
	fadein=0.3;
	duration = 5;
	onLoad = "uiNamespace setVariable ['rr_weaponUnlockSingle',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.190625 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.613594 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1;
			x = 0.195781 * safezoneW + safezoneX;
			y = 0.153 * safezoneH + safezoneY;
			w = 0.608437 * safezoneW;
			h = 0.5 * safezoneH;
		};
	};
};

class rr_errorText
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.2;
	fadein=0.2;
	duration = 4;
	onLoad = "uiNamespace setVariable ['errorText',_this select 0];";

	class controlsBackground {};

	class controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = 0.200937 * safezoneW + safezoneX;
			y = 0.363 * safezoneH + safezoneY;
			w = 0.598125 * safezoneW;
			h = 0.077 * safezoneH;
		};
	};
};

class rr_pointfeed
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999999999999999;
	onLoad = "uiNamespace setVariable ['rr_pointfeed',_this select 0];";

	class controlsBackground {};

	class controls {
		class mainfeed: RscStructuredText
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.715 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.275 * safezoneH;
		};
		class totalpoints: RscStructuredText
		{
			idc = 1;
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};

class rr_objectivemessage
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 6;
	onLoad = "uiNamespace setVariable ['rr_objectivemessage',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 0;
			x = -0.00017268 * safezoneW + safezoneX;
			y = 0.0931436 * safezoneH + safezoneY;
			w = 1.00035 * safezoneW;
			h = 0.186934 * safezoneH;
		};
	};
};

class rr_hint
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.1;
	fadein=0.1;
	duration = 10;
	onLoad = "uiNamespace setVariable ['rr_hint',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = 0;
			x = 0.804219 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.143 * safezoneH;
			colorText[] = {1,1,1,0.8};
			colorBackground[] = BG_COLOR;
		};
		class RscText_1001: RscStructuredText
		{
			idc = 1;
			text = "ATTACKER"; //--- ToDo: Localize;
			x = 0.809375 * safezoneW + safezoneX;
			y = 0.3306 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 2;
			text = "Attack and capture the objectives before your team runs out of tickets. Each death costs your team a ticket. Reviving restores a ticket."; //--- ToDo: Localize;
			x = 0.809375 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
	};
};


class rr_objective_gui
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=2;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_objective_gui',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.391718 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class image: RscPictureKeepAspect
		{
			idc = 0;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\objective_attacker.paa";
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.037125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class RscText_1002: RscProgress
		{
			idc = 2;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
		class time: RscStructuredText
		{
			idc = 4;
			text = "∞"; //--- ToDo: Localize;
			x = 0.391718 * safezoneW + safezoneX;
			y = 0.0255 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.0264 * safezoneH;
		};
		class tickets: RscStructuredText
		{
			idc = 1;
			text = "150"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.0255 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.0264 * safezoneH;
		};

		/* now also holds the killfeed */
		class RscStructuredText_Killfeed: RscStructuredText
		{
			idc = 10;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.366094 * safezoneW;
			h = 0.22 * safezoneH;
		};
	};
};


class rr_end_bestof
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_end_bestof',_this select 0];";

	class controlsBackground {};

	class controls {
		class a: RscStructuredText
		{
			idc = 0;
			x = -1 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 1.00547 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class b: RscStructuredText
		{
			idc = 1;
			x = -1 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 1.00031 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class c: RscStructuredText
		{
			idc = 2;
			x = -1 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 1.00031 * safezoneW;
			h = 0.462 * safezoneH;
		};
	};
};

class rr_reloadingFlares {
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.3;
	fadein=0;
	duration = 999999999999999;
	onLoad = "uiNamespace setVariable ['rr_reloadingFlares',_this select 0];";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.011 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class RscText_1001: RscProgress
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.011 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
	};
};



class playerHUD {
	idd = 5100;
	name= "playerHUD";
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 86400;
	onLoad="uiNamespace setVariable ['playerHUD',_this select 0]";

	class controlsBackground {};

	class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.863 * safezoneW + safezoneX;
			y = 0.896 * safezoneH + safezoneY;
			w = 0.135093 * safezoneW;
			h = 0.1012 * safezoneH;
			colorBackground[] = BG_COLOR;
			shadow = 2;
		};
		class currentAmmo: RscText
		{
			idc = 100;
			text = "000"; //--- ToDo: Localize;
			x = 0.865064 * safezoneW + safezoneX;
			y = 0.894 * safezoneH + safezoneY;
			w = 0.0711564 * safezoneW;
			h = 0.055 * safezoneH;
			//sizeEx = 3.8 * GUI_GRID_H;
			sizeEx = "(1.75*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class reserveAmmo: RscText
		{
			idc = 101;
			text = "000"; //--- ToDo: Localize;
			x = 0.952714 * safezoneW + safezoneX;
			y = 0.8982 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 1.9 * GUI_GRID_H;
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class RscText_1002: RscText
		{
			idc = 106;
			text = "/"; //--- ToDo: Localize;
			x = 0.940341 * safezoneW + safezoneX;
			y = 0.8982 * safezoneH + safezoneY;
			w = 0.0113438 * safezoneW;
			h = 0.0374 * safezoneH;
			//sizeEx = 1.5 * GUI_GRID_H;
			sizeEx = "(0.75*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class firemode: RscStructuredText
		{
			idc = 102;
			text = "[  AUTO  ]"; //--- ToDo: Localize;
			x = 0.93969 * safezoneW + safezoneX;
			y = 0.934852 * safezoneH + safezoneY;
			w = 0.0495002 * safezoneW;
			h = 0.0185 * safezoneH;
			//sizeEx = 1 * GUI_GRID_H;
			//sizeEx = /*safezoNeW/*/(1*0.04);
			shadow = 2;
		};
		class RscText_1004: RscText
		{
			idc = 103;
			text = "+"; //--- ToDo: Localize;
			x = 0.936218 * safezoneW + safezoneX;
			y = 0.9525 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 3 * GUI_GRID_H;
			font = "PuristaBold";
			sizeEx = "(1.5*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class healthpoints: RscText
		{
			idc = 104;
			text = "000"; //--- ToDo: Localize;
			x = 0.952719 * safezoneW + safezoneX;
			y = 0.955 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0352 * safezoneH;
			//sizeEx = 1.9 * GUI_GRID_H;
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class zeroing: RscText
		{
			idc = 105;
			text = "Gx01"; //--- ToDo: Localize;
			x = 0.86714 * safezoneW + safezoneX;
			y = 0.955 * safezoneH + safezoneY;
			w = 0.0615625 * safezoneW;
			h = 0.0352 * safezoneH;
			//sizeEx = 1.9 * GUI_GRID_H;
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class typeGranade: RscPictureKeepAspect
		{
			text = "";
			idc = 108;
			x = 0.83 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class granades: RscText
		{
			idc = 107;
			text = "0"; //--- ToDo: Localize;
			x = 0.823282 * safezoneW + safezoneX;
			y = 0.946593 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.055 * safezoneH;
			/* sizeEx = 2 * GUI_GRID_H; */
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
			shadow = 2;
		};
		class RscText_1100: RscText
		{
		  idc = 1100;
		  text = ""; //--- ToDo: Localize;
		  x = 0.86575 * safezoneW + safezoneX;
		  y = 0.8704 * safezoneH + safezoneY;
		  w = 0.130208 * safezoneW;
		  h = 0.0224076 * safezoneH;
		  colorBackground[] = {-1,-1,-1,0};
			shadow = 2;
			font = "PuristaBold";
			align = "right";
		};

		class teammate_1: RscStructuredText
		{
			idc = 2100;
			text = ""; //--- ToDo: Localize;
			x = 0.861382 * safezoneW + safezoneX;
			y = 0.838541 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1, 0};
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
		};
		class teammate_2: RscStructuredText
		{
			idc = 2101;
			text = ""; //--- ToDo: Localize;
			x = 0.861382 * safezoneW + safezoneX;
			y = 0.800926 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
		};
		class teammate_3: RscStructuredText
		{
			idc = 2102;
			text = ""; //--- ToDo: Localize;
			x = 0.861382 * safezoneW + safezoneX;
			y = 0.76331 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
		};
		class teammate_4: RscStructuredText
		{
			idc = 2103;
			text = ""; //--- ToDo: Localize;
			x = 0.861382 * safezoneW + safezoneX;
			y = 0.725694 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
		};
		class teammate_5: RscStructuredText
		{
			idc = 2104;
			text = ""; //--- ToDo: Localize;
			x = 0.861382 * safezoneW + safezoneX;
			y = 0.688079 * safezoneH + safezoneY;
			w = 0.114584 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "(0.95*(pixelH * pixelGridNoUIScale * 2.9))";
		};
		class teammate_1_perk: RscPictureKeepAspect
		{
			idc = 2200;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\assault.paa";
			x = 0.971294 * safezoneW + safezoneX;
			y = 0.828009 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
			colorText[] = {0.66, 1, 0.66, 1};
		};
		class teammate_2_perk: RscPictureKeepAspect
		{
			idc = 2201;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\assault.paa";
			x = 0.971559 * safezoneW + safezoneX;
			y = 0.791522 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
			colorText[] = {0.66, 1, 0.66, 1};
		};
		class teammate_3_perk: RscPictureKeepAspect
		{
			idc = 2202;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\assault.paa";
			x = 0.971559 * safezoneW + safezoneX;
			y = 0.753906 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
			colorText[] = {0.66, 1, 0.66, 1};
		};
		class teammate_4_perk: RscPictureKeepAspect
		{
			idc = 2203;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\assault.paa";
			x = 0.971559 * safezoneW + safezoneX;
			y = 0.71629 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
			colorText[] = {0.66, 1, 0.66, 1};
		};
		class teammate_5_perk: RscPictureKeepAspect
		{
			idc = 2204;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\assault.paa";
			x = 0.971559 * safezoneW + safezoneX;
			y = 0.678675 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
			colorText[] = {0.66, 1, 0.66, 1};
		};
		class teammate_1_lead: RscPictureKeepAspect
		{
			idc = 2300;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\star.paa";
			x = 0.856974 * safezoneW + safezoneX;
			y = 0.829137 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
		};
		class teammate_2_lead: RscPictureKeepAspect
		{
			idc = 2301;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\star.paa";
			x = 0.856974 * safezoneW + safezoneX;
			y = 0.791522 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
		};
		class teammate_3_lead: RscPictureKeepAspect
		{
			idc = 2302;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\star.paa";
			x = 0.856974 * safezoneW + safezoneX;
			y = 0.753906 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
		};
		class teammate_4_lead: RscPictureKeepAspect
		{
			idc = 2303;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\star.paa";
			x = 0.856974 * safezoneW + safezoneX;
			y = 0.71629 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
		};
		class teammate_5_lead: RscPictureKeepAspect
		{
			idc = 2304;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\star.paa";
			x = 0.856974 * safezoneW + safezoneX;
			y = 0.678675 * safezoneH + safezoneY;
			w = 0.0264426 * safezoneW;
			h = 0.0470196 * safezoneH;
		};
		class MinimapBackground: RscText
		{
			idc = 1799;
			x = 0.863144 * safezoneW + safezoneX;
			y = 0.00347277 * safezoneH + safezoneY;
			w = 0.135093 * safezoneW;
			h = 0.206886 * safezoneH;
			colorBackground[] = BG_COLOR;
		};
		class Minimap: RscMapControl
		{
			idc = 1800;
			x = 0.863145 * safezoneW + safezoneX;
			y = 0.00347277 * safezoneH + safezoneY;
			w = 0.135093 * safezoneW;
			h = 0.206886 * safezoneH;
      font = "RobotoCondensed";
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 0.75)";
			sizeExLabel = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
			sizeExUnits = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
			sizeExNames = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
			sizeExInfo = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
			sizeExLevel = "1.00 *     (pixelH * pixelGridNoUIScale * 1.4)";
			colorCountlines[] = {0,0,0,0};
			colorMainCountlines[] = {0,0,0,0};
			colorCountlinesWater[] = {0,0,0,0};
			colorMainCountlinesWater[] = {0,0,0,0};
			colorGrid[] = {0,0,0,0};
			colorGridMap[] = {0,0,0,0};
			widthRailWay = 1;
		};
		class Direction: RscStructuredText
		{
			idc = 1801;
			text = ""; //--- ToDo: Localize;
			x = 0.864907 * safezoneW + safezoneX;
			y = 0.214121 * safezoneH + safezoneY;
			w = 0.131332 * safezoneW;
			h = 0.0282118 * safezoneH;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.8)";
			class Attributes {
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "center";
				valign = "middle";
			};
		};
	};
};

// HIT DIRECTION INDICATORS
class cu
{
	idd = -1;
	name= "cu";
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.5;
	onLoad="uiNamespace setVariable ['cu',_this select 0]";

	class controlsBackground {};

	class controls {
		class RscText211000: RscPicture
		{
			idc = 1101;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\cu.paa"; //--- ToDo: Localize;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
	};
};

class cr
{
	idd = -1;
	name= "cr";
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.5;
	onLoad="uiNamespace setVariable ['cr',_this select 0]";

	class controlsBackground {};

	class controls {
		class RscText211000: RscPicture
		{
			idc = 1101;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\cr.paa"; //--- ToDo: Localize;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
	};
};

class cl
{
	idd = -1;
	name= "cl";
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.5;
	onLoad="uiNamespace setVariable ['cl',_this select 0]";

	class controlsBackground {};

	class controls {
		class RscText211000: RscPicture
		{
			idc = 1101;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\cl.paa"; //--- ToDo: Localize;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
	};
};

class cd
{
	idd = -1;
	name= "cd";
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.5;
	onLoad="uiNamespace setVariable ['cd',_this select 0]";

	class controlsBackground {};

	class controls {
		class RscText211000: RscPicture
		{
			idc = 1101;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\cd.paa"; //--- ToDo: Localize;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
	};
};

class hm_kill
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=0;
	duration = 0.3;

	class controlsBackground {};

	class controls {

		class RscText2131000: RscPicture
		{
			idc = -1;
			x = 0.455656 * safezoneW + safezoneX;
			y = 0.422 * safezoneH + safezoneY;
			w = 0.0886877 * safezoneW;
			h = 0.154 * safezoneH;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\hm_kill.paa";
		};
	};
};

class hm_headshot
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.0;
	fadein=0;
	duration = 0.3;

	class controlsBackground {};

	class controls {

		class RscText2131000: RscPicture
		{
			idc = -1;
			x = 0.455656 * safezoneW + safezoneX;
			y = 0.422 * safezoneH + safezoneY;
			w = 0.0886877 * safezoneW;
			h = 0.154 * safezoneH;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\hm_headshot.paa";
		};
	};
};

class hm_hit
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0.0;
	fadein=0;
	duration = 0.3;

	class controlsBackground {};

	class controls {

		class RscText2131000: RscPicture
		{
			idc = -1;
			x = 0.455656 * safezoneW + safezoneX;
			y = 0.422 * safezoneH + safezoneY;
			w = 0.0886877 * safezoneW;
			h = 0.154 * safezoneH;
			text = "\WW2\MissionsWW2_p\WW2_Gamemodes_p\WWRush\pictures\hm_hit.paa";
		};
	};
};

class waitingForPlayers
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=1.0;
	fadein=0;
	duration = 9999999;
	onLoad = "uiNamespace setVariable ['waitingForPlayers', _this select 0];";
	class controlsBackground {};

	class controls {
		class blackbackground: RscText
		{
			idc = 0;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class title: RscStructuredText
		{
			idc = 1100;
			text = "WAITING FOR PLAYERS";
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.45298 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.0752314 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.0)";
			shadow = 2;
			class Attributes {
				size = "4";
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "center";
				valign = "middle";
			};
		};
		class subtitle_1: RscStructuredText
		{
			idc = 1101;
			text = "";
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.8)";
			shadow = 2;
			class Attributes {
				size = "1";
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "left";
			};
		};
		class subtitle_2: RscStructuredText
		{
			idc = 1102;
			text = "";
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.53 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.8)";
			shadow = 2;
			class Attributes {
				size = "1";
				font = "PuristaMedium";
				color = "#FFFFFF";
				align = "right";
			};
		};
	};
};

class killcam_info {
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	fadeout=0;
	fadein=1.0;
	duration = 999999;
	onLoad = "uiNamespace setVariable ['killcam_info', _this select 0];";
	class ControlsBackground
	{
		class Control_BG_1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.643125;
			y = safeZoneY + safeZoneH * 0.87777778;
			w = safeZoneW * 0.1125;
			h = safeZoneH * 0.03;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.643125;
			y = safeZoneY + safeZoneH * 0.69333334;
			w = safeZoneW * 0.1125;
			h = safeZoneH * 0.18;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.475;
			y = safeZoneY + safeZoneH * 0.65888889;
			w = safeZoneW * 0.280625;
			h = safeZoneH * 0.03;
			style = 0;
			text = "";
			colorBackground[] = ACCENT_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.243125;
			y = safeZoneY + safeZoneH * 0.69333334;
			w = safeZoneW * 0.1125;
			h = safeZoneH * 0.18;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_5
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.474375;
			y = safeZoneY + safeZoneH * 0.69333334;
			w = safeZoneW * 0.16625;
			h = safeZoneH * 0.18;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_6
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.35875;
			y = safeZoneY + safeZoneH * 0.69333334;
			w = safeZoneW * 0.1125;
			h = safeZoneH * 0.18;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_7
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.243125;
			y = safeZoneY + safeZoneH * 0.87777778;
			w = safeZoneW * 0.228125;
			h = safeZoneH * 0.03;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_8
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.474375;
			y = safeZoneY + safeZoneH * 0.87777778;
			w = safeZoneW * 0.16625;
			h = safeZoneH * 0.03;
			style = 0;
			text = "";
			colorBackground[] = BG_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Control_BG_9
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.243125;
			y = safeZoneY + safeZoneH * 0.65888889;
			w = safeZoneW * 0.228125;
			h = safeZoneH * 0.03;
			style = 0;
			text = "";
			colorBackground[] = ACCENT_COLOR;
			colorText[] = {0.0706,0.9294,0.4941,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

	};
	class Controls
	{
		class RscStructuredText_1100: RscStructuredText
		{
			idc = -1;
			text = "<t size='1.25' shadow=0 font='PuristaMedium' valign='center'>KILLED BY:</t>"; //--- ToDo: Localize;
			x = 0.243805 * safezoneW + safezoneX;
			y = 0.660619 * safezoneH + safezoneY;
			w = 0.0705286 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class killer_name: RscStructuredText
		{
			idc = 1100;
			text = "<t size='1.25' shadow=2 font='PuristaBold' valign='center'></t>"; //--- ToDo: Localize;
			x = 0.30252 * safezoneW + safezoneX;
			y = 0.660807 * safezoneH + safezoneY;
			w = 0.169671 * safezoneW;
			h = 0.0272855 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = -1;
			text = "<t size='1.5' shadow=2 font='PuristaBold' align='center' valign='center'>HEALTH</t>"; //--- ToDo: Localize;
			x = 0.248742 * safezoneW + safezoneX;
			y = 0.744502 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class hp_indicator: RscStructuredText
		{
			idc = 1102;
			text = "<t size='3' shadow=2 font='PuristaBold' align='center' valign='center'>100</t>"; //--- ToDo: Localize;
			x = 0.270782 * safezoneW + safezoneX;
			y = 0.76331 * safezoneH + safezoneY;
			w = 0.0573045 * safezoneW;
			h = 0.0658275 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class RscStructuredText_1104: RscStructuredText
		{
			idc = -1;
			text = "<t size='1.5' shadow=2 font='PuristaBold' align='center' valign='center'><t color='#0000ff'>YOU</t>  -  <t color='#ff0000'>FOE</t></t>"; //--- ToDo: Localize;
			x = 0.306046 * safezoneW + safezoneX;
			y = 0.876157 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0376157 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class weapon_name: RscStructuredText
		{
			idc = 1103;
			text = "<t size='1.25' shadow=2 font='PuristaMedium' align='center' valign='center'>SUPER POWER WEAPON</t>"; //--- ToDo: Localize;
			x = 0.473552 * safezoneW + safezoneX;
			y = 0.878038 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class killer_class: RscStructuredText
		{
			idc = 1104;
			text = "<t size='1.25' shadow=2 font='PuristaMedium' align='center' valign='center'>ENGINEER</t>"; //--- ToDo: Localize;
			x = 0.645465 * safezoneW + safezoneX;
			y = 0.878038 * safezoneH + safezoneY;
			w = 0.110201 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class victim_score: RscStructuredText
		{
			idc = 1105;
			text = "<t size='1.5' shadow=2 font='PuristaBold' align='right' valign='center'>0</t>"; //--- ToDo: Localize;
			x = 0.239044 * safezoneW + safezoneX;
			y = 0.876157 * safezoneH + safezoneY;
			w = 0.0793447 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class killer_score: RscStructuredText
		{
			idc = 1106;
			text = "<t size='1.5' shadow=2 font='PuristaBold' align='left' valign='center'>0</t>"; //--- ToDo: Localize;
			x = 0.39597 * safezoneW + safezoneX;
			y = 0.876157 * safezoneH + safezoneY;
			w = 0.0793447 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class killer_faction: RscPictureKeepAspect
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.360748 * safezoneW + safezoneX;
			y = 0.697482 * safezoneH + safezoneY;
			w = 0.108397 * safezoneW;
			h = 0.17205 * safezoneH;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class weapon_image: RscPictureKeepAspect
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.47796 * safezoneW + safezoneX;
			y = 0.71629 * safezoneH + safezoneY;
			w = 0.158689 * safezoneW;
			h = 0.141059 * safezoneH;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class class_icon: RscPictureKeepAspect
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.645465 * safezoneW + safezoneX;
			y = 0.698409 * safezoneH + safezoneY;
			w = 0.107876 * safezoneW;
			h = 0.170197 * safezoneH;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
	};
};
