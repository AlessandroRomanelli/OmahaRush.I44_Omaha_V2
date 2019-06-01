planes[] = {"LIB_FW190F8", "LIB_Ju87", "LIB_P39", "LIB_Pe2", "LIB_P47"};
htanks[] = {"LIB_PzKpfwV", "LIB_T34_85", "LIB_M4A4_FIREFLY"};
ltanks[] = {"LIB_SdKfz234_2", "LIB_T34_76", "LIB_M3A3_Stuart"};
apc[] = {"LIB_SdKfz222_camo", "LIB_Zis5v_61K", "LIB_M8_Greyhound"};
ifv[] = {"LIB_SdKfz251_FFV", "LIB_Scout_M3_FFV", "LIB_US_Scout_M3_FFV"};
trucks[] = {"LIB_OpelBlitz_Open_Y_Camo", "LIB_Zis5v", "LIB_AustinK5_Tent"};
cars[] = {"LIB_Kfz1_Hood_camo", "LIB_Willys_MB", "LIB_US_Willys_MB", "LIB_US_GMC_Open"};

class Vehicle {
  displayName = "";
  className = "";
  respawnTime = 0;
  positionATL[] = {};
  dir = 0;
  script = "";
  populationReq = 0;
};

class Plane: Vehicle {
  respawnTime = 300;
  populationReq = 14;
  fuelTime = 300;
};

class H_Tank_Common: Vehicle {
  respawnTime = 300;
  populationReq = 20;
};

class L_Tank_Common: Vehicle {
  respawnTime = 180;
  populationReq = 14;
};

class APC_Common: Vehicle {
  respawnTime = 120;
  populationReq = 10;
};

class Car_HMG_Common: Vehicle {
  respawnTime = 60;
  populationReq = 6;
};

class Truck_Common: Vehicle {
  respawnTime = 30;
};

class Car_Common: Vehicle {
  respawnTime = 15;
};
