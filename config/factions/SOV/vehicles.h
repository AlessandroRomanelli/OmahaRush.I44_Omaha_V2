faction = "SOV";
marker = "LIB_Faction_RKKA";


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
  populationReq = 10;
  fuelTime = 90;
};

class Plane_CAP: Plane {
  displayName = "P-39 'Airacobra'";
  className = "LIB_P39";
};

class Plane_CAS: Plane {
  displayName = "Pe-2 'Petlyakov'";
  className = "LIB_Pe2";
};

class H_Tank: Vehicle {
  displayName = "T-34-85";
  className = "LIB_T34_85";
  respawnTime = 300;
  populationReq = 20;
};

class L_Tank: Vehicle {
  displayName = "T-34-76";
  className = "LIB_T34_76";
  respawnTime = 180;
  populationReq = 14;
};

class APC: Vehicle {
  displayName = "Zis-5V (61K Gun)";
  className = "LIB_Zis5v_61K";
  respawnTime = 120;
  populationReq = 10;
};

class Car_HMG: Vehicle {
  displayName = "M3 Scout Car";
  className = "LIB_Scout_M3_FFV";
  respawnTime = 60;
  populationReq = 6;
};

class Truck: Vehicle {
  displayName = "Zis-5V";
  className = "LIB_Zis5v";
  respawnTime = 30;
};

class Car: Vehicle {
  displayName = "Willys Jeep";
  className = "LIB_Willys_MB";
  respawnTime = 15;
};
