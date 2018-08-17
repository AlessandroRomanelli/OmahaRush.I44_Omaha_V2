faction = "GER";

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
  displayName = "PzKpfW V Ausf. A 'Panther'";
  className = "LIB_PzKpfwV";
  respawn = 300;
  populationReq = 40;
};

class L_Tank: Vehicle {
  displayName = "Sd.Kfz 234/2 Puma";
  className = "LIB_SdKfz234_2";
  respawn = 180;
  populationReq = 30;
};

class APC: Vehicle {
  displayName = "Sd.Kfz 222";
  className = "LIB_SdKfz222_gelbbraun";
  respawn = 120;
  populationReq = 20;
};

class Car_HMG: Vehicle {
  displayName = "Sd.Kfz 251";
  className = "LIB_SdKfz251_FFV";
  respawn = 60;
  populationReq = 10;
};

class Truck: Vehicle {
  displayName = "Opel Blitz Truck";
  className = "LIB_OpelBlitz_Open_Y_Camo";
  respawn = 30;
};

class Car: Vehicle {
  displayName = "Kubelwagen";
  className = "LIB_Kfz1_Hood_camo";
  respawn = 15;
};
