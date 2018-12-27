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
