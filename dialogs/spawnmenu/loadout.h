#include "constants.h"

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
