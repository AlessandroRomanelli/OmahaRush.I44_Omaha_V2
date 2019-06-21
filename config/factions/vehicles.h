htanks[] = {"LIB_PzKpfwV", "LIB_T34_85", "LIB_M4A4_FIREFLY", "LIB_Churchill_Mk7"};
ltanks[] = {"LIB_SdKfz234_base", "LIB_T34_76", "LIB_M3A3_Stuart", "LIB_Crusader_Mk3"};
apc[] = {"LIB_SdKfz222_base", "LIB_Zis5v_61K", "LIB_M8_Greyhound_base"};
ifv[] = {"LIB_WheeledTracked_APC_base", "LIB_Scout_M3_base", "LIB_UniversalCarrier_base"};

class Vehicle {
  displayName = "";
  className = "";
  respawnTime = 0;
  positionATL[] = {};
  dir = 0;
  script = "";
  populationReq = 0;
  variant = "";
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
