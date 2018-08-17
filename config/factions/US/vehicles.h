faction = "US";

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
  respawnTime = 420;
  populationReq = 30;
  fuelTime = 90;
};

class Plane_CAP: Plane {
  displayName = "P-39 'Airacobra'";
  className = "LIB_US_P39_2";
};

class Plane_CAS: Plane {
  displayName = "P-47 'Thunderbolt'";
  className = "LIB_P47";
};

class H_Tank: Vehicle {
  displayName = "M4A3 Sherman Firefly";
  className = "LIB_M4A4_FIREFLY";
  respawnTime = 300;
  populationReq = 40;
};

class L_Tank: Vehicle {
  displayName = "M3A3 Stuart";
  className = "LIB_M3A3_Stuart";
  respawnTime = 180;
  populationReq = 30;
};

class APC: Vehicle {
  displayName = "M8 Greyhound";
  className = "LIB_M8_Greyhound";
  respawnTime = 120;
  populationReq = 20;
};

class Car_HMG: Vehicle {
  displayName = "M3 Scout Car";
  className = "LIB_US_Scout_M3_FFV";
  respawnTime = 60;
  populationReq = 10;
};

class Truck: Vehicle {
  displayName = "GMC Truck";
  className = "LIB_US_GMC_Open";
  respawnTime = 30;
};

class Car: Vehicle {
  displayName = "Willys Jeep";
  className = "LIB_US_Willys_MB";
  respawnTime = 15;
};
