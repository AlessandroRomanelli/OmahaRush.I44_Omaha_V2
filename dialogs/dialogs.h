#define PRIMARY_COLOR {0.96,0.65,0.12,0.8}
#define COLOR_PRIMARY(ALPHA) {0.96,0.65,0.12,ALPHA}
#define DARK_COLOR {0.12,0.14,0.16,0.8}
#define COLOR_DARK(ALPHA) {0.12,0.14,0.16,ALPHA}
#define BRIGHT_COLOR {1,1,1,0.8}
#define COLOR_BRIGHT(ALPHA) {1,1,1,ALPHA}
#define WHITE_SHADOW {1,1,1,0.1}
#define COLOR_BLACK(ALPHA) {0,0,0,ALPHA}
#define DISABLED_COLOR {0.52,0.54,0.56,1}
#define DISABLED_SETTING \
	colorDisabled[] = DISABLED_COLOR;\
	colorBackgroundDisabled[] = DARK_COLOR

#define SIDEBAR_WIDTH safeZoneW * 0.2
#define SIDEBAR_BORDER safeZoneW * 0.0025
#define SIDEBAR_CONTENT_WIDTH (SIDEBAR_WIDTH - 2 * SIDEBAR_BORDER)
#define SIDEBAR_ITEM_HEIGHT safeZoneH * 0.04555556

#define LOADOUT_WIDTH safeZoneW * 0.45
#define LOADOUT_HEIGHT safeZoneH * 0.66

#define LOADOUT_GUTTER SIDEBAR_BORDER

#define LOADOUT_L_COL_WIDTH safeZoneW * 0.175
#define LOADOUT_R_COL_WIDTH (LOADOUT_WIDTH - LOADOUT_L_COL_WIDTH)
#define LOADOUT_HEADER_HEIGHT safeZoneH * 0.04

#define LOADOUT_SMALL_HEADER_HEIGHT LOADOUT_HEADER_HEIGHT / 2
#define LOADOUT_WEAPON_PICTURE_HEIGHT LOADOUT_L_COL_WIDTH * 9 / 16
#define LOADOUT_WEAPON_DESC_HEIGHT LOADOUT_WEAPON_PICTURE_HEIGHT / 3
#define LOADOUT_WEAPON_FRAME_HEIGHT (LOADOUT_SMALL_HEADER_HEIGHT + LOADOUT_WEAPON_PICTURE_HEIGHT + LOADOUT_WEAPON_DESC_HEIGHT)

