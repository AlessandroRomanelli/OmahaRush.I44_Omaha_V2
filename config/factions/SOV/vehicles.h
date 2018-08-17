faction = "SOV";

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
  displayName = "";
  className = "";
  respawn = 120;
  populationReq = 40;
};

class H_Tank: Vehicle {
  displayName = "IS-2";
  className = "LIB_JS2_43";
  respawn = 300;
  populationReq = 40;
};

class L_Tank: Vehicle {
  displayName = "T-34-76";
  className = "LIB_T34_76";
  respawn = 180;
  populationReq = 30;
};

class APC: Vehicle {
  displayName = "Zis-5V (61K Gun)";
  className = "LIB_Zis5v_61K";
  respawn = 120;
  populationReq = 20;
};

class Car_HMG: Vehicle {
  displayName = "M3 Scout Car";
  className = "LIB_Scout_M3_FFV";
  respawn = 60;
  populationReq = 10;
};

class Truck: Vehicle {
  displayName = "Zis-5V";
  className = "LIB_Zis5v";
  respawn = 30;
};

class Car: Vehicle {
  displayName = "Willys Jeep";
  className = "LIB_Willys_MB";
  respawn = 15;
};
