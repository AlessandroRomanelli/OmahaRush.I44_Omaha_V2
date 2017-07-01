class GeneralConfig {
	// Debugging
	debug = 1;

	//Objective radius
	objectiveRadius = 200;

	// Database information
	// DB Name: RushRedux

	// Time after round
	lobbyTime = 20;

	// Should the server restart the mission after x rounds have been played?
	// This option should ALWAYS be turned on as it helps improve performance MASSIVLY
	// Only available on dedicated servers
	PerformanceRestart = 1;

	// After how many matches?
	MatchCount = 2;

	// (or) After how many seconds?
	MatchTime = 18000;

	// Load weather of specific map?
	LoadWeather = 0;

	// Should the auto team balancer be running?
	AutoTeamBalancer = 1;

	// At what team difference should the team balancer force switches?
	AutoTeamBalanceAtDifference = 3;

	// Fall back time for defenders
	FallBackSeconds = 90;

	// ServerCommandPassword
	commandPassword = "viper12";

	// Use post processing in menus
	PostProcessing = 1;
};

class Soldiers {
	class Attackers {
		uniform = "U_LIB_US_Rangers_Uniform";
		goggles = "G_LIB_GER_Gloves5";
		headgear = "H_LIB_US_Rangers_Helmet_ns";
		vest = "V_LIB_US_Vest_Grenadier";
		backpack = "B_LIB_US_Backpack";
	};
	class Defenders {
		uniform = "U_LIB_GER_Soldier_camo5";
		goggles = "G_LIB_GER_Gloves1";
		headgear = "H_LIB_GER_HelmetCamo";
		vest = "V_LIB_GER_VestKar98";
		backpack = "B_LIB_GER_A_frame";
	};
};
