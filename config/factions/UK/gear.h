faction = "UK";

class ExplosiveCharge {
  weapon = "LIB_Ladung_Small_MINE_mag";
  backpack = "B_LIB_UK_HSack";
};

class Grenade {
  weapon = "LIB_MillsBomb";
  class RifleGrenade {
    rifles[] = {"LIB_LeeEnfield_No1", "LIB_LeeEnfield_No4"};
    attachment = "LIB_ACC_GL_Enfield_CUP_Empty";
    rifleGrenade = "LIB_MillsBomb";
  };
};

class Launcher {
  weapon = "LIB_PIAT";
  ammoType = "LIB_1Rnd_89m_PIAT";
  ammoCount = 4;
};

class Loadouts {
  class Army {
    uniforms[] = {"U_LIB_UK_Soldier"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk2", "H_LIB_UK_Helmet_Mk2_Net", "H_LIB_UK_Helmet_Mk2_Camo",
                   "H_LIB_UK_Beret_Commando", "H_LIB_UK_Beret_Commando_Kieffer"};
    vests[] = {"V_LIB_UK_P37_Rifleman", "V_LIB_UK_P37_Holster", "V_LIB_UK_P37_Heavy", "V_LIB_UK_P37_Officer"};
    backpacks[] = {"B_LIB_UK_HSack", "B_LIB_UK_HSack_Cape"};
    class medics {
      uniforms[] = {};
      vests[] = {"V_LIB_UK_P37_Gasmask"};
      headgears[] = {"H_LIB_UK_Helmet_Mk2_FAK", "H_LIB_UK_Helmet_Mk2_FAK_Camo"};
      backpacks[] = {"B_LIB_UK_HSack_Tea"};
    };
    ATbackpack = "B_LIB_UK_HSack";
  };
  class Blanco {
    uniforms[] = {"U_LIB_UK_Soldier"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk3", "H_LIB_UK_Helmet_Mk3_Net", "H_LIB_UK_Helmet_Mk3_Camo", "H_LIB_UK_Beret_Commando", "H_LIB_UK_Beret_Commando_Kieffer"};
    vests[] = {"V_LIB_UK_P37_Rifleman_Blanco", "V_LIB_UK_P37_Holster_Blanco", "V_LIB_UK_P37_Heavy_Blanco", "V_LIB_UK_P37_Officer_Blanco"};
    backpacks[] = {"B_LIB_UK_HSack_Blanco", "B_LIB_UK_HSack_Blanco_cape"};
    class medics {
      uniforms[] = {};
      vests[] = {"V_LIB_UK_P37_Gasmask_Blanco"};
      headgears[] = {"H_LIB_UK_Helmet_Mk2_FAK", "H_LIB_UK_Helmet_Mk2_FAK_Camo"};
      backpacks[] = {"B_LIB_UK_HSack_Blanco_Tea"};
    };
    ATbackpack = "B_LIB_UK_HSack_Blanco";
  };
  class Para {
    uniforms[] = {"U_LIB_UK_Para"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Para_Helmet_Mk2", "H_LIB_UK_Para_Helmet_Mk2_Net", "H_LIB_UK_Para_Helmet_Mk2_Camo", "H_LIB_UK_Para_Beret"};
    vests[] = {"V_LIB_UK_P37_Rifleman_Blanco", "V_LIB_UK_P37_Holster_Blanco", "V_LIB_UK_P37_Heavy_Blanco", "V_LIB_UK_P37_Officer_Blanco"};
    backpacks[] = {"B_LIB_UK_HSack_Blanco", "B_LIB_UK_HSack_Blanco_cape"};
    class medics {
      uniforms[] = {"U_LIB_UK_Para"};
      vests[] = {"V_LIB_UK_P37_Gasmask_Blanco"};
      headgears[] = {};
      backpacks[] = {"B_LIB_UK_HSack_Tea"};
    };
    ATbackpack = "B_LIB_UK_HSack_Blanco";
  };
  class Desert {
    uniforms[] = {"U_LIB_UK_Desert"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk2_Desert", "H_LIB_UK_Helmet_Mk2_Desert2", "H_LIB_UK_Beret"};
    vests[] = {"V_LIB_UK_P37_Rifleman", "V_LIB_UK_P37_Holster", "V_LIB_UK_P37_Heavy", "V_LIB_UK_P37_Officer"};
    backpacks[] = {"B_LIB_UK_HSack", "B_LIB_UK_HSack_Cape"};
    class medics {
      uniforms[] = {"U_LIB_UK_Desert"};
      vests[] = {"V_LIB_UK_P37_Gasmask"};
      headgears[] = {"H_LIB_UK_Helmet_Mk2_Cover"};
      backpacks[] = {"B_LIB_UK_HSack_Tea"};
    };
    ATbackpack = "B_LIB_UK_HSack";
  };
  class Winter {
    uniforms[] = {"U_LIB_UK_Jerkins"};
    goggles = "";
    headgears[] = {"H_LIB_UK_Helmet_Mk2_W", "H_LIB_UK_Helmet_Mk2_W_Net", "H_LIB_UK_Helmet_Mk2_Cover_W", "H_LIB_UK_Para_Beret"};
    vests[] = {"V_LIB_UK_P37_Rifleman_Blanco", "V_LIB_UK_P37_Holster_Blanco", "V_LIB_UK_P37_Heavy_Blanco", "V_LIB_UK_P37_Officer_Blanco"};
    backpacks[] = {"B_LIB_UK_HSack_Blanco", "B_LIB_UK_HSack_Blanco_cape"};
    class medics {
      uniforms[] = {"U_LIB_UK_Para"};
      vests[] = {"V_LIB_UK_P37_Gasmask_Blanco"};
      headgears[] = {};
      backpacks[] = {"B_LIB_UK_HSack_Blanco_Tea"};
    };
    ATbackpack = "B_LIB_UK_HSack_Blanco";
  };
};
