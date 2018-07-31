class ExplosiveCharge {
  weapon = "LIB_Ladung_Small_MINE_mag";
  backpack = "B_LIB_GER_SapperBackpack_empty";
};

class Grenade {
  weapon = "LIB_shg24";
  class RifleGrenade {
    rifles[] = {"LIB_K98", "LIB_K98_Late"};
    attachment = "LIB_ACC_GW_SB_Empty";
    rifleGrenade = "LIB_1Rnd_G_SPRGR_30";
  };
};

class Launcher {
  weapon = "LIB_RPzB";
  ammoType = "LIB_1Rnd_RPzB";
  ammoCount = 2;
};

class Loadouts {
  class M43 {
    uniforms[] = {"U_LIB_GER_Pionier", "U_LIB_GER_Oberschutze", "U_LIB_GER_Recruit", "U_LIB_GER_Schutze", "U_LIB_GER_MG_schutze", "U_LIB_GER_Unterofficer", "U_LIB_GER_Soldier2", "U_LIB_GER_Gefreiter"};
    goggles = "";
    headgears[] = {"H_LIB_GER_Helmet", "H_LIB_GER_Helmet_net", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet_Glasses",
                  "H_LIB_GER_Helmet_net_painted", "H_LIB_GER_Helmet_ns_painted", "H_LIB_GER_Helmet_os_painted", "H_LIB_GER_Helmet_painted", "H_LIB_GER_Cap"};
    vests[] = {"V_LIB_GER_VestG43", "V_LIB_GER_VestKar98", "V_LIB_GER_VestMG", "V_LIB_GER_VestMP40", "V_LIB_GER_VestSTG"};
    backpacks[] = {"B_LIB_GER_A_frame", "B_LIB_GER_Tonister34_cowhide"};
    class medics {
      uniforms[] = {"U_LIB_GER_Medic"};
      vests[] = {};
      headgears[] = {"H_LIB_GER_Helmet_Medic"};
      backpacks[] = {"B_LIB_GER_MedicBackpack_Empty"};
    };
    ATbackpack = "B_LIB_GER_Panzer_Empty";
  };

  class M43_Camo {
    uniforms[] = {"U_LIB_GER_Soldier_camo", "U_LIB_GER_Soldier_camo2", "U_LIB_GER_Soldier_camo3", "U_LIB_GER_Soldier_camo4", "U_LIB_GER_Soldier_camo5"};
    goggles = "";
    headgears[] = {"H_LIB_GER_HelmetCamo", "H_LIB_GER_HelmetCamo2", "H_LIB_GER_HelmetCamo4", "H_LIB_GER_Cap"};
    vests[] = {"V_LIB_GER_VestG43", "V_LIB_GER_VestKar98", "V_LIB_GER_VestMG", "V_LIB_GER_VestMP40", "V_LIB_GER_VestSTG"};
    backpacks[] = {"B_LIB_GER_A_frame", "B_LIB_GER_Tonister34_cowhide"};
    class medics {
      uniforms[] = {"U_LIB_GER_Medic"};
      vests[] = {};
      headgears[] = {"H_LIB_GER_Helmet_Medic"};
      backpacks[] = {"B_LIB_GER_MedicBackpack_Empty"};
    };
    ATbackpack = "B_LIB_GER_Panzer_Empty";
  };

  class FSJ {
    uniforms[] = {"U_LIB_FSJ_Soldier_camo", "U_LIB_FSJ_Soldier"};
    goggles = "";
    headgears[] = {"H_LIB_GER_FSJ_M38_Helmet", "H_LIB_GER_FSJ_M38_Helmet_Cover", "H_LIB_GER_FSJ_M38_Helmet_os"};
    vests[] = {"V_LIB_GER_VestG43", "V_LIB_GER_VestKar98", "V_LIB_GER_VestMG", "V_LIB_GER_VestMP40", "V_LIB_GER_VestSTG"};
    backpacks[] = {"B_LIB_GER_A_frame", "B_LIB_GER_Tonister34_cowhide"};
    class medics {
      uniforms[] = {};
      vests[] = {};
      headgears[] = {"H_LIB_GER_FSJ_M44_Helmet_Medic"};
      backpacks[] = {"B_LIB_GER_MedicBackpack_Empty"};
    };
    ATbackpack = "B_LIB_GER_Panzer_Empty";
  };

  class DAK {
    uniforms[] = {"U_LIB_DAK_Sentry", "U_LIB_DAK_Sentry_2", "U_LIB_DAK_NCO", "U_LIB_DAK_NCO_2", "U_LIB_DAK_Soldier", "U_LIB_DAK_Soldier_2", "U_LIB_DAK_Soldier_3"};
    goggles = "";
    headgears[] = {"H_LIB_DAK_Helmet", "H_LIB_DAK_Helmet_Glasses", "H_LIB_DAK_Helmet_net", "H_LIB_DAK_Helmet_ns", "H_LIB_DAK_Helmet_net_2", "H_LIB_DAK_Helmet_ns_2", "H_LIB_DAK_Helmet_2"};
    vests[] = {"V_LIB_DAK_VestG43", "V_LIB_DAK_VestKar98", "V_LIB_DAK_VestMG", "V_LIB_DAK_VestMP40", "V_LIB_DAK_VestSTG"};
    backpacks[] = {"B_LIB_DAK_A_frame", "B_LIB_GER_Tonister34_cowhide"};
    class medics {
      uniforms[] = {"U_LIB_DAK_Medic"};
      vests[] = {};
      headgears[] = {"H_LIB_GER_FSJ_M44_Helmet_Medic"};
      backpacks[] = {"B_LIB_GER_MedicBackpack_Empty"};
    };
    ATbackpack = "B_LIB_GER_Panzer_Empty";
  };

  class M43_Winter {
    uniforms[] = {"U_LIB_GER_Soldier_camo_w"};
    goggles = "";
    headgears[] = {"H_LIB_GER_Helmet", "H_LIB_GER_Helmet_net", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet_Glasses",
                  "H_LIB_GER_Helmet_net_painted", "H_LIB_GER_Helmet_ns_painted", "H_LIB_GER_Helmet_os_painted", "H_LIB_GER_Helmet_painted", "H_LIB_GER_Cap"};
    vests[] = {"V_LIB_GER_VestG43", "V_LIB_GER_VestKar98", "V_LIB_GER_VestMG", "V_LIB_GER_VestMP40", "V_LIB_GER_VestSTG"};
    backpacks[] = {"B_LIB_GER_A_frame", "B_LIB_GER_Tonister34_cowhide"};
    class medics {
      uniforms[] = {};
      vests[] = {};
      headgears[] = {"H_LIB_GER_Helmet_Medic"};
      backpacks[] = {"B_LIB_GER_MedicBackpack_Empty"};
    };
    ATbackpack = "B_LIB_GER_Panzer_Empty";
  };
};
