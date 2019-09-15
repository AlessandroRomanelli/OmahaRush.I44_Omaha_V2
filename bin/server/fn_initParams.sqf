scriptName "fn_initParams";
/*--------------------------------------------------------------------
	Author: A.Roman
    File: fn_initParams.sqf

    Written by A.Roman
    You're not allowed to use this file without permission from the author!
--------------------------------------------------------------------*/
#define __filename "fn_initParams.sqf"
#include "..\utils.h"

MUTEX_INIT(sv_settings_lock);
MUTEX_LOCK(sv_settings_lock);

sv_settings = [];

SV_SETTING_INIT_P(DebugMode, 0);
SV_SETTING_INIT_P(MinPlayers, 0);
SV_SETTING_INIT_P(MaxTickets, 300);
SV_SETTING_INIT_P(MinTickets, 25);
SV_SETTING_INIT_P(TicketsRate, 10);
SV_SETTING_INIT_P(LobbyTime, 30);
SV_SETTING_INIT_P(RoundTime, 15);
SV_SETTING_INIT_P(MaxMatchDuration, 10800);
SV_SETTING_INIT_P(SpawnSafeTime, 5);
/* SV_SETTING_INIT_P(attackers, 0);
SV_SETTING_INIT_P(defenders, 0); */
SV_SETTING_INIT_P(OutOfBoundsTime, 20);
SV_SETTING_INIT_P(InitialFallBack, 30);
SV_SETTING_INIT_P(RotationsPerMatch, 2);
SV_SETTING_INIT_P(MapWeather, 0);
SV_SETTING_INIT_P(MapPopulation, 12);
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
