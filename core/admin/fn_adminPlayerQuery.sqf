//  File: fn_adminPlayerQuery.sqf

private["_ret"];
_ret = _this select 0;
if(isNull _ret) exitWith {};
if(isNil "_ret") exitWith {};

[[oev_atmcash,oev_cash,owner player,player,(O_stats_playtime_civ + O_stats_playtime_cop + O_stats_playtime_med)],"OEC_fnc_admininfo",_ret,false] spawn OEC_fnc_MP;