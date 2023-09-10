// File: fn_isAtWar.sqf

if !(side _this isEqualTo civilian) exitWith { false };
private _gangID = (_this getVariable ["gang_data",[0,"",0]]) select 0;
(_gangID in oev_gang_warIDs)
