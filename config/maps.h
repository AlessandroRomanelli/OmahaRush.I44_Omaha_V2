class Maps {
	class Environment1 {
    tickets = 200;
    roundTime = 900;

		date[] = {1944,6,6,12,30};
		fog = 0;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
			};
			class Defender {
			};
		};

		class Stages {
			class Stage1 {
				class Spawns {
					defenders[] = {3791.36,2659.82,0};
					attackers[] = {3305.7,3098.55,0};
				};
				class Area {
					class Attacker {
						positionATL[] = {3643.392,2957.969,-0.826612};
						area[] = {224.602, 402.396, 90, true, -1};
					};
					class Defender {
						positionATL[] = {3794.49,2794.18,-21.1509};
						area[] = {238.024, 237.028, 0, true, -1};
					};
				};
				class Objective {
					positionATL[] = {3876.55,2839.54,0.493347};
					dir = 185;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_htank_1_1 {
							displayName = "M4A3 Sherman";
							classname = "LIB_M4A3_76";
							respawnTime = 300;
							positionATL[] = {3296.32,3106.73,0.461218};
							dir = 171;
							script = "";
						};
						class a_ltank_1_1 {
							displayName = "M3 Stuart";
							classname = "LIB_M3A3_Stuart";
							respawnTime = 150;
							positionATL[] = {3282.61,3105.24,0.711};
							dir = 171;
							script = "";
						};
						class a_car_1_1 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3323.94,3078.71,0.603941};
							dir = 247;
							script = "";
						};
						class a_car_1_2 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3322.03,3083.14,0.606327};
							dir = 247;
							script = "";
						};
						class a_car_1_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3320.26,3087.99,0.38327};
							dir = 247;
							script = "";
						};
						class a_car_1_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3319.12,3090.68,0.493919};
							dir = 247;
							script = "";
						};
						class a_car_1_5 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3317.8,3093.75,0.395409};
							dir = 247;
							script = "";
						};
						class a_car_1_6 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3316.66,3096.46,0.344191};
							dir = 247;
							script = "";
						};
					};
					class Defender {
						class d_htank_1_1 {
							displayName = "PzKpfW VI 'Tiger I'";
							classname = "LIB_PzKpfwVI_E_2";
							respawnTime = 300;
							positionATL[] = {3777.16,2636.84,0};
							dir = 0;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Body_Tarn52c_co.paa']; _this select 0 setObjectTextureGlobal [2, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Turret_Tarn52c_co.paa']";
						};
						class d_truck_1_1 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {3767.01,2640.85,0};
							dir = 9;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_truck_1_2 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {3762.1,2641.67,0};
							dir = 9;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_car_1_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3760.03,2665.06,0};
							dir = 155;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_1_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3756.39,2663.41,0};
							dir = 155;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_1_3 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3752.89,2661.87,0};
							dir = 155;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_1_4 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3749.24,2660.21,0};
							dir = 155;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
					};
				};
			};
			class Stage2 {
				class Area {
					class Attacker {
						positionATL[] = {3651.9,2589.97,-1.60787};
						area[] = {266.491, 343.957, 180, true, -1};
					};
					class Defender {
						positionATL[] = {3411.07,2331.43,-1.20778};
						area[] = {189.664, 219.483, 75, true, -1};
					};
				};
				class Spawns {
					defenders[] = {3261,2148.77,0};
					attackers[] = {3809.26,2861.61,0};
				};
				class Objective {
					positionATL[] = {3464.06,2322.56,0.413357};
					dir = 210;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_htank_2_1 {
							displayName = "M4A3 Sherman";
							classname = "LIB_M4A3_76";
							respawnTime = 300;
							positionATL[] = {3806.92,2846.21,0};
							dir = 182;
							script = "";
						};
						class a_ltank_2_1 {
							displayName = "M3 Stuart";
							classname = "LIB_M3A3_Stuart";
							respawnTime = 150;
							positionATL[] = {3793.15,2847.2,0};
							dir = 182;
							script = "";
						};
						class a_car_2_1 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3779.34,2840.95,3.8147e-006};
							dir = 151;
							script = "";
						};
						class a_car_2_2 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3775.11,2838.07,3.8147e-006};
							dir = 151;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3769.39,2820.95,0};
							dir = 84;
							script = "";
						};
						class a_car_2_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3769.25,2817.72,0};
							dir = 84;
							script = "";
						};
						class a_car_2_5 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3769.59,2814.4,0};
							dir = 84;
							script = "";
						};
						class a_car_2_6 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3769.91,2811.49,0};
							dir = 84;
							script = "";
						};
					};
					class Defender {
						class d_htank_2_1 {
							displayName = "PzKpfW VI 'Tiger I'";
							classname = "LIB_PzKpfwVI_E_2";
							respawnTime = 300;
							positionATL[] = {3237.1,2131.24,0};
							dir = 255;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Body_Tarn52c_co.paa']; _this select 0 setObjectTextureGlobal [2, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Turret_Tarn52c_co.paa']";
						};
						class d_truck_2_1 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {3252.42,2162.41,0};
							dir = 13;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_truck_2_2 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {3257.3,2161.23,0};
							dir = 13;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_car_2_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3257.14,2137.18,0};
							dir = 87;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3257.32,2133.19,0};
							dir = 87;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_2_3 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3257.51,2129.48,0};
							dir = 87;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_2_4 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {3257.62,2125.5,0.0168953};
							dir = 87;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
					};
				};
			};
			class Stage3 {
				class Area {
					class Attacker {
						positionATL[] = {3322.27,2183.54,0.0183372};
						area[] = {188.661, 228.128, 270, true, -1};
					};
					class Defender {
						positionATL[] = {2981.66,2138.46,0.241001};
						area[] = {217.547, 150.45399, 270, true, -1};
					};
				};
				class Spawns {
					defenders[] = {2823.85,2052.54,0};
					attackers[] = {3384.33,2346.33,0};
				};
				class Objective {
					positionATL[] = {3112.5,2155.75,0};
					dir = 174;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_htank_3_1 {
							displayName = "M4A3 Sherman";
							classname = "LIB_M4A3_76";
							respawnTime = 300;
							positionATL[] = {3390.27,2340.19,0};
							dir = 100;
							script = "";
						};
						class a_ltank_3_1 {
							displayName = "M3 Stuart";
							classname = "LIB_M3A3_Stuart";
							respawnTime = 150;
							positionATL[] = {3388.37,2326.39,0};
							dir = 100;
							script = "";
						};
						class a_car_3_1 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3378.75,2352.69,0};
							dir = 243;
							script = "";
						};
						class a_car_3_2 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3376.46,2357.02,0};
							dir = 243;
							script = "";
						};
						class a_car_3_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3374.37,2361.79,0};
							dir = 243;
							script = "";
						};
						class a_car_3_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3373.05,2364.39,0};
							dir = 243;
							script = "";
						};
						class a_car_3_5 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3371.55,2367.28,0};
							dir = 243;
							script = "";
						};
						class a_car_3_6 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3370.22,2369.9,0};
							dir = 243;
							script = "";
						};
					};
					class Defender {
						class d_htank_3_1 {
							displayName = "PzKpfW VI 'Tiger I'";
							classname = "LIB_PzKpfwVI_E_2";
							respawnTime = 300;
							positionATL[] = {2879.01,2043.61,0};
							dir = 268;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Body_Tarn52c_co.paa']; _this select 0 setObjectTextureGlobal [2, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Turret_Tarn52c_co.paa']";
						};
						class d_htank_3_2 {
							displayName = "PzKpfW VI 'Tiger I'";
							classname = "LIB_PzKpfwVI_E_2";
							respawnTime = 300;
							positionATL[] = {2857.98,2042.17,0};
							dir = 88;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Body_Tarn52c_co.paa']; _this select 0 setObjectTextureGlobal [2, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Turret_Tarn52c_co.paa']";
						};
						class d_truck_3_1 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {2827.11,2065.36,0};
							dir = 90;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_truck_3_2 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {2827.17,2059.36,0};
							dir = 90;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_car_3_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2845.97,2051.8,0.613754};
							dir = 0;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_3_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2841.92,2051.83,0.262367};
							dir = 0;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_3_3 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2838.21,2051.88,0.0939941};
							dir = 0;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_3_4 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2834.12,2051.83,0};
							dir = 0;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
					};
				};
			};
			class Stage4 {
				class Area {
					class Attacker {
						positionATL[] = {2899.94,2124.63,1.35673};
						area[] = {165.686, 252.032, 270, true, -1};
					};
					class Defender {
						positionATL[] = {2650.23,2097.36,1.56832};
						area[] = {177.752, 249.534, 270, true, -1};
					};
				};
				class Spawns {
					defenders[] = {2622.98,2002.16,0};
					attackers[] = {3111.25,2168.77,0};
				};
				class Objective {
					positionATL[] = {2698.49,2144.07,1.3528};
					dir = 309;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_htank_4_1 {
							displayName = "M4A3 Sherman";
							classname = "LIB_M4A3_76";
							respawnTime = 300;
							positionATL[] = {3086.73,2141.37,0};
							dir = 358;
							script = "";
						};
						class a_ltank_4_1 {
							displayName = "M3 Stuart";
							classname = "LIB_M3A3_Stuart";
							respawnTime = 150;
							positionATL[] = {3073.15,2140.19,0};
							dir = 358;
							script = "";
						};
						class a_car_4_1 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3090.56,2175,0};
							dir = 270;
							script = "";
						};
						class a_car_4_2 {
							displayName = "M3 Scout Car";
							classname = "LIB_US_Scout_M3_FFV";
							respawnTime = 60;
							positionATL[] = {3090.53,2179.82,0};
							dir = 270;
							script = "";
						};
						class a_car_4_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3090.78,2185.07,0};
							dir = 270;
							script = "";
						};
						class a_car_4_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3090.82,2187.97,0};
							dir = 270;
							script = "";
						};
						class a_car_4_5 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3090.83,2191.3,0};
							dir = 270;
							script = "";
						};
						class a_car_4_6 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 5;
							positionATL[] = {3090.83,2194.24,0};
							dir = 270;
							script = "";
						};
					};
					class Defender {
						class d_htank_4_1 {
							displayName = "PzKpfW VI 'Tiger I'";
							classname = "LIB_PzKpfwVI_E_2";
							respawnTime = 300;
							positionATL[] = {2467.74,1992.85,0};
							dir = 326;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Body_Tarn52c_co.paa']; _this select 0 setObjectTextureGlobal [2, 'WW2\Assets_t\Vehicles\Tanks_t\IF_PzKpfwVI_E\Turret_Tarn52c_co.paa']";
						};
						class d_truck_4_1 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {2431.81,2016.96,0.0039444};
							dir = 330;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_truck_4_2 {
							displayName = "SdKfz 251 MG42";
							classname = "LIB_SdKfz251_FFV";
							respawnTime = 60;
							positionATL[] = {2426.65,2013.89,0};
							dir = 330;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Hull_Feldgrau_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\WheeledAPC_t\IF_SdKfz251\Interrior_co.paa']";
						};
						class d_car_4_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2424.6,2004.97,0};
							dir = 241;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2426.5,2001.37,0};
							dir = 241;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_4_3 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2428.17,1998.03,0};
							dir = 241;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
						class d_car_4_4 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1_Hood";
							respawnTime = 5;
							positionATL[] = {2430.27,1994.49,0};
							dir = 241;
							script = "_this select 0 setObjectTextureGlobal [0, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Main_Sernyt_co.paa']; _this select 0 setObjectTextureGlobal [1, 'WW2\Assets_t\Vehicles\Cars_t\IF_Kfz1\Kubelwagen_Interior_Sernyt_co.paa']";
						};
					};
				};
			};
		};
	};
};
