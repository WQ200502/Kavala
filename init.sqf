enableSaving [false, false];
X_Server = false;
X_Client = false;
X_JIP = false;
StartProgress = false;

if(!isDedicated) then { X_Client = true;};

diag_log "init first" + str(allDisplays);


enableRadio false;
0 fadeRadio 0;
enableSaving[false,false];

MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
life_versionInfo = "Altis Life RPG v3.1.4.8+";

[] spawn OEC_fnc_KRON_Strings;

StartProgress = true;
[] execVM "sztq.sqf";