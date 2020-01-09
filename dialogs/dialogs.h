#define PRIMARY_COLOR {0.96,0.65,0.12,0.8}
#define DARK_COLOR {0.12,0.14,0.16,0.8}
#define BRIGHT_COLOR {1,1,1,0.8}
#define WHITE_SHADOW {1,1,1,0.1}
#define DISABLED_COLOR {0.52,0.54,0.56,1}
#define DISABLED_SETTING \
	colorDisabled[] = DISABLED_COLOR;\
	colorBackgroundDisabled[] = DARK_COLOR

#define SIDEBAR_WIDTH safeZoneW * 0.2
#define SIDEBAR_BORDER safeZoneW * 0.0025
#define SIDEBAR_CONTENT_WIDTH (SIDEBAR_WIDTH - 2 * SIDEBAR_BORDER)
#define SIDEBAR_ITEM_HEIGHT safeZoneH * 0.04555556

class rr_spawnmenu {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    fadein=2;
    duration = 999999;
	onLoad = "params ['_display']; uiNamespace setVariable ['rr_spawnmenu', _display];"; // if (call BIS_fnc_admin != 2) then {(_display displayCtrl 1301) ctrlShow false}";
	onKeyDown = "private _h = false; if (_this select 1 == 1) then { _h = true; }; _h";
	class ControlsBackground
	{
		class Sidebar_Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
			y = safeZoneY;
			w = SIDEBAR_WIDTH;
			h = safeZoneH * 1;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,0.35};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
		class Sidebar_Background_Frame
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
			y = safeZoneY - safeZoneH * 0.00694444;
			w = SIDEBAR_WIDTH + 0.007;
			h = safeZoneH * 1.01215278;
			style = 64;
			text = "";
			colorBackground[] = {0.96, 0.65, 0.12, 1};
			colorText[] = {0.96, 0.65, 0.12, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		};
	};
    class controls {
		class Sidebar_Container: RscControlsGroupNoScrollbars
		{
			idc = -1;
			x = safeZoneX + safeZoneW - SIDEBAR_WIDTH;
			y = safeZoneY + safeZoneH * 0;
			w = SIDEBAR_WIDTH;
			h = safeZoneH * 1;
			onLoad = "uiNamespace setVariable ['rr_spawnmenu_sidebar', _this select 0]";
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			class Controls {
				class AbortButton: RscButtonMenu
			    {
			      action = "[] call client_fnc_saveStatistics; endMission 'MatchLeft';";
			      idc = 1000;
			      color[] = {1,1,1,1};
			      font = "PuristaBold";
			      size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";

			      text = "QUIT"; //--- ToDo: Localize;
				  x = SIDEBAR_BORDER;
				  y = SIDEBAR_BORDER;
				  w = SIDEBAR_CONTENT_WIDTH;
				  h = SIDEBAR_ITEM_HEIGHT;
			      colorText[] = {1,1,1,1};
				  colorDisabled[] = DISABLED_COLOR;
				  colorBackground[] = DARK_COLOR;
				  colorBackgroundDisabled[] = DARK_COLOR;
			    };

				class admin_area: RscButtonMenu
				{
					action = "[] call client_fnc_displayAdminArea";
					idc = 1301;
					size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					font = "PuristaBold";
					color[] = {0,0,0,1};

					text = "ADMIN AREA"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 2 * SIDEBAR_BORDER + SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_WIDTH - 2 * SIDEBAR_BORDER;
					h = SIDEBAR_ITEM_HEIGHT;
					colorText[] = {0,0,0,1};
					colorBackground[] = PRIMARY_COLOR;
					colorDisabled[] = DISABLED_COLOR;
					colorBackgroundDisabled[] = DARK_COLOR;
				};

				class side_switch: RscControlsGroupNoScrollbars {
					idc = -1;
					x = SIDEBAR_BORDER;
					y = 4 * SIDEBAR_BORDER + 3 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT;
					font = "PuristaMedium";
					sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
					class Controls {
						class switch_side: RscButtonMenu
						{
							idc = 105;
							size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
							font = "PuristaBold";
							color[] = {0,0,0,1};
							action = "[] spawn client_fnc_sideSwitch;";
							text = "SWITCH SIDE"; //--- ToDo: Localize;
							x = 0;
							y = 0;
							w = SIDEBAR_CONTENT_WIDTH * 3/4 - SIDEBAR_BORDER;
							h = SIDEBAR_ITEM_HEIGHT;
							colorText[] = {0,0,0,1};
							colorBackground[] = PRIMARY_COLOR;
							colorDisabled[] = DISABLED_COLOR;
							colorBackgroundDisabled[] = DARK_COLOR;
						};
						class enemy_flag: RscPicture
						{
							idc = 1205;
							text = "";
							x = SIDEBAR_CONTENT_WIDTH * 3/4;
							y = 0;
							w = SIDEBAR_CONTENT_WIDTH * 1/4;
							h = SIDEBAR_ITEM_HEIGHT;
						};
					};
				};

				class GroupsButton: RscButtonMenu
			    {
			      	action = "(findDisplay 5000) createDisplay 'RscDisplayDynamicGroups'";
			    	idc = 100;
			      	size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
			      	font = "PuristaBold";
			    	text = "VIEW GROUPS"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 5 * SIDEBAR_BORDER + 4 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT;
					color[] = {0,0,0,1};
					colorText[] = {0,0,0,1};
			    	colorBackground[] = PRIMARY_COLOR;
			    };

				class ClassHeader: RscText
				{
				  idc = -1;
				  text = "CLASS SELECTION"; //--- ToDo: Localize;
				  x = SIDEBAR_BORDER;
				  y = 7 * SIDEBAR_BORDER + 6 * SIDEBAR_ITEM_HEIGHT;
				  w = SIDEBAR_CONTENT_WIDTH;
				  h = SIDEBAR_ITEM_HEIGHT / 2;
				  colorBackground[] = PRIMARY_COLOR;
				};

				class Classes: RscListBox
				{
					idc = 300;
					sizeEx = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
					rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
					wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
					x = SIDEBAR_BORDER;
					y = 7 * SIDEBAR_BORDER + 6.5 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 3;
					colorBackground[] = DARK_COLOR;
					colorSelect[] = {1, 1, 1, 1};
					colorText[] = {1, 1, 1, 0.5};
					colorSelect2[] = {1, 1, 1, 1};
					colorSelectBackground[] = PRIMARY_COLOR;
					colorSelectBackground2[] = PRIMARY_COLOR;
					onLBSelChanged = "_this call displays_fnc_spawnMenu_handleClassSelect";
				};

				class customizeClassButton: RscButtonMenu
				{
					idc = 301;
					style = "0x02 + 0x0c";
					action = "[] call displays_fnc_spawnMenu_handleClassCustomize";
					text = "CUSTOMIZE CLASS ABILITIES"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 7 * SIDEBAR_BORDER + 9.5 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT / 2;
					colorText[] = {1,1,1,1};
					colorBackground[] = DARK_COLOR;
				};

				class SpawnHeader: RscText
				{
					idc = -1;
					text = "SPAWN POINTS"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 11 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT / 2;
					colorBackground[] = PRIMARY_COLOR;
				};

				class Spawnpoints: RscListBox
				{
					idc = 8;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 11.5 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 3;
					sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.75)";
					rowHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
					wholeHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
					colorBackground[] = DARK_COLOR;
					colorSelect[] = {1, 1, 1, 1};
					colorText[] = {1, 1, 1, 0.5};
					colorSelect2[] = {1, 1, 1, 1};
					colorSelectBackground[] = PRIMARY_COLOR;
					colorSelectBackground2[] = PRIMARY_COLOR;
					onLBSelChanged = "_this call displays_fnc_spawnMenu_handleSpawnSelect;";
				};

				class VehiclesHeader: RscText
				{
					idc = -1;

					text = "VEHICLES"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 14.5 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT / 2;
					colorBackground[] = PRIMARY_COLOR;
				};

				class Vehicles: RscListBox
				{
					idc = 9;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 15.0 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 4;
					sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.75)";
					rowHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
					wholeHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
					colorBackground[] = DARK_COLOR;
					colorSelect[] = {1, 1, 1, 1};
					colorText[] = {1, 1, 1, 0.5};
					colorSelect2[] = {1, 1, 1, 1};
					colorSelectBackground[] = PRIMARY_COLOR;
					colorSelectBackground2[] = PRIMARY_COLOR;
					onLBSelChanged = "_this call displays_fnc_spawnMenu_handleSpawnSelect;";
				};

				class Deploy: RscControlsGroupNoScrollbars {
					idc = -1;
					x = SIDEBAR_BORDER;
					y = 10 * SIDEBAR_BORDER + 19.0 * SIDEBAR_ITEM_HEIGHT;
					w = SIDEBAR_CONTENT_WIDTH;
					h = SIDEBAR_ITEM_HEIGHT * 2;

					class Controls {
						class deploybutton: RscButtonMenu
					    {
					      	action = "[] call client_fnc_spawnMenu_getClassAndSpawn";
					    	idc = 302;
					    	color[] = {0,0,0,1};
					    	font = "PuristaBold";
					    	size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
					    	text = ""; //--- ToDo: Localize;
							x = 0;
							y = 0;
							w = SIDEBAR_CONTENT_WIDTH;
							h = SIDEBAR_ITEM_HEIGHT * 2;
					    	colorText[] = {0,0,0,1};
							colorDisabled[] = DISABLED_COLOR;
					    	colorBackground[] = PRIMARY_COLOR;
							colorBackgroundDisabled[] = DARK_COLOR;
					    };
						class button_text: RscText {
							idc = 303;
							style = 2 + 192;
							color[] = {0,0,0,1};
							font = "PuristaLight";
							size = "2.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
							sizeEx = SIDEBAR_CONTENT_WIDTH * 0.2;
							shadow = 0;
							text = "DEPLOY"; //--- ToDo: Localize;
							x = 0;
							y = 0;
							w = SIDEBAR_CONTENT_WIDTH;
							h = SIDEBAR_ITEM_HEIGHT * 1.9;
						};
						class timeLeft: RscStructuredText
						{
							text = "";
							idc = 304;
							size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
							style = 1;
							x = 0;
							y = SIDEBAR_ITEM_HEIGHT + SIDEBAR_ITEM_HEIGHT / 4;
							w = SIDEBAR_CONTENT_WIDTH;
							h = SIDEBAR_ITEM_HEIGHT;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};

							class Attributes {
								size = 0.8;
								font = "PuristaLight";
								color = "#848a8f";
								align = "center";
								valign = "middle";
								shadow = 0;
							};
						};
					};
				};
			};
		};
		class RscText_1000: RscText
		{
			idc = 207;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class primary_description: RscStructuredText
		{
			idc = 1001;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.4252 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1002: RscText
		{
			idc = 208;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.4945 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.0044 * safezoneH;
			colorBackground[] = BRIGHT_COLOR;
		};
		class RscText_1003: RscText
		{
			idc = 209;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.5022 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class secondary_description: RscStructuredText
		{
			idc = 1004;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.6364 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class weaponSelectionBackground: RscText
		{
			idc = 2;
			x = 0.16072 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.259844 * safezoneW;
			h = 0.4114 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class weaponSelectionListbox: RscListbox
		{
			idc = 3;
			x = 0.162782 * safezoneW + safezoneX;
			y = 0.2954 * safezoneH + safezoneY;
			w = 0.255718 * safezoneW;
			h = 0.4026 * safezoneH;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
			rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 0, 0, 1};
			colorText[] = {1, 1, 1, 0.5};
			colorSelect2[] = {1, 1, 1, 1};
			colorSelectBackground[] = PRIMARY_COLOR;
			colorSelectBackground2[] = PRIMARY_COLOR;
			onLBSelChanged = "_this call displays_fnc_spawnMenu_handleWeaponSelect;";
		};
		class textPrimary: RscStructuredText
		{
			idc = 5;
			x = 0.00706247 * safezoneW + safezoneX;
			y = 0.2954 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.101 * safezoneH;
		};
		/* class textPrimaryAttachments: RscStructuredText
		{
			idc = 6;
			x = 0.00706247 * safezoneW + safezoneX;
			y = 0.4296 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.0572 * safezoneH;
		}; */
		class textHandgun: RscStructuredText
		{
			idc = 7;
			x = 0.00706247 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.101 * safezoneH;
		};
		/* class textHandgunAttachments: RscStructuredText
		{
			idc = 8;
			x = 0.00706244 * safezoneW + safezoneX;
			y = 0.6408 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.0572 * safezoneH;
		}; */
		class primaryWeaponSelectionActivator: RscButtonMenu
		{
			action = "[] call client_fnc_spawnMenu_displayPrimaryWeaponSelection;";
			idc = 15;
			text = ""; //--- ToDo: Localize;
			x = 0.00706247 * safezoneW + safezoneX;
			y = 0.2954 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.101 * safezoneH;
			animTextureNormal = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureDisabled = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureOver = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureFocused = "#(argb,8,8,3)color(1,1,1,0)";
			animTexturePressed = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureDefault = "#(argb,8,8,3)color(1,1,1,0)";
			colorBackground[] = {0,0,0,0};
			colorBackgroundFocused[] = {1,1,1,0};
			colorBackground2[] = {0.75,0.75,0.75,0};
			color[] = {1,1,1,0};
			colorFocused[] = {0,0,0,0};
			color2[] = {0,0,0,0};
			colorText[] = {1,1,1,0};
			colorDisabled[] = {1,1,1,0};
		};
		class secondaryWeaponSelectionActivator: RscButtonMenu
		{
			action = "[] call client_fnc_spawnMenu_displaySecondaryWeaponSelection;";
			idc = 16;
			text = ""; //--- ToDo: Localize;
			x = 0.00706247 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.101 * safezoneH;
			animTextureNormal = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureDisabled = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureOver = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureFocused = "#(argb,8,8,3)color(1,1,1,0)";
			animTexturePressed = "#(argb,8,8,3)color(1,1,1,0)";
			animTextureDefault = "#(argb,8,8,3)color(1,1,1,0)";
			colorBackground[] = {0,0,0,0};
			colorBackgroundFocused[] = {1,1,1,0};
			colorBackground2[] = {0.75,0.75,0.75,0};
			color[] = {1,1,1,0};
			colorFocused[] = {0,0,0,0};
			color2[] = {0,0,0,0};
			colorText[] = {1,1,1,0};
			colorDisabled[] = {1,1,1,0};
		};

		/* new ui */
		class RscText_1000513: RscText
		{
			idc = 201;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001573: RscText
		{
			idc = 202;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = BRIGHT_COLOR;
		};
		class exppoints: RscText
		{
			idc = 103;
			text = ""; //--- ToDo: Localize;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.19 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
    };
		class RscText_10032353462: RscText
		{
			idc = 203;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.004125 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = BRIGHT_COLOR;
		};
		class RscText_100412213: RscText
		{
			idc = 204;
			x = 0.555688 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1019635243: RscProgress
		{
			idc = 101;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorFrame[] = {0,0,0,0};
    		colorBackground[] = {0,0,0,0};
   	 		colorBar[] = {0.96,0.65,0.12,1};
		};
		class weapontounlock: RscStructuredText
		{
			idc = 102;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.863 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.121 * safezoneH;
		};

		class RscText_24056776: RscText
		{
			idc = 104;
			text = "WEAPONS SELECTION";
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.044 * safezoneH;
			color[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.84,0.57,0.1,0.8};
			size = "1.00 *     (pixelH * pixelGridNoUIScale * 1)";
      /* sizeEx = 0.04; */
		};


    class RscStructuredText_1105: RscStructuredText
    {
    	idc = 2001;
    	text = ""; //--- ToDo: Localize;
      x = 0.00964063 * safezoneW + safezoneX;
    	y = 0.67512 * safezoneH + safezoneY;
    	w = 0.1475 * safezoneW;
    	h = 0.0210741 * safezoneH;
    	colorBackground[] = {-1,-1,-1,0};
    };
    class RscStructuredText_1106: RscStructuredText
    {
    	idc = 2002;
    	text = ""; //--- ToDo: Localize;
      x = 0.00706249 * safezoneW + safezoneX;
    	y = 0.4681 * safezoneH + safezoneY;
    	w = 0.150573 * safezoneW;
    	h = 0.022926 * safezoneH;
    	colorBackground[] = {-1,-1,-1,0};
    };
  };
};

class rr_info_box {
    idd = 10000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
    class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.286 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,1};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = "INFORMATION"; //--- ToDo: Localize;
			x = 0.34428 * safezoneW + safezoneX;
			y = 0.3526 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};
		class text: RscStructuredText
		{
			idc = 0;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.299062 * safezoneW;
			h = 0.209 * safezoneH;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;
			text = "OKAY"; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.6144 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,1};
		};
	};
};

