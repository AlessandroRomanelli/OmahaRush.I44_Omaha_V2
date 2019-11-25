faction = "SOV";

class ExplosiveCharge {
  weapon = "LIB_Ladung_Small_MINE_mag";
  backpack = "";
};

class Radio {
	className = "LIB_SovRadio";
};

class Grenade {
  weapon = "LIB_Rg42";
  class RifleGrenade {
    rifles[] = {"LIB_M9130", "LIB_M38"};
    attachment = "LIB_ACC_GL_DYAKONOV_Empty";
    rifleGrenade = "LIB_1Rnd_G_DYAKONOV";
  };
};

class Launcher {
  weapon = "LIB_M1A1_Bazooka";
  ammoType = "LIB_1Rnd_60mm_M6";
  ammoCount = 2;
};

class Loadouts {
  class Summer {
    uniforms[] = {"U_LIB_SOV_Strelok_summer", "U_LIB_SOV_Sergeant", "U_LIB_SOV_Efreitor_summer"};
    goggles = "";
    headgears[] = {"H_LIB_SOV_RA_Helmet", "H_LIB_SOV_RA_PrivateCap"};
    vests[] = {"V_LIB_SOV_RA_SVTBelt", "V_LIB_SOV_RA_PPShBelt", "V_LIB_SOV_RA_MosinBelt"};
    backpacks[] = {"V_LIB_SOV_RAZV_SVTBelt", "B_LIB_SOV_RA_Rucksack2_Green", "B_LIB_SOV_RA_GasBag", "B_LIB_SOV_RA_MGAmmoBag_Empty"};
    class medics {
      uniforms[] = {};
      vests[] = {};
      headgears[] = {};
      backpacks[] = {"B_LIB_SOV_RA_MedicalBag_Empty"};
    };
    ATbackpack = "B_LIB_US_RocketBag_Big_Empty";
  };
  class Spring {
    uniforms[] = {"U_LIB_SOV_Strelok", "U_LIB_SOV_Efreitor"};
    goggles = "";
    headgears[] = {"H_LIB_SOV_RA_Helmet", "H_LIB_SOV_RA_PrivateCap"};
    vests[] = {"V_LIB_SOV_RA_SVTBelt", "V_LIB_SOV_RA_PPShBelt", "V_LIB_SOV_RA_MosinBelt"};
    backpacks[] = {"V_LIB_SOV_RAZV_SVTBelt", "B_LIB_SOV_RA_Rucksack2_Green", "B_LIB_SOV_RA_GasBag", "B_LIB_SOV_RA_MGAmmoBag_Empty"};
    class medics {
      uniforms[] = {};
      vests[] = {};
      headgears[] = {};
      backpacks[] = {"B_LIB_SOV_RA_MedicalBag_Empty"};
    };
    ATbackpack = "B_LIB_US_RocketBag_Empty";
  };
  class Winter {
    uniforms[] = {"U_LIB_SOV_Strelok_w", "U_LIB_SOV_Strelok_2_w"};
    goggles = "";
    headgears[] = {"H_LIB_SOV_RA_Helmet_w"};
    vests[] = {"V_LIB_SOV_RA_SVTBelt", "V_LIB_SOV_RA_PPShBelt", "V_LIB_SOV_RA_MosinBelt"};
    backpacks[] = {"V_LIB_SOV_RAZV_SVTBelt", "B_LIB_SOV_RA_Rucksack2_Green", "B_LIB_SOV_RA_GasBag", "B_LIB_SOV_RA_MGAmmoBag_Empty"};
    class medics {
      uniforms[] = {};
      vests[] = {};
      headgears[] = {};
      backpacks[] = {"B_LIB_SOV_RA_MedicalBag_Empty"};
    };
    ATbackpack = "B_LIB_US_RocketBag_Empty";
  };
};
