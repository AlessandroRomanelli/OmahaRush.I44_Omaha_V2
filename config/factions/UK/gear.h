faction = "UK";

class ExplosiveCharge {
  weapon = "LIB_Ladung_Small_MINE_mag";
  backpack = "B_LIB_US_Backpack";
};

class Grenade {
  weapon = "LIB_US_Mk_2";
  class RifleGrenade {
    rifles[] = {"LIB_M1_Garand"};
    attachment = "LIB_ACC_GL_M7";
    rifleGrenade = "LIB_1Rnd_G_M9A1";
  };
};

class Launcher {
  weapon = "LIB_M1A1_Bazooka";
  ammoType = "LIB_1Rnd_60mm_M6";
  ammoCount = 2;
};

class Loadouts {
  class Army {
    uniforms[] = {"U_LIB_UK_Soldier"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk2", "H_LIB_UK_Helmet_Mk2_Net", "H_LIB_UK_Helmet_Mk2_Camo", "H_LIB_UK_Helmet_Mk2_Beachgroup",
                   "H_LIB_UK_Helmet_Mk2_FAK", "H_LIB_UK_Helmet_Mk2_FAK_Camo", "H_LIB_UK_Helmet_Mk2_Cover", "H_LIB_UK_Beret_Commando", "H_LIB_UK_Beret_Commando_Kieffer"};
    vests[] = {"V_LIB_UK_P37_Rifleman", "V_LIB_UK_P37_Gasmask", "V_LIB_UK_P37_Holster", "V_LIB_UK_P37_Heavy", "V_LIB_UK_P37_Officer"};
    backpacks[] = {"B_LIB_UK_HSack", "B_LIB_UK_HSack_Cape", "B_LIB_UK_HSack_Tea"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class Blanco {
    uniforms[] = {"U_LIB_UK_Soldier"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk3", "H_LIB_UK_Helmet_Mk3_Net", "H_LIB_UK_Helmet_Mk3_Camo", "H_LIB_UK_Beret_Commando", "H_LIB_UK_Beret_Commando_Kieffer"};
    vests[] = {"V_LIB_UK_P37_Rifleman_Blanco", "V_LIB_UK_P37_Gasmask_Blanco", "V_LIB_UK_P37_Holster_Blanco", "V_LIB_UK_P37_Heavy_Blanco", "V_LIB_UK_P37_Officer_Blanco"};
    backpacks[] = {"B_LIB_UK_HSack_Blanco", "B_LIB_UK_HSack_Blanco_cape", "B_LIB_UK_HSack_Blanco_Tea"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class Para {
    uniforms[] = {"U_LIB_UK_Para", "U_LIB_UK_Jerkins", "U_LIB_US_Corp", "U_LIB_US_Sergant"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Para_Helmet_Mk2", "H_LIB_UK_Para_Helmet_Mk2_Net", "H_LIB_UK_Para_Helmet_Mk2_Camo", "H_LIB_UK_Para_Beret"};
    vests[] = {"V_LIB_UK_P37_Rifleman_Blanco", "V_LIB_UK_P37_Gasmask_Blanco", "V_LIB_UK_P37_Holster_Blanco", "V_LIB_UK_P37_Heavy_Blanco", "V_LIB_UK_P37_Officer_Blanco"};
    backpacks[] = {"B_LIB_UK_HSack_Blanco", "B_LIB_UK_HSack_Blanco_cape", "B_LIB_UK_HSack_Blanco_Tea"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class Desert {
    uniforms[] = {"U_LIB_UK_Desert"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk2_Desert", "H_LIB_UK_Helmet_Mk2_Desert2"};
    vests[] = {"V_LIB_UK_P37_Rifleman", "V_LIB_UK_P37_Gasmask", "V_LIB_UK_P37_Holster", "V_LIB_UK_P37_Heavy", "V_LIB_UK_P37_Officer"};
    backpacks[] = {"B_LIB_UK_HSack", "B_LIB_UK_HSack_Cape", "B_LIB_UK_HSack_Tea"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class Winter {
    uniforms[] = {"U_LIB_UK_Desert"};
    goggles = "";
    headgears[] = {"H_LIB_US_Helmet", "H_LIB_US_Helmet_ns", "H_LIB_US_Helmet_os", "H_LIB_US_Helmet_Net_ns", "H_LIB_US_Helmet_Net_os", "H_LIB_US_Helmet_Net"};
    vests[] = {"V_LIB_US_Vest_Asst_MG", "V_LIB_US_Vest_Carbine", "V_LIB_US_Vest_Garand", "V_LIB_US_Vest_Bar", "V_LIB_US_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_Backpack", "B_LIB_US_Backpack_Bandoleer"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
};
