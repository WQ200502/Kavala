#include "..\..\macro.h"
//  File: fn_newsLoadout.sqf
//	Author: Jesse "tkcjesse" Schultz

//	Description: Basic News Team Loadout

private _handle = [] spawn OEC_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

switch (true) do {
	case (__GETC__(life_newslevel) isEqualTo 1): {
		player forceAddUniform  "U_C_Journalist";
	};
	case (__GETC__(life_newslevel) isEqualTo 2): {
		player forceAddUniform  "U_C_Poor_2";
	};
	case (__GETC__(life_newslevel) isEqualTo 3): {
		player forceAddUniform  "U_IG_Guerilla2_1";
	};
	case (__GETC__(life_newslevel) >= 4): {
		player forceAddUniform  "U_Marshal";
	};
};
if (__GETC__(life_newslevel) < 2) then {
	player addVest "V_Rangemaster_belt";
	for "_i" from 1 to 2 do {player addItemToVest "FirstAidKit";};
};
if (__GETC__(life_newslevel) >= 2) then {
	player addVest "V_Press_F";
	for "_i" from 1 to 3 do {player addItemToVest "FirstAidKit";};
};

for "_i" from 1 to 3 do {player addItemToUniform "Chemlight_blue";};
player addBackpack "B_AssaultPack_blk";
backpackContainer player setObjectTextureGlobal [0,""];
for "_i" from 1 to 2 do {player addItemToBackpack "ToolKit";};
player addHeadgear "H_Cap_press";
player addGoggles "G_Spectacles_Tinted";

if((primaryWeapon player) != "") then {
	player removeWeapon (primaryWeapon player);
};

player addWeapon "Laserdesignator";
if (__GETC__(life_newslevel) >= 3) then {
	player addWeapon "I_UavTerminal";
};

player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";