class Vehicle {
  displayName = "";
  className = "";
  respawnTime = 0;
  positionATL[] = {};
  dir = 0;
  script = "";
};

class H_Tank: Vehicle {
  displayName = "M4A3 Sherman Firefly";
  className = "LIB_M4A4_FIREFLY";
  respawn = 300;
};

class L_Tank: Vehicle {
  displayName = "M3A3 Stuart";
  className = "LIB_M3A3_Stuart";
  respawn = 180;
};

class APC: Vehicle {
  displayName = "M8 Greyhound";
  className = "LIB_M8_Greyhound";
  respawn = 120;
};

class Car_HMG: Vehicle {
  displayName = "M3 Scout Car";
  className = "LIB_US_Scout_M3_FFV";
  respawn = 60;
};

class Truck: Vehicle {
  displayName = "GMC Truck";
  className = "LIB_US_GMC_Open";
  respawn = 30;
};

class Car: Vehicle {
  displayName = "Willys Jeep";
  className = "LIB_US_Willys_MB";
  respawn = 15;
};
