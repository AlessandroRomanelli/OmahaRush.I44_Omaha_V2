faction = "GER";
marker = "LIB_Faction_WEHRMACHT";

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
  populationReq = 30;
  fuelTime = 90;
};

class Plane_CAP: Plane {
  displayName = "Fw-190 'Focke-Wulf'";
  className = "LIB_FW190F8";
};

class Plane_CAS: Plane {
  displayName = "Ju-87 'Stuka'";
  className = "LIB_Ju87";
};

class H_Tank: Vehicle {
  displayName = "PzKpfW V Ausf. A 'Panther'";
  className = "LIB_PzKpfwV";
  respawnTime = 300;
  populationReq = 40;
};

class L_Tank: Vehicle {
  displayName = "Sd.Kfz 234/2 Puma";
  className = "LIB_SdKfz234_2";
  respawnTime = 180;
  populationReq = 30;
};

class APC: Vehicle {
  displayName = "Sd.Kfz 222";
  className = "LIB_SdKfz222_gelbbraun";
  respawnTime = 120;
  populationReq = 20;
};

class Car_HMG: Vehicle {
  displayName = "Sd.Kfz 251";
  className = "LIB_SdKfz251_FFV";
  respawnTime = 60;
  populationReq = 10;
};

class Truck: Vehicle {
  displayName = "Opel Blitz Truck";
  className = "LIB_OpelBlitz_Open_Y_Camo";
  respawnTime = 30;
};

class Car: Vehicle {
  displayName = "Kubelwagen";
  className = "LIB_Kfz1_Hood_camo";
  respawnTime = 15;
};
