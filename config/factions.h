/*
insert "factions\FACTION\unlocks.h" in the corresponding class.
#include "factions\GER\unlocks.h" <= Germany
#include "factions\US\unlocks.h" <= US Forces
#include "factions\SOV\unlocks.h" <= Soviet Union

*/
class Unlocks {
	class attackers {
		#include "factions\GER\unlocks.h"
	};
	class defenders {
		#include "factions\US\unlocks.h"
	};
};

/* #include "factions\FACTION\gear.h" */
class Soldiers {
	class attackers {
		#include "factions\GER\gear.h"
	};
	class defenders {
		#include "factions\US\gear.h"
	};
};

/* "factions\FACTION\vehicles.h" */
class Vehicles {
	class Attacker {
		#include "factions\GER\vehicles.h"
	};
	class Defender {
		#include "factions\US\vehicles.h"
	};
};
