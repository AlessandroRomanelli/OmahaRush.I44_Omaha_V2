class CfgPerks {
	class SquadPerks {
		class sprint {
			displayName = "Sprint";
			picture = "";
			description = "Increases your reload and sprint speed by 5%";
		};
		class extended_ammo {
			displayName = "Extended Ammunition";
			picture = "";
			description = "Deploys you with more ammunition";
		};
		/*class extended_vest {
			displayName = "Bullet independent";
			picture = "";
			description = "Allows you to sustain more damage before being taken out";
		};*/
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
		};
		class Support {
			class ammo {
				displayName = "Ammunition";
				picture = "";
				description = "Allows you replenish ammunition on yourself, friendly units and vehicles";
				instructions[] = {"AMMUNITION PACK", "Hold your ACTION key (Space) to replenish other units/vehicles ammunition. If you are out of ammo you may replenish your own."};
			};
		};
		class Recon {
			class spawnbeacon {
				displayName = "Rally points";
				picture = "";
				description = "Allows you to create spawn points for your squad to deploy at more efficient locations";
				instructions[] = {"RALLYPOINT", "Press H to deploy your spawn beacon. Only one spawnbeacon is allowed per squad. Squad members will then be able to spawn on it."};
			};
			/*class recon_scope {
				displayName = "Marksman Scope";
				picture = "";
				description = "Replaces your currently attached scope with a Khali long range sniper scope (if compatible with your weapon)";
				instructions[] = {"", ""};
			};*/
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
				instructions[] = {"AT LAUNCHER", "Use your AT launcher to destroy enemy ground vehicles."};
			};
			/*class perkAA {
				displayName = "Anti-Air Launcher";
				picture = "";
				description = "Deploys you with an Anti-Air heat-guided launcher to destroy enemy air vehicles";
				instructions[] = {"ANTI AIR LAUNCHER", "Use your Titan Anti-Air launcher to destroy enemy air vehicles."};
			};*/
		};
	};
};
