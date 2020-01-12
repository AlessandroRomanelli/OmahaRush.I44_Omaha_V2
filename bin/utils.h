// UTILITIES
#define QUOTE(var1) #var1
#define DOUBLES(var1,var2) var1##_##var2

// OBJECTIVE status
#define OBJ_STATUS_UNARMED 		-1
#define OBJ_STATUS_IN_USE 		0
#define OBJ_STATUS_ARMED 		1
#define OBJ_STATUS_DISARMED 	2
#define OBJ_STATUS_DONE			3
#define IS_OBJ_ARMED (sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED] == OBJ_STATUS_ARMED)
#define IS_OBJ_UNARMED (sv_cur_obj getVariable ["status", OBJ_STATUS_UNARMED] == OBJ_STATUS_UNARMED)
#define SET_OBJ_STATUS(STATUS) (sv_cur_obj setVariable ["status", STATUS, true]);

#define AMMOBOX_CLASSNAME "LIB_AmmoCrates_NoInteractive_Large"

// DECLARATIONS
#define VARIABLE_DEFAULT(VAR_NAME,DEFAULT) if (isNil QUOTE(VAR_NAME)) then {VAR_NAME = DEFAULT;}

#define SV_SETTING_INIT(VAR_NAME, DEFAULT) \
	sv_setting_##VAR_NAME = profileNamespace getVariable [QUOTE(DOUBLES(sv_setting,VAR_NAME)), DEFAULT]

#define SV_SETTING_INIT_P(VAR_NAME, DEFAULT) \
	sv_setting_##VAR_NAME = profileNamespace getVariable [QUOTE(DOUBLES(sv_setting,VAR_NAME)), DEFAULT]; \
	sv_settings pushBack [QUOTE(VAR_NAME), sv_setting_##VAR_NAME]

#define WAIT_IF_NOT(VAR_NAME) waitUntil{!isNil QUOTE(VAR_NAME) && {VAR_NAME}}
#define EXIT_IF_NOT(VAR_NAME) if (isNil QUOTE(VAR_NAME) || {!VAR_NAME}) exitWith {}

// MUTEX
#define MUTEX_INIT(LOCK) VARIABLE_DEFAULT(LOCK, false)
#define MUTEX_LOCK(LOCK) waitUntil {\
    private _hasLock = false;\
    isNil {\
        if (!LOCK) then {\
            LOCK = true;\
            _hasLock = true;\
        }\
    };\
    _hasLock\
}
#define MUTEX_UNLOCK(LOCK) LOCK = false

// EVENT HANDLERS
#define REMOVE_EXISTING_MEH(EH_TYPE, ID) if (!isNil QUOTE(ID)) then {removeMissionEventHandler [EH_TYPE, ID];}
#define REMOVE_EXISTING_PEH(EH_TYPE, ID) if (!isNil QUOTE(ID)) then {player removeEventHandler [EH_TYPE, ID];}

// SCRIPTS
#define TERMINATE_SCRIPT(HANDLE) if (!isNil QUOTE(HANDLE)) then { terminate HANDLE }

// SIDE LOGIC
#define ATTACK_SIDE EAST
#define DEFEND_SIDE WEST

#define ATTACK_STR "attackers"
#define DEFEND_STR "defenders"

#define SIDEOF(UNIT) (UNIT getVariable ["side", side UNIT])
#define NAMEOF(UNIT) (UNIT getVariable ["name", name UNIT])

#define SAME_SIDE(A,B) (SIDEOF(A) == SIDEOF(B))

#define IS_ATTACKING(UNIT) (SIDEOF(UNIT) == ATTACK_SIDE)
#define IS_DEFENDING(UNIT) (SIDEOF(UNIT) == DEFEND_SIDE)

#define GAMESIDE(UNIT) ([ATTACK_STR, DEFEND_STR] select (IS_DEFENDING(UNIT)))

#define SIDE_STR(SIDE) ([ATTACK_STR, DEFEND_STR] select (SIDE == DEFEND_SIDE))