class rr_class_customization {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
    class controls {
		class RscText_1000: RscText
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,1,1,1};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			text = "Class Perks"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			shadow = 2;
		};
		class RscText_1003: RscText
		{
			idc = -1;
			text = "Secondary Perks"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			shadow = 2;
		};
		class lbClassPerks: RscListbox
		{
			idc = 0;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.308 * safezoneH;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
			rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
			wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = PRIMARY_COLOR;
		    colorSelectBackground2[] = PRIMARY_COLOR;
			onLBSelChanged = "[] call client_fnc_setUsedPerksForClass";
		};
		class lbSquadPerks: RscListbox
		{
			idc = 1;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.308 * safezoneH;
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
			rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
			wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = PRIMARY_COLOR;
		    colorSelectBackground2[] = PRIMARY_COLOR;
			onLBSelChanged = "[] call client_fnc_setUsedPerksForClass";

		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;
			text = "RETURN"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.6672 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
	};
};

class AdminAreaLB: RscListBox {
	rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.5)";
	wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.5)";
	sizeEx = "1.00 * pixelH * pixelGridNoUIScale * 1.4";
	colorSelect[] = BRIGHT_COLOR;
	colorText[] = {1, 1, 1, 0.5};
	colorSelect2[] = BRIGHT_COLOR;
	colorSelectBackground[] = PRIMARY_COLOR;
	colorSelectBackground2[] = PRIMARY_COLOR;
	period = 1;
};

