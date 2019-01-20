class rr_spawnmenu {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    fadein=2;
    duration = 999999;
    class controls {
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
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 5)";
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {1, 1, 1, 1};
	    colorText[] = {1, 1, 1, 0.5};
	    colorSelect2[] = {1, 1, 1, 1};
	    colorSelectBackground[] = {0.96,0.65,0.12,0.8};
	    colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
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
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.5)";
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

    class GroupsButton: RscButtonMenu
    {
    	idc = 100;
      size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
      font = "PuristaBold";
    	text = "VIEW GROUPS"; //--- ToDo: Localize;
      x = 0.835115 * safezoneW + safezoneX;
    	y = 0.170863 * safezoneH + safezoneY;
      w = 0.159844 * safezoneW;
    	h = 0.044 * safezoneH;
      color[] = {0,0,0,1};
      colorText[] = {0,0,0,1};
    	colorBackground[] = {0.96,0.65,0.12,0.8};
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
    class customizeClassButton: RscButtonMenu
    {
    	idc = 301;
    	style = "0x02 + 0x0c";

    	text = "CUSTOMIZE CLASS ABILITIES"; //--- ToDo: Localize;
    	x = 0.835115 * safezoneW + safezoneX;
    	y = 0.664757 * safezoneH + safezoneY;
    	w = 0.159844 * safezoneW;
    	h = 0.0219999 * safezoneH;
    	colorText[] = {1,1,1,1};
    	colorBackground[] = {0.12,0.14,0.16,0.8};
    };
    class deploybutton: RscButtonMenu
    {
    	idc = 302;
    	color[] = {0,0,0,1};
    	font = "PuristaBold";
    	size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";
    	text = "DEPLOY"; //--- ToDo: Localize;
      x = 0.835115 * safezoneW + safezoneX;
    	y = 0.69184 * safezoneH + safezoneY;
    	w = 0.159844 * safezoneW;
    	h = 0.044 * safezoneH;
    	colorText[] = {0,0,0,1};
    	colorBackground[] = {0.96,0.65,0.12,0.8};
    };
    class ClassHeader: RscText
    {
      idc = -1;

      text = "CLASSES"; //--- ToDo: Localize;
      x = 0.834939 * safezoneW + safezoneX;
    	y = 0.54702 * safezoneH + safezoneY;
    	w = 0.158655 * safezoneW;
    	h = 0.0188079 * safezoneH;
      colorBackground[] = {0.96,0.65,0.12,0.8};
    };
    class Classes: RscListBox
    {
    	idc = 300;
    	sizeEx = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
    	rowHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
    	wholeHeight = "1.00 *		 (pixelH * pixelGridNoUIScale * 1.6)";
    	x = 0.834939 * safezoneW + safezoneX;
    	y = 0.565828 * safezoneH + safezoneY;
    	w = 0.159844 * safezoneW;
    	h = 0.099 * safezoneH;
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
    class RscText_1200: RscText
    {
      idc = 1200;
      x = 0.402031 * safezoneW + safezoneX;
      y = 0.082 * safezoneH + safezoneY;
      w = 0.190781 * safezoneW;
      h = 0.066 * safezoneH;
      colorBackground[] = {0.12,0.14,0.16,0.8};
    };
    class RscPicture_1201: RscPicture
    {
      idc = 1201;
      text = "";
      x = 0.407187 * safezoneW + safezoneX;
      y = 0.093 * safezoneH + safezoneY;
      w = 0.0257812 * safezoneW;
      h = 0.044 * safezoneH;
    };
    class RscPicture_1202: RscPicture
    {
      idc = 1202;
      text = "";
      x = 0.45875 * safezoneW + safezoneX;
      y = 0.093 * safezoneH + safezoneY;
      w = 0.0257812 * safezoneW;
      h = 0.044 * safezoneH;
    };
    class RscPicture_1203: RscPicture
    {
      idc = 1203;
      text = "";
      x = 0.510312 * safezoneW + safezoneX;
      y = 0.093 * safezoneH + safezoneY;
      w = 0.0257812 * safezoneW;
      h = 0.044 * safezoneH;
    };
    class RscPicture_1204: RscPicture
    {
      idc = 1204;
      text = "";
      x = 0.561875 * safezoneW + safezoneX;
      y = 0.093 * safezoneH + safezoneY;
      w = 0.0257812 * safezoneW;
      h = 0.044 * safezoneH;
    };
    class SpawnHeader: RscText
    {
    	idc = -1;

    	text = "SPAWN POINTS"; //--- ToDo: Localize;
      x = 0.834939 * safezoneW + safezoneX;
    	y = 0.246094 * safezoneH + safezoneY;
    	w = 0.158655 * safezoneW;
    	h = 0.0188079 * safezoneH;
    	colorBackground[] = {0.96,0.65,0.12,0.8};
    };
    class VehiclesHeader: RscText
    {
    	idc = -1;

    	text = "VEHICLES"; //--- ToDo: Localize;
      x = 0.834939 * safezoneW + safezoneX;
    	y = 0.396557 * safezoneH + safezoneY;
    	w = 0.158655 * safezoneW;
    	h = 0.0188079 * safezoneH;
    	colorBackground[] = {0.96,0.65,0.12,0.8};
    };
    class Spawnpoints: RscListBox
    {
    	idc = 8;
      x = 0.834939 * safezoneW + safezoneX;
    	y = 0.264902 * safezoneH + safezoneY;
    	w = 0.158655 * safezoneW;
    	h = 0.131655 * safezoneH;
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.75)";
      rowHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
      wholeHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
      colorBackground[] = {0.12,0.14,0.16,0.8};
      colorSelect[] = {1, 1, 1, 1};
      colorText[] = {1, 1, 1, 0.5};
      colorSelect2[] = {1, 1, 1, 1};
      colorSelectBackground[] = {0.96,0.65,0.12,0.8};
      colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
    };
    class Vehicles: RscListBox
    {
    	idc = 9;
      x = 0.834939 * safezoneW + safezoneX;
    	y = 0.415365 * safezoneH + safezoneY;
    	w = 0.158655 * safezoneW;
    	h = 0.131655 * safezoneH;
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 1.75)";
      rowHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
      wholeHeight = "0.60 *     (pixelH * pixelGridNoUIScale * 2.5)";
      colorBackground[] = {0.12,0.14,0.16,0.8};
      colorSelect[] = {1, 1, 1, 1};
      colorText[] = {1, 1, 1, 0.5};
      colorSelect2[] = {1, 1, 1, 1};
      colorSelectBackground[] = {0.96,0.65,0.12,0.8};
      colorSelectBackground2[] = {0.96,0.65,0.12,0.8};
    };
    class AbortButton: RscButtonMenu
    {
    	idc = 303;
    	color[] = {1,1,1,1};
    	font = "PuristaBold";
    	size = "1.00 *		 (pixelH * pixelGridNoUIScale * 2.5)";

    	text = "QUIT"; //--- ToDo: Localize;
    	x = 0.0064056 * safezoneW + safezoneX;
    	y = 0.0109959 * safezoneH + safezoneY;
    	w = 0.154556 * safezoneW;
    	h = 0.044 * safezoneH;
    	colorText[] = {1,1,1,1};
    	colorBackground[] = {0.12,0.14,0.16,0.8};
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
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
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
      sizeEx = "1.00 *     (pixelH * pixelGridNoUIScale * 2)";
      rowHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
      wholeHeight = "1.00 *     (pixelH * pixelGridNoUIScale * 3.5)";
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