#define LOADOUT_PERK_WIDTH (LOADOUT_L_COL_WIDTH - LOADOUT_GUTTER) / 2
#define LOADOUT_PERK_PICTURE_SIZE LOADOUT_PERK_WIDTH * 0.66

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
			colorBackground[] = COLOR_DARK(1.0);
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

			class WWR_Sidebar_Item: RscButtonMenu
			{
				idc = -1;
				size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
				color[] = {0,0,0,1};
				text = ""; //--- ToDo: Localize;
				x = 0;
				y = 0;
				w = SIDEBAR_WIDTH - 2 * SIDEBAR_BORDER;
				h = SIDEBAR_ITEM_HEIGHT;
				colorText[] = {0,0,0,1};
				colorBackground[] = PRIMARY_COLOR;
				colorDisabled[] = DISABLED_COLOR;
				colorBackgroundDisabled[] = DARK_COLOR;
			};

			class WWR_Sidebar_Header: RscText
			{
			  idc = -1;
			  text = ""; //--- ToDo: Localize;
			  x = 0;
			  y = 0;
			  w = SIDEBAR_CONTENT_WIDTH;
			  h = SIDEBAR_ITEM_HEIGHT / 2;
			  colorBackground[] = PRIMARY_COLOR;
			};

			class WWR_Sidebar_Listbox: RscListBox {
				idc = -1;
				sizeEx = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
				rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
				wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
				x = SIDEBAR_BORDER;
				y = 0
				w = SIDEBAR_CONTENT_WIDTH;
				h = SIDEBAR_ITEM_HEIGHT * 3;
				colorBackground[] = DARK_COLOR;
				colorSelect[] = {1, 1, 1, 1};
				colorText[] = {1, 1, 1, 0.5};
				colorSelect2[] = {1, 1, 1, 1};
				colorSelectBackground[] = COLOR_BLACK(0.25);
				colorSelectBackground2[] = COLOR_BLACK(0.35);
			};

			class Controls {
				class AbortButton: WWR_Sidebar_Item
			    {
			      action = "[] call client_fnc_saveStatistics; endMission 'MatchLeft';";
			      idc = 1000;
			      text = "QUIT TO LOBBY"; //--- ToDo: Localize;
				  x = SIDEBAR_BORDER;
				  y = SIDEBAR_BORDER;
			    };

				class admin_area: WWR_Sidebar_Item
				{
					action = "[] call client_fnc_displayAdminArea";
					idc = 1301;
					text = "ADMIN AREA"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 2 * SIDEBAR_BORDER + SIDEBAR_ITEM_HEIGHT;
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

				class GroupsButton: WWR_Sidebar_Item
			    {
			      	action = "(findDisplay 5000) createDisplay 'RscDisplayDynamicGroups'";
			    	idc = 100;
			    	text = "VIEW GROUPS"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 5 * SIDEBAR_BORDER + 4 * SIDEBAR_ITEM_HEIGHT;
			    };

				class ClassHeader: WWR_Sidebar_Header
				{
				  text = "CLASS SELECTION"; //--- ToDo: Localize;
				  x = SIDEBAR_BORDER;
				  y = 7 * SIDEBAR_BORDER + 6 * SIDEBAR_ITEM_HEIGHT;
				};

				class Classes: WWR_Sidebar_Listbox
				{
					idc = 300;
					y = 7 * SIDEBAR_BORDER + 6.5 * SIDEBAR_ITEM_HEIGHT;
					h = SIDEBAR_ITEM_HEIGHT * 3;
					onLBSelChanged = "_this call displays_fnc_spawnMenu_handleClassSelect";
				};
				/*
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
					colorBackground[] = COLOR_BLACK(0.2);
				}; */

				class SpawnHeader: WWR_Sidebar_Header
				{
					text = "SPAWN POINTS"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 11 * SIDEBAR_ITEM_HEIGHT;
				};

				class Spawnpoints: WWR_Sidebar_Listbox
				{
					idc = 8;
					y = 9 * SIDEBAR_BORDER + 11.5 * SIDEBAR_ITEM_HEIGHT;
					h = SIDEBAR_ITEM_HEIGHT * 3;
					onLBSelChanged = "_this call displays_fnc_spawnMenu_handleSpawnSelect;";
				};

				class VehiclesHeader: WWR_Sidebar_Header
				{
					text = "VEHICLES"; //--- ToDo: Localize;
					x = SIDEBAR_BORDER;
					y = 9 * SIDEBAR_BORDER + 14.5 * SIDEBAR_ITEM_HEIGHT;
				};

				class Vehicles: WWR_Sidebar_Listbox
				{
					idc = 9;
					y = 9 * SIDEBAR_BORDER + 15.0 * SIDEBAR_ITEM_HEIGHT;
					h = SIDEBAR_ITEM_HEIGHT * 4;
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
							colorBackgroundDisabled[] = COLOR_BLACK(0.2);
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
		class Loadout_Container: RscControlsGroupNoScrollbars
		{
			idc = -1;
			x = safeZoneX;
			y = safeZoneY + safeZoneH / 2 - LOADOUT_HEIGHT / 2;
			w = LOADOUT_WIDTH;
			h = LOADOUT_HEIGHT;

			class WWR_Loadout_Small_Header: RscText {
				idc = -1;
				style = 2 + 512;
				x = 0;
				y = 0;
				w = LOADOUT_L_COL_WIDTH;
				h = LOADOUT_SMALL_HEADER_HEIGHT;
				colorBackground[] = COLOR_BRIGHT(1.0);
				colorText[] = COLOR_DARK(1.0);
				shadow = 0;
				text = "";
			};

			class WWR_WeaponFrame: RscControlsGroupNoScrollbars {
				idc = -1;
				x = 0;
				y = 0;
				w = LOADOUT_L_COL_WIDTH;
				h = LOADOUT_WEAPON_FRAME_HEIGHT;

				class controls {
					class Background: RscText {
						idc = -1;
						x = 0;
						y = 0;
						w = LOADOUT_L_COL_WIDTH;
						h = LOADOUT_WEAPON_FRAME_HEIGHT;
						colorBackground[] = DARK_COLOR;
					};
					class WeaponHeader: WWR_Loadout_Small_Header {};
					class WeaponActivator: RscButtonMenu {
						idc = -1;
						x = 0;
						y = LOADOUT_SMALL_HEADER_HEIGHT;
						w = LOADOUT_L_COL_WIDTH;
						h = LOADOUT_WEAPON_PICTURE_HEIGHT;
						animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.2)";
						animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
						animTextureOver = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
						animTextureFocused = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
						animTexturePressed = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
						animTextureDefault = "";
						/* colorBackground2[] = COLOR_PRIMARY(0.25); */
					};
					class WeaponPicture: RscPictureKeepAspect {
						idc = -1;
						x = 0;
						y = LOADOUT_SMALL_HEADER_HEIGHT;
						w = LOADOUT_L_COL_WIDTH;
						h = LOADOUT_WEAPON_PICTURE_HEIGHT;
						text = "";
					};
					class WeaponDescription: RscText {
						idc = -1;
						style = 2 + 0x200
						x = 0;
						y = LOADOUT_SMALL_HEADER_HEIGHT + LOADOUT_WEAPON_PICTURE_HEIGHT;
						w = LOADOUT_L_COL_WIDTH;
						h = LOADOUT_WEAPON_DESC_HEIGHT;
						text = "";
						shadow = 2;
						sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25);
					};
				};
			};

			class controls
			{
				class Left_Column: RscControlsGroupNoScrollbars
				{
					idc = -1;
					x = 0;
					y = 0;
					w = LOADOUT_L_COL_WIDTH;
					h = LOADOUT_HEIGHT;

					class controls
					{
						class Header: RscText {
							idc = -1;
							style = 2 + 192;
							x = 0;
							y = 0;
							w = LOADOUT_L_COL_WIDTH;
							h = LOADOUT_HEADER_HEIGHT;
							colorBackground[] = COLOR_PRIMARY(1.0);
							text = "LOADOUT SELECTION";
							font = "PuristaSemibold";
							sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.35);
							shadow = 2;
						};

						class PrimaryWeaponFrame: WWR_WeaponFrame {
							x = 0;
							y = LOADOUT_HEADER_HEIGHT;

							class controls: controls {
								class Background: Background {};
								class WeaponHeader: WeaponHeader {
									text = "PRIMARY WEAPON";
								};
								class WeaponActivator: WeaponActivator {
									action = "[] call client_fnc_spawnMenu_displayPrimaryWeaponSelection;";
 								};
								class WeaponPicture: WeaponPicture {
									idc = 5;
								};
								class WeaponDescription: WeaponDescription {
									idc = 1005;
								};
							};
						};
						class SecondaryWeaponFrame: WWR_WeaponFrame {
							x = 0;
							y = LOADOUT_HEADER_HEIGHT + LOADOUT_WEAPON_FRAME_HEIGHT + LOADOUT_GUTTER;

							class controls: controls {
								class Background: Background {};
								class WeaponHeader: WeaponHeader {
									text = "SECONDARY WEAPON";
								};
								class WeaponActivator: WeaponActivator {
									action = "[] call client_fnc_spawnMenu_displaySecondaryWeaponSelection;";
								};
								class WeaponPicture: WeaponPicture {
									idc = 7;
								};
								class WeaponDescription: WeaponDescription {
									idc = 1007;
								};
							};
						};
						class PerksSelectionFrame: RscControlsGroupNoScrollbars {
							idc = -1;
							x = 0;
							y = LOADOUT_HEADER_HEIGHT + (LOADOUT_WEAPON_FRAME_HEIGHT + LOADOUT_GUTTER) * 2;
							w = LOADOUT_L_COL_WIDTH;
							h = LOADOUT_PERK_WIDTH * (4/3);

							class WWR_Perk: RscControlsGroupNoScrollbars {
								idc = -1;
								x = 0;
								y = LOADOUT_SMALL_HEADER_HEIGHT;
								w = LOADOUT_PERK_WIDTH;
								h = LOADOUT_PERK_WIDTH * (4/3);

								class controls {
									class Background: RscText {
										idc = -1;
										x = 0;
										y = 0;
										w = LOADOUT_PERK_WIDTH;
										h = LOADOUT_PERK_WIDTH * (4/3);
										colorBackground[] = DARK_COLOR;
									};
									class PerkActivator: RscButtonMenu {
										idc = -1;
										x = 0;
										y = 0;
										w = LOADOUT_PERK_WIDTH;
										h = LOADOUT_PERK_WIDTH * (4/3);
										animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.2)";
										animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
										animTextureOver = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
										animTextureFocused = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
										animTexturePressed = "#(argb,8,8,3)color(0.96,0.65,0.12,0.3)";
										animTextureDefault = "";
										action = "[] call displays_fnc_spawnMenu_handleClassCustomize";
									};
									class PerkImage: RscPictureKeepAspect {
										idc = -1;
										x = (LOADOUT_PERK_WIDTH / 2) - (LOADOUT_PERK_PICTURE_SIZE / 2);
										y = 0;
										w = LOADOUT_PERK_PICTURE_SIZE;
										h = LOADOUT_PERK_PICTURE_SIZE * (4/3);
										text = "";
									};
									class PerkName: RscText {
										idc = -1;
										style = 2 + 16 + 512;
										x = 0;
										y = (LOADOUT_PERK_WIDTH * (4/3)) - (3 * LOADOUT_SMALL_HEADER_HEIGHT);
										w = LOADOUT_PERK_WIDTH;
										h = LOADOUT_HEADER_HEIGHT;
										text = "";
										colorText[] = COLOR_BRIGHT(1.0);
										sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9);
										shadow = 2;
									};
								};
							};

							class controls {
								class PerksHeader: WWR_Loadout_Small_Header {
									text = "PERKS SELECTION";
								};
								class ClassPerk: WWR_Perk {
									x = 0;
									class controls: controls {
										class Background: Background {};
										class PerkActivator: PerkActivator {
											idc = 200;
										};
										class PerkImage: PerkImage {
											idc = 201;
										};
										class PerkName: PerkName {
											idc = 202;
										};
									};
								};
								class SquadPerk: WWR_Perk {
									x = (LOADOUT_L_COL_WIDTH + LOADOUT_GUTTER) / 2;
									class controls: controls {
										class Background: Background {};
										class PerkActivator: PerkActivator {
											idc = 203;
										};
										class PerkImage: PerkImage {
											idc = 204;
										};
										class PerkName: PerkName {
											idc = 205;
										};
									};
								};
							};
						};
					};
				};
				class Right_Column: RscControlsGroupNoScrollbars
				{
					onLoad = "uiNamespace setVariable ['wwr_loadout_right_col', _this select 0]";
					idc = -1;
					x = LOADOUT_L_COL_WIDTH;
					y = 0;
					w = LOADOUT_R_COL_WIDTH;
					h = LOADOUT_HEIGHT;

					class controls
					{
						class weaponSelectionHeader: WWR_Loadout_Small_Header {
							idc = -1;
							x = LOADOUT_GUTTER * (3/4);
							y = LOADOUT_HEADER_HEIGHT;
							w = LOADOUT_R_COL_WIDTH;
							text = "AVAILABLE WEAPONS:";
						};
						class weaponSelectionListbox: RscListbox
						{
							idc = 3;
							x = LOADOUT_GUTTER * (3/4);
							y = LOADOUT_HEADER_HEIGHT + LOADOUT_SMALL_HEADER_HEIGHT;
							w = LOADOUT_R_COL_WIDTH;
							h = (LOADOUT_WEAPON_FRAME_HEIGHT * 2) + LOADOUT_GUTTER - LOADOUT_SMALL_HEADER_HEIGHT;
							colorBackground[] = DARK_COLOR;
							sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
							rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
							wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
							colorSelect[] = {1, 1, 1, 1};
							colorDisabled[] = {1, 0, 0, 1};
							colorText[] = {1, 1, 1, 0.5};
							colorSelect2[] = {1, 1, 1, 1};
							colorSelectBackground[] = PRIMARY_COLOR;
							colorSelectBackground2[] = PRIMARY_COLOR;
							onLBSelChanged = "_this call displays_fnc_spawnMenu_handleWeaponSelect;";
						};
					};
				};
			};
		};
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
			x = 0.340156*safezoneW+safezoneX;
			y = 0.346*safezoneH+safezoneY;
			w = 0.309375*safezoneW;
			h = 0.033*safezoneH;
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

