safeSpawnDistance = 0;

date[] = {1944,6,6,12,30};
fog = 0;
rain = 1;
overcast = 1;

class PersistentVehicles: Vehicles {
  class Attacker: Attacker {};
  class Defender: Defender {};
};

class Stages {
  class Stage1 {
    class Spawns {
      class attackers {
        class HQSpawn {
          name = "Attackers HQ";
          positionATL[] = {2065.82,2534.84,0};
        };
      };
      class defenders {
        class HQSpawn {
          name = "Defenders HQ";
          positionATL[] = {2525.16,2798.06,0};
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
      class Attacker: Attacker {};
      class Defender: Defender {};
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
      class attackers {
        class HQSpawn {
          name = "Attackers HQ";
          positionATL[] = {2395.53,2609.92,0};
        };
      };
      class defenders {
        class HQSpawn {
          name = "Defenders HQ";
          positionATL[] = {2562.77,2743.52,0};
        };
      };
    };
    class Objective {
      positionATL[] = {2487.75,2720.92,0};
      dir = 133.5;
      classname = "LIB_Static_opelblitz_radio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {};
      class Defender: Defender {};
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
      class attackers {
        class HQSpawn {
          name = "Attackers HQ";
          positionATL[] = {2501.25,2720.86,0};
        };
      };
      class defenders {
        class HQSpawn {
          name = "Defenders HQ";
          positionATL[] = {2797.84,2671.57,0};
        };
      };
    };
    class Objective {
      positionATL[] = {2678.67,2689.01,0};
      dir = 180;
      classname = "LIB_Static_opelblitz_radio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {};
      class Defender: Defender {};
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
      class attackers {
        class HQSpawn {
          name = "Attackers HQ";
          positionATL[] = {2690.21,2706.88,0};
        };
      };
      class defenders {
        class HQSpawn {
          name = "Defenders HQ";
          positionATL[] = {3067.21,2809.09,0};
        };
      };
    };
    class Objective {
      positionATL[] = {2917.57,2814.11,0.799502};
      dir = 320;
      classname = "LIB_GerRadio";
    };
    class Vehicles: Vehicles {
      class Attacker: Attacker {};
      class Defender: Defender {};
    };
  };
};
