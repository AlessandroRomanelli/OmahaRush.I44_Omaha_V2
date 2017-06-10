class GeneralConfig {
	// Debugging
	debug = 1;

	// Database information
	// DB Name: RushRedux

	// Time after round
	lobbyTime = 20;

	// Should the server restart the mission after x rounds have been played?
	// This option should ALWAYS be turned on as it helps improve performance MASSIVLY
	// Only available on dedicated servers
	PerformanceRestart = 1;

	// After how many matches?
	MatchCount = 10;

	// (or) After how many seconds?
	MatchTime = 18000;

	// Load weather of specific map?
	LoadWeather = 1;

	// Should the auto team balancer be running?
	AutoTeamBalancer = 1;

	// At what team difference should the team balancer force switches?
	AutoTeamBalanceAtDifference = 5;

	// Fall back time for defenders
	FallBackSeconds = 120;

	// ServerCommandPassword
	commandPassword = "viper12";

	// Use post processing in menus
	PostProcessing = 1;
};

class Soldiers {
	class Attackers {
		uniform = "U_LIB_US_AB_Uniform_M42_Flag";
		goggles = "G_LIB_GER_Gloves5";
		headgear = "H_LIB_US_AB_Helmet_NCO_1";
		vest = "V_LIB_US_Vest_Grenadier";
		backpack = "B_LIB_US_M36_Rope";
	};
	class Defenders {
		uniform = "U_LIB_GER_Soldier_camo5";
		goggles = "G_LIB_GER_Gloves1";
		headgear = "H_LIB_GER_HelmetCamo";
		vest = "V_LIB_GER_VestKar98";
		backpack = "B_LIB_GER_A_frame";
	};
};
