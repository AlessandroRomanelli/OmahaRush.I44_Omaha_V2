class Vehicle {
  displayName = "";
  className = "";
  respawnTime = 0;
  positionATL[] = {};
  dir = 0;
  script = "";
};

class H_Tank: Vehicle {
  displayName = "PzKpfW VI 'Tiger'";
  className = "LIB_PzKpfwVI_E";
  respawn = 300;
};

class L_Tank: Vehicle {
  displayName = "Sd.Kfz 234/2 Puma";
  className = "LIB_SdKfz234_2";
  respawn = 180;
};

class APC: Vehicle {
  displayName = "Sd.Kfz 222";
  className = "LIB_SdKfz222_gelbbraun";
  respawn = 120;
};

class Car_HMG: Vehicle {
  displayName = "Kubelwagen (MG42)";
  className = "LIB_Kfz1_MG42_camo";
  respawn = 60;
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
