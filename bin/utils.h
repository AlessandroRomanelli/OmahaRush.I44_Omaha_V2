#define QUOTE(var1) #var1

// DECLARATIONS
#define VARIABLE_DEFAULT(VAR_NAME,DEFAULT) if (isNil QUOTE(VAR_NAME)) then {VAR_NAME = DEFAULT;}

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
