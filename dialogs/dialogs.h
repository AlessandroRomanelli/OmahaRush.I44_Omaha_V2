class rr_spawnmenu {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    fadein=2;
    duration = 999999;
    class controls {
  	/* class emptyButton: RscButtonMenu
		{
			idc = 10000;
			text = ""; //--- ToDo: Localize;
			x = 1.1 * safezoneW + safezoneX;
			y = 1.1 * safezoneH + safezoneY;
			w = 1.1 * safezoneW;
			h = 1.1 * safezoneH;
		}; */
		class RscText_1000: RscText
		{
			idc = 207;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class primary_description: RscStructuredText
		{
			idc = 1001;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.4252 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1002: RscText
		{
			idc = 208;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.4945 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.0044 * safezoneH;
			colorBackground[] = {1,1,1,0.8};
		};
		class RscText_1003: RscText
		{
			idc = 209;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.5022 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class secondary_description: RscStructuredText
		{
			idc = 1004;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.6364 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class weaponSelectionBackground: RscText
		{
			idc = 2;
			x = 0.16072 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.259844 * safezoneW;
			h = 0.4114 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class weaponSelectionListbox: RscListbox
		{
			idc = 3;
			x = 0.162782 * safezoneW + safezoneX;
			y = 0.2954 * safezoneH + safezoneY;
			w = 0.255718 * safezoneW;
			h = 0.4026 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.1;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
	    colorText[] = {1, 1, 1, 0.5};
	    colorSelect2[] = {1, 1, 1, 1};
	    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
	    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};
		/*class btnDeploy: RscButtonMenu
		{
			idc = 4;
			text = "DEPLOY"; //--- ToDo: Localize;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.7046 * safezoneH + safezoneY;
			w = 0.159842 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
			sizeEx = 0.04;
		};*/
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
		/*class RscText_1006: RscText
		{
			idc = -1;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.4114 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};*/
		class primaryWeaponSelectionActivator: RscButtonMenu
		{
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
		/* class attachmentsSelectionBackground: RscText
		{
			idc = 25;
			w = 0.458921 * safezoneW;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			x = 0.16072 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			h = 0.4114 * safezoneH;
		};

		class firstAttachment: RscListbox
		{
			idc = 20;
			x = 0.161739 * safezoneW + safezoneX;
			y = 0.326261 * safezoneH + safezoneY;
			w = 0.149536 * safezoneW;
			h = 0.371669 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.1;
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		}; */
		/* class a87954654: RscText
		{
			idc = 27;
			x = 0.160708 * safezoneW + safezoneX;
			y = 0.291074 * safezoneH + safezoneY;
			w = 0.154691 * safezoneW;
			h = 0.0329884 * safezoneH;
			colorBackground[] = {1,1,1,1};
		};
		class a2341234231: RscText
		{
			idc = 28;
			x = 0.314369 * safezoneW + safezoneX;
			y = 0.291074 * safezoneH + safezoneY;
			w = 0.15366 * safezoneW;
			h = 0.0329884 * safezoneH;
			colorBackground[] = {1,1,1,1};
		};
		class a34267545: RscText
		{
			idc = 29;
			x = 0.46803 * safezoneW + safezoneX;
			y = 0.291074 * safezoneH + safezoneY;
			w = 0.151598 * safezoneW;
			h = 0.0329884 * safezoneH;
			colorBackground[] = {1,1,1,1};
		}; */
		/* class secondAttachment: RscListbox
		{
			idc = 21;
			x = 0.3154 * safezoneW + safezoneX;
			y = 0.326261 * safezoneH + safezoneY;
			w = 0.151599 * safezoneW;
			h = 0.371669 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.1;
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};
		class thirdAttachment: RscListbox
		{
			idc = 22;
			x = 0.470093 * safezoneW + safezoneX;
			y = 0.326261 * safezoneH + safezoneY;
			w = 0.148505 * safezoneW;
			h = 0.371669 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.1;
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_1011: RscText
		{
			idc = 23;
			text = "SIGHT"; //--- ToDo: Localize;
			x = 0.166895 * safezoneW + safezoneX;
			y = 0.297672 * safezoneH + safezoneY;
			w = 0.061877 * safezoneW;
			h = 0.0219922 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaMedium";
		};
		class RscText_1012: RscText
		{
			idc = 24;
			text = "MUZZLE"; //--- ToDo: Localize;
			x = 0.319525 * safezoneW + safezoneX;
			y = 0.297672 * safezoneH + safezoneY;
			w = 0.163974 * safezoneW;
			h = 0.0219922 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaMedium";
		};
		class RscText_1013: RscText
		{
			idc = 26;
			text = "SIDE ATTACHMENT"; //--- ToDo: Localize;
			x = 0.474218 * safezoneW + safezoneX;
			y = 0.297672 * safezoneH + safezoneY;
			w = 0.134067 * safezoneW;
			h = 0.0219922 * safezoneH;
			colorText[] = {0,0,0,1};
			shadow = 0;
			font = "PuristaMedium";
		}; */
		/* class RscButtonMenu_2401: RscButtonMenu
		{
			idc = 13;
			text = "CUSTOMIZE"; //--- ToDo: Localize;
			x = 0.0978125 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 12;
			text = "CUSTOMIZE"; //--- ToDo: Localize;
			x = 0.0978121 * safezoneW + safezoneX;
			y = 0.3988 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.0242 * safezoneH;
			colorBackground[] = {0.96,0.65,0.12,0.8};
		}; */

		/* new ui */
		class RscText_1000513: RscText
		{
			idc = 201;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_1001573: RscText
		{
			idc = 202;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,1,1,0.8};
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
			sizeEx = 0.04;
		};
		class RscText_10032353462: RscText
		{
			idc = 203;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.004125 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {1,1,1,0.8};
		};
		class RscText_100412213: RscText
		{
			idc = 204;
			x = 0.555688 * safezoneW + safezoneX;
			y = 0.8564 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.132 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
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

		/* new right side of the gui */
		class RscText_10064324: RscText
		{
			idc = 205;

			x = 0.835156 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.253 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscButtonMenu_24056776: RscButtonMenu
		{
			idc = 100;

			text = "OPEN GROUP MANAGEMENT"; //--- ToDo: Localize;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.5462 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.96,0.65,0.12,0.8};
		};
		class RscText_10057667: RscText
		{
			idc = 206;

			x = 0.835156 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		/*class RscPicture_12006776: RscPicture
		{
			idc = -1;
			text = "pictures\assault.paa";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscText_10066776: RscText
		{
			idc = -1;

			x = 0.835156 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_100976763: RscText
		{
			idc = -1;

			x = 0.835156 * safezoneW + safezoneX;
			y = 0.688 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscText_10097676: RscText
		{
			idc = -1;

			x = 0.835156 * safezoneW + safezoneX;
			y = 0.7435 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class RscPicture_1201667: RscPicture
		{
			idc = 1201;
			text = "pictures\support.paa";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscPicture_12022323: RscPicture
		{
			idc = 1202;
			text = "pictures\assault.paa";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.688 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscPicture_120223235: RscPicture
		{
			idc = 1203;
			text = "pictures\engineer.paa";
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.7435 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class btnDeployMedic: RscButtonMenu
		{
			idc = 201;

			text = "MEDIC"; //--- ToDo: Localize;
			x = 0.866094 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class btnDeploySupport: RscButtonMenu
		{
			idc = 202;

			text = "MACHINE GUNNER"; //--- ToDo: Localize;
			x = 0.866094 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			//colorBackground[] = {0.96,0.65,0.12,0.8};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class btnDeployRcon: RscButtonMenu
		{
			idc = 203;

			text = "RECON"; //--- ToDo: Localize;
			x = 0.866094 * safezoneW + safezoneX;
			y = 0.688 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class btnDeployEngineer: RscButtonMenu
		{
			idc = 204;

			text = "ENGINEER"; //--- ToDo: Localize;
			x = 0.866094 * safezoneW + safezoneX;
			y = 0.7435 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};*/
		class Spawnpoints: RscListbox
		{
			idc = 9;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.253 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.06;
			wholeHeight = 0.06;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};

		class RscButtonMenu_2402: RscButtonMenu
		{
			idc = 301;
			style = "0x02 + 0x0c";
			text = "CUSTOMIZE CLASS ABILITIES"; //--- ToDo: Localize;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
		class deploybutton: RscButtonMenu
		{
			idc = 302;

			text = "DEPLOY"; //--- ToDo: Localize;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.7068 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.044 * safezoneH;
			color[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.96,0.65,0.12,0.8};
			font = "PuristaBold";
			sizeEx = 0.08;
			size = 0.06;
		};
		class classeslistbox: RscListbox
		{
			idc = 300;
			x = 0.835156 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.099 * safezoneH;
			sizeEx = 0.04;
			rowHeight = 0.04;
			wholeHeight = 0.04;
			colorBackground[] = {0.12,0.14,0.16,0.8};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
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
			colorBackground[] = {0.12,0.14,0.16,0.8};
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
			colorBackground[] = {0.12,0.14,0.16,0.8};
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
			sizeEx = 0.05;
			rowHeight = 0.1;
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};
		class lbSquadPerks: RscListbox
		{
			idc = 1;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.308 * safezoneH;
			sizeEx = 0.05;
			rowHeight = 0.1;
			shadow = 2;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
		    colorText[] = {1, 1, 1, 0.5};
		    colorSelect2[] = {1, 1, 1, 1};
		    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
		    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 1;
			text = "RETURN"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.6672 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.12,0.14,0.16,0.8};
		};
	};
};
