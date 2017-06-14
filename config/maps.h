class Maps {
	class N_Environment1 {
    tickets = 75;
    roundTime = 900;

		date[] = {1944,6,6,1,30};
		fog = 0.3;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_75";
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

	class B_Environment1 {
    tickets = 75;
    roundTime = 900;

		date[] = {1944,6,6,12,30};
		fog = 0.35;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_75";
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

	class N_Environment2 {
    tickets = 75;
    roundTime = 900;

		date[] = {1944,6,6,1,30};
		fog = 0.3;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_75";
					respawnTime = 300;
					positionATL[] = {805.884,4526.01,0};
					dir = 283;
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
					defenders[] = {766.257,3848.02,0};
					attackers[] = {790.748,4525.7,0};
				};
				class Objective {
					positionATL[] = {654.222,4035.35,0.816204};
					dir = 337;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_1_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 60;
							positionATL[] = {806.893,4530.11,0};
							dir = 283;
							script = "";
						};
						class a_car_1_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {807.991,4534.57,0};
							dir = 283;
							script = "";
						};
						class a_car_1_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {808.688,4537.4,0};
							dir = 283;
							script = "";
						};
						class a_car_1_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {809.406,4540.32,0};
							dir = 283;
							script = "";
						};
						class a_car_1_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {810.134,4543.25,0};
							dir = 283;
							script = "";
						};
					};
					class Defender {
						class d_car_1_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {750.689,3847.11,0};
							dir = 261;
							script = "";
						};
						class d_car_1_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {751.119,3844.65,0};
							dir = 261;
							script = "";
						};
					};
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {964.497,3301.1,0};
					attackers[] = {648.743,4052.09,0};
				};
				class Objective {
					positionATL[] = {839.481,3389.73,3.8147e-006};
					dir = 68;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_2_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {631.09,4035.07,0};
							dir = 116;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {629.118,4030.94,0};
							dir = 116;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {627.853,4028.32,0};
							dir = 116;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {626.553,4025.63,0};
							dir = 116;
							script = "";
						};
						class a_car_2_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {625.259,4022.94,0};
							dir = 116;
							script = "";
						};
					};
					class Defender {
						class d_car_2_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {959.621,3315.96,0};
							dir = 6;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {962.589,3315.66,0};
							dir = 6;
							script = "";
						};
					};
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {1147.99,3671.07,0};
					attackers[] = {811.789,3354.12,0};
				};
				class Objective {
					positionATL[] = {1151.99,3514.35,0.858425};
					dir = 6;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_3_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {837.131,3350.55,0};
							dir = 319;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {833.368,3350.31,0};
							dir = 319;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {831.176,3348.35,0};
							dir = 319;
							script = "";
						};
						class a_car_3_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {834.05,3344.96,0};
							dir = 319;
							script = "";
						};
						class a_car_3_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {836.309,3346.93,0};
							dir = 319;
							script = "";
						};
					};
					class Defender {
						class d_car_3_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1136.34,3673.18,0};
							dir = 292;
							script = "";
						};
						class d_car_3_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1137.46,3675.94,0};
							dir = 292;
							script = "";
						};
					};
				};
			};
			class Stage4 {
				class Spawns {
					defenders[] = {1554.55,3312.7,0};
					attackers[] = {1173.44,3528.52,0};
				};
				class Objective {
					positionATL[] = {1436.77,3314.95,-3.8147e-006};
					dir = 68;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_4_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {1173.38,3536.04,0};
							dir = 80;
							script = "";
						};
						class a_truck_4_2 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {1172.84,3539.02,0};
							dir = 80;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {1172.04,3543.52,0};
							dir = 80;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {1174.2,3531.61,0};
							dir = 80;
							script = "";
						};
					};
					class Defender {
						class d_car_4_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1552.88,3324.06,3.05176e-005};
							dir = 360;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1555.86,3324.05,-0.0305634};
							dir = 360;
							script = "";
						};
					};
				};
			};
		};
	};

	class B_Environment2 {
    tickets = 75;
    roundTime = 900;

		date[] = {1944,6,6,12,30};
		fog = 0.35;
		rain = 1;
		overcast = 1;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_75";
					respawnTime = 300;
					positionATL[] = {805.884,4526.01,0};
					dir = 283;
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
					defenders[] = {766.257,3848.02,0};
					attackers[] = {790.748,4525.7,0};
				};
				class Objective {
					positionATL[] = {654.222,4035.35,0.816204};
					dir = 337;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_1_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 60;
							positionATL[] = {806.893,4530.11,0};
							dir = 283;
							script = "";
						};
						class a_car_1_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {807.991,4534.57,0};
							dir = 283;
							script = "";
						};
						class a_car_1_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {808.688,4537.4,0};
							dir = 283;
							script = "";
						};
						class a_car_1_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {809.406,4540.32,0};
							dir = 283;
							script = "";
						};
						class a_car_1_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {810.134,4543.25,0};
							dir = 283;
							script = "";
						};
					};
					class Defender {
						class d_car_1_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {750.689,3847.11,0};
							dir = 261;
							script = "";
						};
						class d_car_1_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {751.119,3844.65,0};
							dir = 261;
							script = "";
						};
					};
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {964.497,3301.1,0};
					attackers[] = {648.743,4052.09,0};
				};
				class Objective {
					positionATL[] = {839.481,3389.73,3.8147e-006};
					dir = 68;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_2_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {631.09,4035.07,0};
							dir = 116;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {629.118,4030.94,0};
							dir = 116;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {627.853,4028.32,0};
							dir = 116;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {626.553,4025.63,0};
							dir = 116;
							script = "";
						};
						class a_car_2_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {625.259,4022.94,0};
							dir = 116;
							script = "";
						};
					};
					class Defender {
						class d_car_2_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {959.621,3315.96,0};
							dir = 6;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {962.589,3315.66,0};
							dir = 6;
							script = "";
						};
					};
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {1147.99,3671.07,0};
					attackers[] = {811.789,3354.12,0};
				};
				class Objective {
					positionATL[] = {1151.99,3514.35,0.858425};
					dir = 6;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_3_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {837.131,3350.55,0};
							dir = 319;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {833.368,3350.31,0};
							dir = 319;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {831.176,3348.35,0};
							dir = 319;
							script = "";
						};
						class a_car_3_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {834.05,3344.96,0};
							dir = 319;
							script = "";
						};
						class a_car_3_4 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {836.309,3346.93,0};
							dir = 319;
							script = "";
						};
					};
					class Defender {
						class d_car_3_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1136.34,3673.18,0};
							dir = 292;
							script = "";
						};
						class d_car_3_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1137.46,3675.94,0};
							dir = 292;
							script = "";
						};
					};
				};
			};
			class Stage4 {
				class Spawns {
					defenders[] = {1554.55,3312.7,0};
					attackers[] = {1173.44,3528.52,0};
				};
				class Objective {
					positionATL[] = {1436.77,3314.95,-3.8147e-006};
					dir = 68;
					classname = "LIB_Static_opelblitz_radio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_4_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {1173.38,3536.04,0};
							dir = 80;
							script = "";
						};
						class a_truck_4_2 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {1172.84,3539.02,0};
							dir = 80;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {1172.04,3543.52,0};
							dir = 80;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {1174.2,3531.61,0};
							dir = 80;
							script = "";
						};
					};
					class Defender {
						class d_car_4_1 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1552.88,3324.06,3.05176e-005};
							dir = 360;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen";
							classname = "LIB_Kfz1";
							respawnTime = 30;
							positionATL[] = {1555.86,3324.05,-0.0305634};
							dir = 360;
							script = "";
						};
					};
				};
			};
		};
	};
};
