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
