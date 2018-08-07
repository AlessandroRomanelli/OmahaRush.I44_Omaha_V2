class CfgPerks {
	class SquadPerks {
		class sprint {
			displayName = "Sprint";
			picture = "";
			description = "Increases your reload and sprint speed by 5%";
		};
		class swim {
			displayName = "Fast Swim";
			picture = "";
			description = "Dramatically increases your swimming speed";
		};
		class extended_ammo {
			displayName = "Extended Ammunition";
			picture = "";
			description = "Deploys you with more ammunition";
		};
		class smoke_grenades {
			displayName = "Smoke Grenades";
			picture = "";
			description = "Deploys you with one smoke grenade to create dynamic cover";
		};
	};

	class ClassPerks {
		class Medic {
			class defibrillator {
				displayName = "Epinephrine";
				picture = "";
				description = "Bring back fallen teammates to life again with your combat ready epinephrine injector";
				instructions[] = {"EPINEPHRINE", "Downed friendly units will be marked on your screen. Get to their body and use your ACTION key (Space) to revive them."};
			};
			class spawnbeacon {
				displayName = "Rally points";
				picture = "";
				description = "Allows you to create spawn points for your squad to deploy at more efficient locations";
				instructions[] = {"RALLYPOINT", "Press H to deploy your spawn beacon. Only one spawnbeacon is allowed per squad. Squad members will then be able to spawn on it."};
			};
		};
		class Support {
			class ammo {
				displayName = "Ammunition";
				picture = "";
				description = "Allows you replenish ammunition on yourself, friendly units and vehicles";
				instructions[] = {"AMMUNITION PACK", "Hold your ACTION key (Space) to replenish other units/vehicles ammunition. If you are out of ammo you may replenish your own."};
			};
		};
		class Assault {

			class grenadier {
				displayName = "Grenadier";
				picture = "";
				description = "Allows you to carry a fragmentation grenade, lethal for anybody who finds himself within a couple of meters from the blast.";
				instructions[] = {"GRENADIER", "Press G to throw your frag grenade. Beware of your surroundings when doing so, make sure not to endanger your team mates when throwing it."};
			};
			class saboteur {
				displayName = "Quick Hands";
				picture = "";
				description = "Allows you to plant or defuse explosives at a greatly faster speed than normal";
				instructions[] = {"QUICK HANDS", "The time taken to plant or defuse explosives is going to be less than a second: a perfect chance to clutch the situation."};
			};
		};
		class Engineer {
			class repair {
				displayName = "Repair Toolkit";
				picture = "";
				description = "Repair any kind of vehicle on the battlefield";
				instructions[] = {"REPAIR TOOLKIT", "Repair any vehicle on the battlefield by holding your ACTION key (Space) when near friendly vehicles."};
			};
			class perkAT {
				displayName = "Anti-Tank Launcher";
				picture = "";
				description = "Deploys you with an AT launcher capable penetrating even the thickest armor.";
				instructions[] = {"AT LAUNCHER", "Use your AT rocket launcher to destroy enemy ground vehicles."};
			};
			class demolition {
				displayName = "Explosives Expert";
				picture = "";
				description = "Allows you to plant explosives and set up deadly ambushes for the enemy team.";
				instructions[]= {"EXPLOSIVES EXPERT", "Use the explosives to set up ambushes for the enemy team."};
			};
		};
		class Recon {
			class spawnbeacon {
				displayName = "Rally points";
				picture = "";
				description = "Allows you to create spawn points for your squad to deploy at more efficient locations";
				instructions[] = {"RALLYPOINT", "Press H to deploy your spawn beacon. Only one spawnbeacon is allowed per squad. Squad members will then be able to spawn on it."};
			};
		};
	};
};
