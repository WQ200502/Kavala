//  File: fn_medicLoadout.sqf
//	Author: Bryan "Tonic" Boardwine

//	Description: Loads the medic out with the default gear.
private _handle = [] spawn OEC_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

if(oev_newsTeam) exitWith {
	[] call OEC_fnc_newsLoadout;
};

player forceAddUniform "U_I_CombatUniform_shortsleeve";
player addBackpack "B_Carryall_oucamo";
player addItem "Medikit";
player addItem "ToolKit";
player addItem "ToolKit";
player addItem "ToolKit";
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemGPS";
player assignItem "ItemGPS";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";
player addHeadGear "H_Cap_blu";
player addItem "NVGoggles_INDEP";
player assignItem "NVGoggles_INDEP";

[false] call OEC_fnc_saveGear;