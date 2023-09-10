// File: fn_sellEscVeh.sqf
private _nearVeh = nearestObjects [player, ["O_Truck_03_repair_F","O_Truck_03_ammo_F","B_Truck_01_ammo_F"], 12, true];
if (count _nearVeh isEqualTo 0) exitWith {hint "The escort vehicle is not close enough to the npc!";};
if (((getPos player) distance (getPos (_nearVeh select 0))) > 12) exitWith {hint "The escort vehicle is not close enough to the npc!";};
if !(escort_status select 0) exitWith {hint "There currently is not an active escort!";};

hint "Attempting to sell the escort vehicle...";

[[player,(_this select 3)],"OES_fnc_sellEscort",false,false] spawn OEC_fnc_MP;

[
  ["event","Attmpt Sell Escort Veh"],
  ["player",name player],
  ["player_id",getPlayerUID player],
  ["position",getPosATL player]
] call OEC_fnc_logIt;
