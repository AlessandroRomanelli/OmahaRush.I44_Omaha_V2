scriptName "fn_initServerParams";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_initServerParams.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initServerParams.sqf"
#include "..\utils.h"

MUTEX_INIT(sv_settings_lock);
MUTEX_LOCK(sv_settings_lock);

sv_settings = [];

SV_SETTING_INIT_P(DebugMode, 0);
SV_SETTING_INIT_P(MinPlayers, 0);
SV_SETTING_INIT(MaxTickets, 300);
SV_SETTING_INIT(MinTickets, 25);
SV_SETTING_INIT(TicketsRate, 10);
SV_SETTING_INIT_P(LobbyTime, 30);
SV_SETTING_INIT_P(RoundTime, 15);
SV_SETTING_INIT(MaxMatchDuration, 10800);
SV_SETTING_INIT_P(SpawnSafeTime, 5);
/* SV_SETTING_INIT(attackers, 0);
SV_SETTING_INIT(defenders, 0); */
SV_SETTING_INIT_P(OutOfBoundsTime, 20);
SV_SETTING_INIT_P(InitialFallBack, 30);
SV_SETTING_INIT(RotationsPerMatch, 2);
SV_SETTING_INIT(MapWeather, 0);
SV_SETTING_INIT(MapPopulation, 12);
SV_SETTING_INIT_P(AutoTeamBalancer, 1);
SV_SETTING_INIT_P(AutoTeamBalanceAtDifference, 3);
SV_SETTING_INIT_P(InfantryFPOnly, 1);
SV_SETTING_INIT_P(VehicleFPOnly, 0);
SV_SETTING_INIT_P(HardcoreMode, 0);
SV_SETTING_INIT_P(ClassLimits, 1);
SV_SETTING_INIT_P(ClassLimits_support, 2);
SV_SETTING_INIT_P(ClassLimits_engineer, 2);
SV_SETTING_INIT_P(ClassLimits_recon, 1);
SV_SETTING_INIT_P(FoeStatsEnabled, 1);
SV_SETTING_INIT_P(KillcamEnabled, 1);

publicVariable "sv_settings";

MUTEX_UNLOCK(sv_settings_lock);