class PlayerSelectorLB: AdminAreaLB {
	onLBSelChanged = "cl_admin_player_sel = ((_this select 0) lbData (_this select 1)) call BIS_fnc_objectFromNetId;";
	onSetFocus = "params ['_ctrl']; private _display = ctrlParent _ctrl; (_display displayCtrl ([1500,1501] select (ctrlIDC _ctrl == 1500))) lbSetCurSel -1;";
};

class rr_modal {
	idd = 8000;
	movingEnable = 0;
	enableSimulation = 1;
	duration = 999999;
	onUnload = "params ['_display', '_exitCode'];if (_exitCode != 1) exitWith {};[ctrlText 1400] call (uiNamespace getVariable ['rr_modal_callback', {}])";
	class controls {
		class RscText_1000: RscText
		{
			idc = 1000;

			x = 0.323679 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.352643 * safezoneW;
			h = 0.131655 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = 1001;

			x = 0.323679 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.352643 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1002: RscText
		{
			idc = 1002;

			text = "TITLE"; //--- ToDo: Localize;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
		class RscButtonMenuOK_2600: RscButtonMenu
		{
			idc = 1;

			text = "CONFIRM"; //--- ToDo: Localize;
			x = 0.610201 * safezoneW + safezoneX;
			y = 0.54702 * safezoneH + safezoneY;
			w = 0.0661205 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscButtonMenuCancel_2700: RscButtonMenu
		{
			idc = 2;

			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.54408 * safezoneW + safezoneX;
			y = 0.54702 * safezoneH + safezoneY;
			w = 0.0661205 * safezoneW;
			h = 0.0188079 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			text = "";
			maxChars = 256;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0658275 * safezoneH;
			colorBackground[] = {1,1,1,0.1};
		};
		class RscText_1003: RscText
		{
			idc = 1003;

			text = "Description"; //--- ToDo: Localize;
			x = 0.328087 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.343827 * safezoneW;
			h = 0.0282118 * safezoneH;
		};
	};
};

class rr_admin_area {
    idd = 7000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
	onLoad = "_this call client_fnc_populateAdminArea;";
	class controls {
		class RscText_1000: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.385561 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1009: RscText
		{
			idc = -1;

