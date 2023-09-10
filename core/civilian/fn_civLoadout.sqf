#include "..\..\macro.h"
//  File: fn_civLoadout.sqf
//	Author: Tobias 'Xetoxyc' Sittenauer
//	Description: Loads the civs out with the default gear, with randomized clothing.
private _handle = [] spawn OEC_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

_clothings = ["U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_man_sport_1_F","U_C_man_sport_3_F","U_C_man_sport_2_F","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];

switch (true) do {
  case ((oev_gang_data select 0) == life_conquestMonthly): {player forceAddUniform "U_I_Wetsuit";};
  case (oev_gang_data select 0 in oev_gangUniforms): {player forceAddUniform "U_I_CombatUniform_shortsleeve";};
  case ((getPlayerUID player) in ["76561198846869680", "76561198216100232"]): {player forceAddUniform "U_I_CombatUniform_shortsleeve";};
  case ((__GETC__(oev_civcouncil) > 0) || (__GETC__(life_supportlevel) > 0)): {player forceAddUniform "U_I_CombatUniform_tshirt";};
  case (__GETC__(oev_donator) >= 100): {player forceAddUniform "U_I_CombatUniform_shortsleeve";};
  case (__GETC__(oev_donator) >= 15): {player forceAddUniform "U_IG_Guerilla3_1";};
  default {player addUniform (_clothings select (floor(random (count _clothings))));};
};

/* ITEMS */
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";

[false] call OEC_fnc_saveGear;
