// File: fn_suicideBomb
if(vest player != "V_HarnessOGL_brn") exitWith {};
if(vehicle player != player) exitWith {hint "你不能在车内引爆你的背心。"};
if (player distance (getMarkerPos "bw_marker") < 70) exitWith {hint "黑水公司的无线电频率干扰器阻止了你的背心引爆。";};
if (player distance (getMarkerPos "fed_reserve_1") < 70) exitWith {hint "联邦储备局的无线电频率干扰器阻止了你的背心引爆。";};
//if (player distance (getMarkerPos "jail_marker") < 70) exitWith {hint "Prison radio frequency jammers have prevented your vest from detonating.";};

private _test = "Bo_Mk82" createVehicle [0,0,9999];
_test attachTo [player, [0,0,1]];
detach _test;
private _dam_obj = _test;
_dam_obj setDamage 1;
removeVest player;

if(alive player) then {removeVest player; player setDamage 1;};
["sui_vest",1] spawn OEC_fnc_statArrUp;
[[0,format["%1已经引爆了他的自杀背心。",name player]],"OEC_fnc_broadcast",-2,false] spawn OEC_fnc_MP;

[
  ["event","Detonated Suicide Vest"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["location",getPosATL player]
] call OEC_fnc_logIt;
