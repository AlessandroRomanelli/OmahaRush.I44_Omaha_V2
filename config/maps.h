class Maps {
	/*class TestingEnvironment {
		tickets = 100;

		class Stages {
			class Stage1 {
				class Spawns {
					defenders[] = {8559.26,11433.3,0.00109863};
					attackers[] = {8142.21,10590.3,0.00143433};
				};
				class Objective {
					positionATL[] = {8256.23,11154.5,1.37199};
					dir = 3.656;
					classname = "Land_DataTerminal_01_F";
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {8684.14,12406.4,0.0015564};
					attackers[] = {9116.5,11204.2,0.00122833};
				};
				class Objective {
					positionATL[] = {8864.77,11949.1,0.289886};
					dir = 146.224;
					classname = "Land_DataTerminal_01_F";
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {7964.54,12437.2,0.00177002};
					attackers[] = {8850.74,11931.5,0.00143433};
				};
				class Objective {
					positionATL[] = {8141.48,12010.1,2.67311};
					dir = 209.1677;
					classname = "Land_DataTerminal_01_F";
				};
			};
		};
	};*/

	class TestingEnvironment1 {
		tickets = 100;
		roundTime = 600;

		date[] = {1944,6,6,18,7};
		fog = 0;
		rain = 0;
		overcast = 0;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_76";
					respawnTime = 150;
					positionATL[] = {3295.83,3108.93,0};
					dir = 172;
					script = "_vehicle setAmmo [""LIB_M42A1_M1_HE"", 0];";
				};
			};
			class Defender {
				class defend_tank {
					displayName = "PzKpfW V Ausf. A Panther";
					classname = "LIB_PzKpfwV";
					respawnTime = 150;
					positionATL[] = {2442.69,1991.22,0};
					dir = 59;
					/*script = "_vehicle setAmmo [""missiles_DAR"", 0];_vehicle setAmmo [""M134_minigun"", 2000];";*/
				};
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
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3802.88,2661.71,0};
							dir = 272;
							script = "";
						};
						class d_truck_1_2 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
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
					attackers[] = {3789.66,2660.17,0};
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
							positionATL[] = {3762.06,2666.23,0};
							dir = 163;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3770.29,2667.56,0};
							dir = 180;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3772.83,2667.6,0};
							dir = 180;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3775.35,2667.61,0};
							dir = 180;
							script = "";
						};
					};
					class Defender {
						class d_truck_2_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3502.01,2188.14,0.32943};
							dir = 284;
							script = "";
						};
						class d_car_2_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {3500.13,2184.07,0.212822};
							dir = 281;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
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
					attackers[] = {3472.72,2315.33,0};
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
							positionATL[] = {3482.5,2311.75,0};
							dir = 94;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3479.5,2318.5,0};
							dir = 83;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3480,2325,0};
							dir = 98;
							script = "";
						};
					};
					class Defender {
						class d_truck_3_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2954.25,2166.25,0};
							dir = 178;
							script = "";
						};
						class d_car_3_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
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
					attackers[] = {2981.77,2180.17,0};
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
							positionATL[] = {2987.25,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2990.25,2144.02,0};
							dir = 0;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2993,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2995,2144,0};
							dir = 0;
							script = "";
						};
					};
					class Defender {
						class d_truck_4_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2672.87,2030.38,0};
							dir = 357;
							script = "";
						};
						class d_car_4_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {2669.09,2034.4,0};
							dir = 342;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {2665.53,2033.9,0};
							dir = 342;
							script = "";
						};
					};
				};
			};
		};
	};

	class TestingEnvironment2 {
		tickets = 100;
		roundTime = 600;

		date[] = {1944,6,6,18,7};
		fog = 0;
		rain = 0;
		overcast = 0;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_76";
					respawnTime = 150;
					positionATL[] = {3295.83,3108.93,0};
					dir = 172;
					script = "_vehicle setAmmo [""LIB_M42A1_M1_HE"", 0];";
				};
			};
			class Defender {
				class defend_tank {
					displayName = "PzKpfW V Ausf. A Panther";
					classname = "LIB_PzKpfwV";
					respawnTime = 150;
					positionATL[] = {2442.69,1991.22,0};
					dir = 59;
					/*script = "_vehicle setAmmo [""missiles_DAR"", 0];_vehicle setAmmo [""M134_minigun"", 2000];";*/
				};
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
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3802.88,2661.71,0};
							dir = 272;
							script = "";
						};
						class d_truck_1_2 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3802.74,2657.74,0};
							dir = 272;
							script = "";
						};
					};
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {3416.85,2251.48,0};
					attackers[] = {3789.66,2660.17,0};
				};
				class Objective {
					positionATL[] = {3454.89,2363.04,3.61034};
					dir = 337;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_2_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3762.06,2666.23,0};
							dir = 163;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3770.29,2667.56,0};
							dir = 180;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3772.83,2667.6,0};
							dir = 180;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3775.35,2667.61,0};
							dir = 180;
							script = "";
						};
					};
					class Defender {
						class d_truck_2_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3502.01,2188.14,0.32943};
							dir = 284;
							script = "";
						};
						class d_car_2_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {3500.13,2184.07,0.212822};
							dir = 281;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {3499.29,2180.79,0.277283};
							dir = 300;
							script = "";
						};
					};
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {2984.47,2162.72,0};
					attackers[] = {3472.72,2315.33,0};
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
							positionATL[] = {3482.5,2311.75,0};
							dir = 94;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3479.5,2318.5,0};
							dir = 83;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3480,2325,0};
							dir = 98;
							script = "";
						};
					};
					class Defender {
						class d_truck_3_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2954.25,2166.25,0};
							dir = 178;
							script = "";
						};
						class d_car_3_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
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
					defenders[] = {2682.64,2052.73,0};
					attackers[] = {2981.77,2180.17,0};
				};
				class Objective {
					positionATL[] = {2669,2145.5,12.29};
					dir = 309;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_4_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {2987.25,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2990.25,2144.02,0};
							dir = 0;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2993,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2995,2144,0};
							dir = 0;
							script = "";
						};
					};
					class Defender {
						class d_truck_4_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2672.87,2030.38,0};
							dir = 357;
							script = "";
						};
						class d_car_4_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {2669.09,2034.4,0};
							dir = 342;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {2665.53,2033.9,0};
							dir = 342;
							script = "";
						};
					};
				};
			};
		};
	};

	class TestingEnvironment3 {
		tickets = 100;
		roundTime = 600;

		date[] = {1944,6,6,18,7};
		fog = 0;
		rain = 0;
		overcast = 0;

		class PersistentVehicles {
			class Attacker {
				class attack_tank {
					displayName = "M4A3 Sherman";
					classname = "LIB_M4A3_76";
					respawnTime = 150;
					positionATL[] = {3295.83,3108.93,0};
					dir = 172;
					script = "_vehicle setAmmo [""LIB_M42A1_M1_HE"", 0];";
				};
			};
			class Defender {
				class defend_tank {
					displayName = "PzKpfW V Ausf. A Panther";
					classname = "LIB_PzKpfwV";
					respawnTime = 150;
					positionATL[] = {2442.69,1991.22,0};
					dir = 59;
					/*script = "_vehicle setAmmo [""missiles_DAR"", 0];_vehicle setAmmo [""M134_minigun"", 2000];";*/
				};
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
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3802.88,2661.71,0};
							dir = 272;
							script = "";
						};
						class d_truck_1_2 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3802.74,2657.74,0};
							dir = 272;
							script = "";
						};
					};
				};
			};
			class Stage2 {
				class Spawns {
					defenders[] = {3416.85,2251.48,0};
					attackers[] = {3789.66,2660.17,0};
				};
				class Objective {
					positionATL[] = {3454.89,2363.04,3.61034};
					dir = 337;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_2_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {3762.06,2666.23,0};
							dir = 163;
							script = "";
						};
						class a_car_2_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3770.29,2667.56,0};
							dir = 180;
							script = "";
						};
						class a_car_2_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3772.83,2667.6,0};
							dir = 180;
							script = "";
						};
						class a_car_2_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3775.35,2667.61,0};
							dir = 180;
							script = "";
						};
					};
					class Defender {
						class d_truck_2_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {3502.01,2188.14,0.32943};
							dir = 284;
							script = "";
						};
						class d_car_2_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {3500.13,2184.07,0.212822};
							dir = 281;
							script = "";
						};
						class d_car_2_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {3499.29,2180.79,0.277283};
							dir = 300;
							script = "";
						};
					};
				};
			};
			class Stage3 {
				class Spawns {
					defenders[] = {2984.47,2162.72,0};
					attackers[] = {3472.72,2315.33,0};
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
							positionATL[] = {3482.5,2311.75,0};
							dir = 94;
							script = "";
						};
						class a_car_3_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3479.5,2318.5,0};
							dir = 83;
							script = "";
						};
						class a_car_3_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {3480,2325,0};
							dir = 98;
							script = "";
						};
					};
					class Defender {
						class d_truck_3_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2954.25,2166.25,0};
							dir = 178;
							script = "";
						};
						class d_car_3_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
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
					defenders[] = {2682.64,2052.73,0};
					attackers[] = {2981.77,2180.17,0};
				};
				class Objective {
					positionATL[] = {2669,2145.5,12.29};
					dir = 309;
					classname = "LIB_GerRadio";
				};
				class Vehicles {
					class Attacker {
						class a_truck_4_1 {
							displayName = "M3 Halftrack";
							classname = "LIB_US_M3_Halftrack";
							respawnTime = 120;
							positionATL[] = {2987.25,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_1 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2990.25,2144.02,0};
							dir = 0;
							script = "";
						};
						class a_car_4_2 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2993,2144,0};
							dir = 0;
							script = "";
						};
						class a_car_4_3 {
							displayName = "Willys MB";
							classname = "LIB_US_Willys_MB";
							respawnTime = 30;
							positionATL[] = {2995,2144,0};
							dir = 0;
							script = "";
						};
					};
					class Defender {
						class d_truck_4_1 {
							displayName = "Sd.Kfz. 251";
							classname = "LIB_SdKfz251";
							respawnTime = 120;
							positionATL[] = {2672.87,2030.38,0};
							dir = 357;
							script = "";
						};
						class d_car_4_1 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
							positionATL[] = {2669.09,2034.4,0};
							dir = 342;
							script = "";
						};
						class d_car_4_2 {
							displayName = "Kubelwagen MG42";
							classname = "LIB_Kfz1_MG42";
							respawnTime = 60;
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
