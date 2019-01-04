safeSpawnDistance = 50;

date[] = {1944,6,6,12,30};
fog = 0;
rain = 1;
overcast = 1;

class PersistentVehicles: Vehicles {
  class Attacker: Attacker {
    class a_plane_cap: Plane_CAP {
      positionATL[] = {1623.23,2337.63,100};
    };
  };
  class Defender: Defender {
    class d_plane_cap: Plane_CAP {
      positionATL[] = {3566.3,2733.07,100};
    };
  };
};

class Stages {
  class Stage1 {
    class Spawns {
      class attackers {
        class HQSpawn {
          name = "Attackers HQ";
          positionATL[] = {2065.82,2534.84,0};
        };
        class Spawn1 {
          name = "Spawn 1";
          positionATL[] = {0,0,0};
        };
        class Spawn2 {
          name = "Spawn 2";
          positionATL[] = {0,0,0};
        };
      };
      class defenders {
        class HQSpawn {
          name = "Defenders HQ";
          positionATL[] = {2525.16,2798.06,0};
        };
        class Spawn1 {
          name = "Spawn 1";
          positionATL[] = {0,0,0};
        };
        class Spawn2 {
          name = "Spawn 2";
          positionATL[] = {0,0,0};
        };
      };
    };
    class Area {
      class Attacker {
        positionATL[] = {2237.51,2589.64,0};
        area[] = {169.428,213.271,65,true,-1};
      };
      class Defender {
        positionATL[] = {2446.13,2686.92,0};
        area[] = {169.428,128.239,65,true,-1};
      };
    };
    class Objective {
      positionATL[] = {2408.48,2604.37,0};
      dir = 258.5;
      classname = "LIB_Static_opelblitz_radio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {
        class a_tank_1_1: H_Tank {
          positionATL[] = {2102.45,2543.65,0.247558};
          dir = 0;
          script = "";
        };
        class a_tank_1_2: L_Tank {
          positionATL[] = {2095.48,2542.3,0};
          dir = 0;
          script = "";
        };
        class a_tank_1_3: APC {
          positionATL[] = {2087.35,2542.13,0};
          dir = 0;
          script = "";
        };
        class a_car_1_1: Car_HMG {
          positionATL[] = {2080.07,2548.94,0};
          dir = 50;
          script = "";
        };
        class a_car_1_2: Car {
          positionATL[] = {2069.73,2563.5,0};
          dir = 140;
          script = "";
        };
        class a_car_1_3: Car {
          positionATL[] = {2075.23,2563.54,0};
          dir = 140;
          script = "";
        };
        class a_car_1_4: Car {
          positionATL[] = {2080.85,2563.57,0};
          dir = 140;
          script = "";
        };
        class a_car_1_5: Car {
          positionATL[] = {2086.45,2563.69,0};
          dir = 140;
          script = "";
        };
        class a_car_1_6: Truck {
          positionATL[] = {2092.21,2566.64,0};
          dir = 140;
          script = "";
        };
      };
      class Defender: Defender {
        class d_tank_1_1: H_Tank {
          positionATL[] = {2511.37,2809.39,0};
          dir = 180;
          script = "";
        };
        class d_tank_1_2: L_Tank {
          positionATL[] = {2518.1,2806,0};
          dir = 225;
          script = "";
        };
        class d_tank_1_3: APC {
          positionATL[] = {2516.98,2797.16,0};
          dir = 225;
          script = "";
        };
        class d_car_1_1: Car_HMG {
          positionATL[] = {2523.82,2766.17,0};
          dir = 270;
          script = "";
        };
        class d_car_1_2: Car {
          positionATL[] = {2516.82,2777.51,0};
          dir = 270;
          script = "";
        };
        class d_car_1_3: Car {
          positionATL[] = {2516.9,2781.82,0};
          dir = 270;
          script = "";
        };
        class d_car_1_4: Car {
          positionATL[] = {2516.9,2786.05,0};
          dir = 270;
          script = "";
        };
        class d_car_1_5: Car {
          positionATL[] = {2516.88,2790.33,0};
          dir = 270;
          script = "";
        };
        class d_car_1_6: Truck {
          positionATL[] = {2524.51,2771.96,0};
          dir = 270;
          script = "";
        };
      };
    };
  };
  class Stage2 {
    class Area {
      class Attacker {
        positionATL[] = {2330.18,2632.86,0};
        area[] = {169.428,213.271,65,true,-1};
      };
      class Defender {
        positionATL[] = {2523.39,2717.95,0};
        area[] = {132.554,107.03,235,true,-1};
      };
    };
    class Spawns {
      defenders[] = {2562.77,2743.52,0};
      attackers[] = {2395.53,2609.92,0};
    };
    class Objective {
      positionATL[] = {2487.75,2720.92,0};
      dir = 133.5;
      classname = "LIB_Static_opelblitz_radio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {
        class a_tank_2_1: L_Tank {
          positionATL[] = {2357.62,2572.54,0};
          dir = 60;
          script = "";
        };
        class a_tank_2_2: APC {
          positionATL[] = {2358.97,2565.26,0};
          dir = 60;
          script = "";
        };
        class a_car_2_1: Car_HMG {
          positionATL[] = {2368.35,2560.67,0};
          dir = 0;
          script = "";
        };
      };
      class Defender: Defender {
        class d_tank_2_1: L_Tank {
          positionATL[] = {2552.56,2774.53,0};
          dir = 245;
          script = "";
        };
        class d_car_2_1: APC {
          positionATL[] = {2553.53,2767.49,0};
          dir = 270;
          script = "";
        };
        class d_car_2_2: Car_HMG {
          positionATL[] = {2554.72,2757.88,0};
          dir = 310;
          script = "";
        };
      };
    };
  };
  class Stage3 {
    class Area {
      class Attacker {
        positionATL[] = {2570.61,2709.18,0};
        area[] = {131.439,138.095,270,true,-1};
      };
      class Defender {
        positionATL[] = {2727.99,2709.18,0};
        area[] = {131.439,106.164,270,true,-1};
      };
    };
    class Spawns {
      defenders[] = {2797.84,2671.57,0};
      attackers[] = {2501.25,2720.86,0};
    };
    class Objective {
      positionATL[] = {2678.67,2689.01,0};
      dir = 180;
      classname = "LIB_Static_opelblitz_radio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {
        class a_tank_3_1: L_Tank {
          positionATL[] = {2500.56,2735.8,0};
          dir = 180;
          script = "";
        };
        class a_tank_3_2: APC {
          positionATL[] = {2493.85,2735.99,0};
          dir = 180;
          script = "";
        };
        class a_car_3_1: Car_HMG {
          positionATL[] = {2485.22,2730.53,0};
          dir = 120;
          script = "";
        };
      };
      class Defender: Defender {
        class d_tank3_1: L_Tank {
          positionATL[] = {2831.75,2699.97,0};
          dir = 325;
          script = "";
        };
        class d_car_3_1: APC {
          positionATL[] = {2824.79,2697.55,0};
          dir = 0;
          script = "";
        };
        class d_car3_2: Car_HMG {
          positionATL[] = {2817.86,2698.32,0};
          dir = 40;
          script = "";
        };
      };
    };
  };
  class Stage4 {
    class Area {
      class Attacker {
        positionATL[] = {2782.55,2737.85,0};
        area[] = {186.497,243.478,65,true,-1};
      };
      class Defender {
        positionATL[] = {3042.87,2826.02,0};
        area[] = {186.497,200.821,265,true,-1};
      };
    };
    class Spawns {
      defenders[] = {3067.21,2809.09,0};
      attackers[] = {2690.21,2706.88,0};
    };
    class Objective {
      positionATL[] = {2917.57,2814.11,0.799502};
      dir = 320;
      classname = "LIB_GerRadio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {
        class a_tank_4_1: H_Tank {
          positionATL[] = {2678.83,2707.72,0};
          dir = 90;
          script = "";
        };
        class a_tank_4_2: L_Tank {
          positionATL[] = {2685.23,2695.6,0};
          dir = 60;
          script = "";
        };
        class a_tank_4_3: APC {
          positionATL[] = {2682.91,2715.2,0};
          dir = 150;
          script = "";
        };
        class a_car_4_1: Car_HMG {
          positionATL[] = {2691.69,2693.7,0};
          dir = 16;
          script = "";
        };
      };
      class Defender: Defender {
        class d_tank_4_1: H_Tank {
          positionATL[] = {3111.07,2781.33,0};
          dir = 250;
          script = "";
        };
        class d_tank_4_2: L_Tank {
          positionATL[] = {3110.18,2772.32,0};
          dir = 305;
          script = "";
        };
        class d_tank_4_3: APC {
          positionATL[] = {3103.08,2769.3,0};
          dir = 345;
          script = "";
        };
        class d_car_4_1: Car_HMG {
          positionATL[] = {3096.77,2767.54,0};
          dir = 345;
          script = "";
        };
      };
    };
  };
};