#define CLASS_CUSTOMIZE_WIDTH safeZoneW * 0.66
#define CLASS_CUSTOMIZE_HEIGHT safeZoneH * 0.45
#define CLASS_CUSTOMIZE_COL_WIDTH CLASS_CUSTOMIZE_WIDTH / 2
#define CLASS_CUSTOMIZE_HEADER_HEIGHT safeZoneH * 0.04

class rr_class_customization {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    duration = 999999;

	class WWR_RscListBoxColumn: RscListBox {
		idc = -1;
		x = 0;
		y = CLASS_CUSTOMIZE_HEADER_HEIGHT;
		w = CLASS_CUSTOMIZE_COL_WIDTH;
		h = CLASS_CUSTOMIZE_HEIGHT - CLASS_CUSTOMIZE_HEADER_HEIGHT;
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

	class WWR_RscTextHeaderColumn: RscText {
		idc = -1;
		x = 0;
		y = 0;
		w = CLASS_CUSTOMIZE_COL_WIDTH;
		h = CLASS_CUSTOMIZE_HEADER_HEIGHT;
		style = 192;
		text = "CLASS PERKS";
		colorText[] = COLOR_DARK(1.0);
		shadow = 0;
	};

    class controls {
		class Container: RscControlsGroupNoScrollbars {
			idc = -1;
			x = safeZoneX + safeZoneW / 2 - CLASS_CUSTOMIZE_WIDTH / 2;
			y = safeZoneY + safeZoneH / 2 - CLASS_CUSTOMIZE_HEIGHT / 2;
			w = CLASS_CUSTOMIZE_WIDTH;
			h = CLASS_CUSTOMIZE_HEIGHT;
			class controls {
				class Header_Background: RscText {
					idc = -1;
					x = 0;
					y = 0;
					w = CLASS_CUSTOMIZE_WIDTH;
					h = CLASS_CUSTOMIZE_HEADER_HEIGHT;
					colorBackground[] = COLOR_BRIGHT(1.0);
				};
				class Background: RscText {
					idc = -1;
					x = 0;
					y = CLASS_CUSTOMIZE_HEADER_HEIGHT;
					w = CLASS_CUSTOMIZE_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT - CLASS_CUSTOMIZE_HEADER_HEIGHT;
					colorBackground[] = COLOR_DARK(0.8);
				};
				class Left_Column: RscControlsGroupNoScrollbars {
					idc = -1;
					x = 0;
					y = 0;
					w = CLASS_CUSTOMIZE_COL_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT;

					class controls {
						class Header: WWR_RscTextHeaderColumn {
							text = "CLASS PERKS";
						};
						class lbClassPerks: WWR_RscListBoxColumn
						{
							idc = 0;
						};
					};
				};
				class Right_Column: RscControlsGroupNoScrollbars {
					idc = -1;
					x = CLASS_CUSTOMIZE_COL_WIDTH;
					y = 0;
					w = CLASS_CUSTOMIZE_COL_WIDTH;
					h = CLASS_CUSTOMIZE_HEIGHT;

					class controls {
						class Header: WWR_RscTextHeaderColumn {
							text = "SQUAD PERKS";
						};
						class lbSquadPerks: WWR_RscListBoxColumn
						{
							idc = 1;
						};
					};
				};
			};
		};
		class Return: RscButtonMenu
		{
			idc = 1;
			text = "RETURN"; //--- ToDo: Localize;
			x = safeZoneX + safeZoneW / 2 - CLASS_CUSTOMIZE_WIDTH / 2;
			y = safeZoneY + safeZoneH / 2 + CLASS_CUSTOMIZE_HEIGHT / 2;
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
