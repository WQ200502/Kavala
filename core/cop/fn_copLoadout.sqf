//  File: fn_copLoadout.sqf
//	Author: Bryan "Tonic" Boardwine
//	Description: Loads the cops out with the default gear.
private["_handle"];
_handle = [] spawn OEC_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};

//Load player with default cop gear.
player addUniform "U_Rangemaster";
player addWeapon "hgun_P07_F";
player addMagazine "16Rnd_9x21_Mag";
player addMagazine "16Rnd_9x21_Mag";

/* ITEMS */
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";
player addItem "ItemGPS";
player assignItem "ItemGPS";

[false] call OEC_fnc_saveGear;