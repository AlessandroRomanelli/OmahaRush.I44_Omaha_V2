faction = "UK";
marker = "flag_UK";

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
  className = "LIB_US_P39_2";
};

class Plane_CAS: Plane {
  displayName = "P-47 Thunderbolt";
  className = "LIB_P47";
};

class H_Tank: Vehicle {
  displayName = "Mk VII Churchill";
  className = "LIB_Churchill_Mk7";
  respawnTime = 300;
  populationReq = 20;
};

class L_Tank: Vehicle {
  displayName = "Mk III Crusader";
  className = "LIB_Crusader_Mk3";
  respawnTime = 180;
  populationReq = 14;
};

class APC: Vehicle {
  displayName = "M8 Greyhound";
  className = "LIB_M8_Greyhound";
  respawnTime = 120;
  populationReq = 10;
};

class Car_HMG: Vehicle {
  displayName = "Bren Carrier";
  className = "LIB_UniversalCarrier";
  respawnTime = 60;
  populationReq = 6;
};

class Truck: Vehicle {
  displayName = "Austin K5";
  className = "LIB_AustinK5_Tent";
  respawnTime = 30;
};

class Car: Vehicle {
  displayName = "Willys Jeep";
  className = "LIB_UK_Willys_MB_Hood";
  respawnTime = 15;
};
