class Maps {
	class Environment1 {
    tickets = 100;
    roundTime = 900;

		date[] = {1944,6,6,12,30};
		fog = 0;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_75_Tubes";
					respawnTime = 300;
					positionATL[] = {3295.83,3108.93,0};
					dir = 172;
					script = "";
				};
			};
			class Defender {/*
				class defend_tank {
					displayName = "PzKpfW V Ausf. A Panther";
					classname = "LIB_PzKpfwV";
					respawnTime = 150;
					positionATL[] = {2442.69,1991.22,0};
					dir = 59;
					script = "_vehicle setAmmo [""missiles_DAR"", 0];_vehicle setAmmo [""M134_minigun"", 2000];";
				};*/
			};
		};

		class Stages {
			class Stage1 {
				class Spawns {
					defenders[] = {3791.36,2659.82,0};
					attackers[] = {3290.68,3119.68,0};
				};
				class Objective {
					positionATL[] = {3876.55,2839.54,0.493347};
					dir = 185;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_1_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 60;
							positionATL[] = {3263.32,3112.22,0};
							dir = 163;
							script = "";
						};
						class a_car_1_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3285.9,3111.23,0};
							dir = 196;
							script = "";
						};
						class a_car_1_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3288.24,3110.57,0};
							dir = 196;
							script = "";
						};
						class a_car_1_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3290.67,3109.86,0};
							dir = 196;
							script = "";
						};
					};
					class Defender {
						class d_truck_1_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {3802.88,2661.71,0};
							dir = 272;
							script = "";
						};
						class d_truck_1_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {3802.74,2657.74,0};
							dir = 272;
							script = "";
						};
					};
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {3510.1,2182.14,0};
					attackers[] = {3800.27,2845.98,0};
				};
				class Objective {
					positionATL[] = {3464.06,2322.56,0.413357};
					dir = 210;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_2_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3788.83,2848.6,0};
							dir = 134;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3780.94,2842.25,0};
							dir = 134;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3783.06,2844.42,0};
							dir = 134;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3785.17,2846.58,0};
							dir = 134;
							script = "";
						};
					};
					class Defender {
						class d_car_2_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {3500.13,2184.07,0.212822};
							dir = 281;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {3499.29,2180.79,0.277283};
							dir = 300;
							script = "";
						};
					};
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {2918.24,2168.87,0};
					attackers[] = {3398.22,2361.33,0};
				};
				class Objective {
					positionATL[] = {3112.5,2155.75,0};
					dir = 174;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_3_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3390.35,2349.8,0};
							dir = 134;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3391.59,2352.8,0};
							dir = 134;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3393.71,2354.97,0};
							dir = 134;
							script = "";
						};
						class a_car_3_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3395.82,2357.13,0};
							dir = 134;
							script = "";
						};
					};
					class Defender {
						class d_car_3_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {2958,2162.25,0};
							dir = 162;
							script = "";
						};
						class d_car_3_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {2961.5,2162.75,0};
							dir = 170;
							script = "";
						};
					};
				};
			};
			class Stage4 {
				class Spawns {
					defenders[] = {2622.98,2002.16,0};
					attackers[] = {3107.8,2149.14,0};
				};
				class Objective {
					positionATL[] = {2698.49,2144.07,1.3528};
					dir = 309;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_4_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3090.37,2187.6,0};
							dir = 267;
							script = "";
						};
						class a_truck_4_2 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3090.51,2183.62,0};
							dir = 267;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3091.78,2180.57,0};
							dir = 267;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3091.89,2177.55,0};
							dir = 267;
							script = "";
						};
						class a_car_4_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3092,2174.53,0};
							dir = 267;
							script = "";
						};
					};
					class Defender {
						class d_car_4_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {2669.09,2034.4,0};
							dir = 342;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {2665.53,2033.9,0};
							dir = 342;
							script = "";
						};
					};
				};
			};
		};
	};
};
