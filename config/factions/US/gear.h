faction = "US";

class ExplosiveCharge {
  weapon = "LIB_Ladung_Small_MINE_mag";
  backpack = "B_LIB_US_Backpack";
};

class Radio {
	className = "LIB_SovRadio";
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
  class M1941 {
    uniforms[] = {"U_LIB_US_Private", "U_LIB_US_Private_1st", "U_LIB_US_Corp", "U_LIB_US_Sergant"};
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
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Big_Empty";
  };

  class HBT {
    uniforms[] = {"U_LIB_US_Rangers_Uniform", "U_LIB_US_Rangers_Private_1st", "U_LIB_US_Rangers_Corp", "U_LIB_US_Rangers_Sergant"};
    goggles = "";
    headgears[] = {"H_LIB_US_Rangers_Helmet", "H_LIB_US_Rangers_Helmet_ns", "H_LIB_US_Rangers_Helmet_os"};
    vests[] = {"V_LIB_US_Assault_Vest", "V_LIB_US_Assault_Vest_dday", "V_LIB_US_Assault_Vest_Light", "V_LIB_US_Assault_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_Backpack", "B_LIB_US_Backpack_Bandoleer"};
    class medics {
      uniforms[] = {"U_LIB_US_Med"};
      vests[] = {};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {"B_LIB_SOV_RA_MedicalBag_Empty"};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class NAC {
    uniforms[] = {"U_LIB_US_NAC_Uniform", "U_LIB_US_NAC_Uniform_2"};
    goggles = "";
    headgears[] = {"H_LIB_US_Helmet", "H_LIB_US_Helmet_ns", "H_LIB_US_Helmet_os", "H_LIB_US_Helmet_Net_ns", "H_LIB_US_Helmet_Net_os", "H_LIB_US_Helmet_Net"};
    vests[] = {"V_LIB_US_Vest_Asst_MG", "V_LIB_US_Vest_Carbine", "V_LIB_US_Vest_Carbine_nco_Radio", "V_LIB_US_Vest_Garand", "V_LIB_US_Vest_Bar", "V_LIB_US_Vest_Thompson", "V_LIB_US_Vest_Thompson_nco_Radio"};
    backpacks[] = {"B_LIB_US_Backpack", "B_LIB_US_Backpack_Bandoleer"};
    class medics {
      uniforms[] = {"U_LIB_US_NAC_Med"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };
  class M1942 {
    uniforms[] = {"U_LIB_US_AB_Uniform_M42", "U_LIB_US_AB_Uniform_M42_506", "U_LIB_US_AB_Uniform_M42_corporal", "U_LIB_US_AB_Uniform_M42_FC", "U_LIB_US_AB_Uniform_M42_Gas", "U_LIB_US_AB_Uniform_M42_NCO"};
    goggles = "";
    headgears[] = {"H_LIB_US_AB_Helmet_Clear_1", "H_LIB_US_AB_Helmet_Clear_2", "H_LIB_US_AB_Helmet_Clear_3", "H_LIB_US_AB_Helmet", "H_LIB_US_AB_Helmet_2",
                   "H_LIB_US_AB_Helmet_3", "H_LIB_US_AB_Helmet_4", "H_LIB_US_AB_Helmet_5", "H_LIB_US_AB_Helmet_Plain_1", "H_LIB_US_AB_Helmet_Plain_2", "H_LIB_US_AB_Helmet_Plain_3",
                   "H_LIB_US_AB_Helmet_Jump_1", "H_LIB_US_AB_Helmet_Jump_2"};
    vests[] = {"V_LIB_US_AB_Vest_Asst_MG", "V_LIB_US_AB_Vest_Carbine", "V_LIB_US_AB_Vest_Carbine_eng", "V_LIB_US_AB_Vest_Garand", "V_LIB_US_AB_Vest_Bar", "V_LIB_US_AB_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_M36", "B_LIB_US_M36_Bandoleer", "B_LIB_US_M36_Rope"};
    class medics {
      uniforms[] = {"U_LIB_US_AB_Uniform_M42_Medic"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_AB_Helmet_Medic_1"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_M36_RocketBag_Empty";
  };

  class M1943 {
    uniforms[] = {"U_LIB_US_AB_Uniform_M43", "U_LIB_US_AB_Uniform_M43_Flag", "U_LIB_US_AB_Uniform_M43_corporal", "U_LIB_US_AB_Uniform_M43_FC", "U_LIB_US_AB_Uniform_M43_NCO"};
    goggles = "";
    headgears[] = {"H_LIB_US_AB_Helmet_Clear_1", "H_LIB_US_AB_Helmet_Clear_2", "H_LIB_US_AB_Helmet_Clear_3", "H_LIB_US_AB_Helmet", "H_LIB_US_AB_Helmet_2",
                   "H_LIB_US_AB_Helmet_3", "H_LIB_US_AB_Helmet_4", "H_LIB_US_AB_Helmet_5", "H_LIB_US_AB_Helmet_Plain_1", "H_LIB_US_AB_Helmet_Plain_2", "H_LIB_US_AB_Helmet_Plain_3",
                   "H_LIB_US_AB_Helmet_Jump_1", "H_LIB_US_AB_Helmet_Jump_2"};
    vests[] = {"V_LIB_US_AB_Vest_Asst_MG", "V_LIB_US_AB_Vest_Carbine", "V_LIB_US_AB_Vest_Carbine_eng", "V_LIB_US_AB_Vest_Garand", "V_LIB_US_AB_Vest_Bar", "V_LIB_US_AB_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_M36", "B_LIB_US_M36_Bandoleer", "B_LIB_US_M36_Rope"};
    class medics {
      uniforms[] = {"U_LIB_US_AB_Uniform_M43_Medic"};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_AB_Helmet_Medic_1"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_M36_RocketBag_Empty";
  };

  class M1941_Winter {
    uniforms[] = {"U_LIB_US_Private_w"};
    goggles = "";
    headgears[] = {"H_LIB_US_Helmet", "H_LIB_US_Helmet_ns", "H_LIB_US_Helmet_os", "H_LIB_US_Helmet_Net_ns", "H_LIB_US_Helmet_Net_os", "H_LIB_US_Helmet_Net"};
    vests[] = {"V_LIB_US_Vest_Asst_MG", "V_LIB_US_Vest_Carbine", "V_LIB_US_Vest_Garand", "V_LIB_US_Vest_Bar", "V_LIB_US_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_Backpack", "B_LIB_US_Backpack_Bandoleer"};
    class medics {
      uniforms[] = {};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_Helmet_Med", "H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_Backpack_RocketBag_Empty";
  };

  class M1942_Winter {
    uniforms[] = {"U_LIB_US_AB_Uniform_M42_W"};
    goggles = "";
    headgears[] = {"H_LIB_US_AB_Helmet_Clear_1", "H_LIB_US_AB_Helmet_Clear_2", "H_LIB_US_AB_Helmet_Clear_3", "H_LIB_US_AB_Helmet", "H_LIB_US_AB_Helmet_2",
                   "H_LIB_US_AB_Helmet_3", "H_LIB_US_AB_Helmet_4", "H_LIB_US_AB_Helmet_5", "H_LIB_US_AB_Helmet_Plain_1", "H_LIB_US_AB_Helmet_Plain_2", "H_LIB_US_AB_Helmet_Plain_3",
                   "H_LIB_US_AB_Helmet_Jump_1", "H_LIB_US_AB_Helmet_Jump_2"};
    vests[] = {"V_LIB_US_AB_Vest_Asst_MG", "V_LIB_US_AB_Vest_Carbine", "V_LIB_US_AB_Vest_Carbine_eng", "V_LIB_US_AB_Vest_Garand", "V_LIB_US_AB_Vest_Bar", "V_LIB_US_AB_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_M36", "B_LIB_US_M36_Bandoleer", "B_LIB_US_M36_Rope"};
    class medics {
      uniforms[] = {};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_AB_Helmet_Medic_1"};
      backpacks[] = {};
    };
    ATbackpack = "B_LIB_US_M36_RocketBag_Empty";
  };

  class M1943_Winter {
    uniforms[] = {"U_LIB_US_AB_Uniform_M43_W"};
    goggles = "";
    headgears[] = {"H_LIB_US_AB_Helmet_Clear_1", "H_LIB_US_AB_Helmet_Clear_2", "H_LIB_US_AB_Helmet_Clear_3", "H_LIB_US_AB_Helmet", "H_LIB_US_AB_Helmet_2",
                   "H_LIB_US_AB_Helmet_3", "H_LIB_US_AB_Helmet_4", "H_LIB_US_AB_Helmet_5", "H_LIB_US_AB_Helmet_Plain_1", "H_LIB_US_AB_Helmet_Plain_2", "H_LIB_US_AB_Helmet_Plain_3",
                   "H_LIB_US_AB_Helmet_Jump_1", "H_LIB_US_AB_Helmet_Jump_2"};
    vests[] = {"V_LIB_US_AB_Vest_Asst_MG", "V_LIB_US_AB_Vest_Carbine", "V_LIB_US_AB_Vest_Carbine_eng", "V_LIB_US_AB_Vest_Garand", "V_LIB_US_AB_Vest_Bar", "V_LIB_US_AB_Vest_Thompson"};
    backpacks[] = {"B_LIB_US_M36", "B_LIB_US_M36_Bandoleer", "B_LIB_US_M36_Rope"};
    class medics {
      uniforms[] = {};
      vests[] = {"V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2"};
      headgears[] = {"H_LIB_US_AB_Helmet_Medic_1"};
      backpacks[] = {};
    };
  };
};