			x = 0.501763 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.220402 * safezoneW;
			h = 0.385561 * safezoneH;
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1001: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.446975 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1002: RscText
		{
			idc = -1;
			shadow = 2;

			text = "ADMIN AREA"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.211586 * safezoneW;
			h = 0.0282118 * safezoneH;
			sizeEx = 2.00 * pixelH * pixelGridNoUIScale;
		};
		class RscText_1003: RscText
		{
			idc = 1001;
			shadow = 2;
			style = 2;

			text = "Attackers"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;

			text = "RETURN"; //--- ToDo: Localize;
			x = 0.638412 * safezoneW + safezoneX;
			y = 0.650463 * safezoneH + safezoneY;
			w = 0.0837527 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscText_1006: RscText
		{
			idc = 1002;
			shadow = 2;
			style = 2;

			text = "Defenders"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1000;
			shadow = 2;

			text = "Next map:"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.207178 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class map_picker: RscButtonMenu
		{
			idc = 100;
			action = "if (!isNil 'cl_admin_sel_map') then {[cl_admin_sel_map] remoteExecCall ['server_fnc_selectNextMap',2]; private _admin = findDisplay 7000; private _list = _admin displayCtrl 1502; (_admin displayCtrl 1000) ctrlSetText format ['Next map: %1', _list lbText (lbCurSel _list)];}; false";

			text = "CHOOSE MAP"; //--- ToDo: Localize;
			x = 0.614609 * safezoneW + safezoneX;
			y = 0.481192 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class kick_player: RscButtonMenu
		{
			idc = 101;
			action = "[] call admin_fnc_kickPlayer";

			text = "KICK PLAYER"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.594039 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2403: RscButtonMenu
		{
			idc = 102;
			action = "[] spawn admin_fnc_switchPlayer";

			text = "SWITCH PLAYER"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.594039 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class kill_player: RscButtonMenu
		{
			idc = 103;
			action = "[] call admin_fnc_killPlayer";

			text = "KILL PLAYER"; //--- ToDo: Localize;
			x = 0.279598 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2405: RscButtonMenu
		{
			idc = 1;
			action = "[] spawn admin_fnc_spectate";

			text = "SPECTATOR MODE"; //--- ToDo: Localize;
			x = 0.389799 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class attackers_list: PlayerSelectorLB
		{
			idc = 1500;

			x = 0.279598 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.253906 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class defenders_list: PlayerSelectorLB
		{
			idc = 1501;

			x = 0.389799 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.105793 * safezoneW;
			h = 0.253906 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class map_list: AdminAreaLB
		{
			idc = 1502;
			onLBSelChanged = "params ['_ctrl', '_idx']; cl_admin_sel_map = _ctrl lbData _idx;";

			x = 0.506171 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.211586 * safezoneW;
			h = 0.141059 * safezoneH;
			colorText[] = {1,1,1,0.5};
			sizeEx = 1.00 * pixelH * pixelGridNoUIScale;
		};
		class RscButtonMenu_2406: RscButtonMenu
		{
			idc = 100;
			action = "[] spawn { _result = ['Are you sure you want to end the round?', 'Confirm', true, true] call BIS_fnc_guiMessage; if (_result) then {[] remoteExec ['server_fnc_endRound', 2]};}";
			text = "END ROUND"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.481192 * safezoneH + safezoneY;
			w = 0.101385 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = DARK_COLOR;
		};
		class RscButtonMenu_2407: RscButtonMenu
		{
			idc = 100;
			action = "if (isNull (findDisplay 8000)) then {createDialog 'rr_admin_params';};";
			type = 1;
			style = ST_CENTER;
			text = "EDIT PARAMS"; //--- ToDo: Localize;
			x = 0.54408 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.136649 * safezoneW;
			h = 0.0564236 * safezoneH;
			colorText[] = {1,1,1,1};
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			colorBackground[] = WHITE_SHADOW;
			colorBackgroundActive[] = BRIGHT_COLOR;
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			DISABLED_SETTING;
			period = 0;
			colorShadow[] = {0,0,0,0};
			colorBorder[]= DARK_COLOR;
			borderSize = 0;
		};
	};
};

class rr_admin_params {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;
	onLoad = "_this call client_fnc_populateAdminParams";
	onUnload = "_this call admin_fnc_setParams";
	class controls {
		class RscText_1100: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.293114 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.376157 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1101: RscText
		{
			idc = -1;

			x = 0.5 * safezoneW + safezoneX;
			y = 0.293114 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.376157 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1102: RscText
		{
			idc = -1;

			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.446975 * safezoneW;
			h = 0.0282118 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1103: RscText
		{
			idc = -1;
			shadow = 2;

			text = "PARAMS"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.22481 * safezoneW;
			h = 0.0282118 * safezoneH;
			sizeEx = 2.00 * pixelH * pixelGridNoUIScale;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 2;

			text = "CANCEL"; //--- ToDo: Localize;
			x = 0.570529 * safezoneW + safezoneX;
			y = 0.669271 * safezoneH + safezoneY;
			w = 0.0837527 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscButtonMenu_2401: RscButtonMenu
		{
			idc = 1;

			text = "CONFIRM"; //--- ToDo: Localize;
			x = 0.656926 * safezoneW + safezoneX;
			y = 0.669271 * safezoneH + safezoneY;
			w = 0.069647 * safezoneW;
			h = 0.0206886 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class ParamTitle: RscText {
			sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1)";
		};
		class RscText_1000: ParamTitle
		{
			idc = 1000;

			text = "Text_0"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1001: ParamTitle
		{
			idc = 1001;

			text = "Text_1"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1002: ParamTitle
		{
			idc = 1002;

			text = "Text_2"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1003: ParamTitle
		{
			idc = 1003;

			text = "Text_3"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1004: ParamTitle
		{
			idc = 1004;

			text = "Text_4"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1005: ParamTitle
		{
			idc = 1005;

			text = "Text_5"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1006: ParamTitle
		{
			idc = 1006;

			text = "Text_6"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1007: ParamTitle
		{
			idc = 1007;

			text = "Text_7"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1008: ParamTitle
		{
			idc = 1008;

			text = "Text_8"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1009: ParamTitle
		{
			idc = 1009;

			text = "Text_9"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1010: ParamTitle
		{
			idc = 1010;

			text = "Text_10"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1011: ParamTitle
		{
			idc = 1011;

			text = "Text_11"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1012: ParamTitle
		{
			idc = 1012;

			text = "Text_12"; //--- ToDo: Localize;
			x = 0.27519 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1013: ParamTitle
		{
			idc = 1013;

			text = "Text_13"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1014: ParamTitle
		{
			idc = 1014;

			text = "Text_14"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1015: ParamTitle
		{
			idc = 1015;

			text = "Text_15"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1016: ParamTitle
		{
			idc = 1016;

			text = "Text_16"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1017: ParamTitle
		{
			idc = 1017;

			text = "Text_17"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1018: ParamTitle
		{
			idc = 1018;

			text = "Text_18"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1019: ParamTitle
		{
			idc = 1019;

			text = "Text_19"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1020: ParamTitle
		{
			idc = 1020;

			text = "Text_20"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1021: ParamTitle
		{
			idc = 1021;

			text = "Text_21"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1022: ParamTitle
		{
			idc = 1022;

			text = "Text_22"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1023: ParamTitle
		{
			idc = 1023;

			text = "Text_23"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1024: ParamTitle
		{
			idc = 1024;

			text = "Text_24"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscText_1025: ParamTitle
		{
			idc = 1025;

			text = "Text_25"; //--- ToDo: Localize;
			x = 0.508816 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.167505 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1100: RscCombo
		{
			idc = 1100;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1101: RscCombo
		{
			idc = 1101;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1102: RscCombo
		{
			idc = 1102;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1103: RscCombo
		{
			idc = 1103;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1104: RscCombo
		{
			idc = 1104;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1105: RscCombo
		{
			idc = 1105;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1106: RscCombo
		{
			idc = 1106;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1107: RscCombo
		{
			idc = 1107;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1108: RscCombo
		{
			idc = 1108;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1109: RscCombo
		{
			idc = 1109;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1110: RscCombo
		{
			idc = 1110;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1111: RscCombo
		{
			idc = 1111;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1112: RscCombo
		{
			idc = 1112;

			x = 0.447104 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1113: RscCombo
		{
			idc = 1113;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.302518 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1114: RscCombo
		{
			idc = 1114;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1115: RscCombo
		{
			idc = 1115;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.358941 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1116: RscCombo
		{
			idc = 1116;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.387153 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1117: RscCombo
		{
			idc = 1117;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.415365 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1118: RscCombo
		{
			idc = 1118;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.443576 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1119: RscCombo
		{
			idc = 1119;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.471788 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1120: RscCombo
		{
			idc = 1120;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1121: RscCombo
		{
			idc = 1121;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.528212 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1122: RscCombo
		{
			idc = 1122;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.556424 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1123: RscCombo
		{
			idc = 1123;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.584635 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1124: RscCombo
		{
			idc = 1124;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.612847 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
		class RscCombo_1125: RscCombo
		{
			idc = 1125;

			x = 0.68073 * safezoneW + safezoneX;
			y = 0.641059 * safezoneH + safezoneY;
			w = 0.0440804 * safezoneW;
			h = 0.0188079 * safezoneH;
		};
	};
};
