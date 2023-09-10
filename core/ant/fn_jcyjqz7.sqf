titleText["正在一键获取装备", "PLAIN"];
if (86 in life_loot) then {
_basePrice = 500000;
if (oev_atmcash < _basePrice) exitWith {hint format[localize "STR_GNOTF_NotEnoughMoney", [_basePrice - oev_atmcash] call OEC_fnc_numberText];};
oev_atmcash = oev_atmcash - _basePrice;
oev_cache_atmcash = oev_cache_atmcash - _basePrice;

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add weapons";
player addWeapon "srifle_DMR_05_blk_F";
player addPrimaryWeaponItem "muzzle_snds_93mmg";
player addPrimaryWeaponItem "optic_AMS";
player addPrimaryWeaponItem "10Rnd_93x64_DMR_05_Mag";
player addPrimaryWeaponItem "bipod_01_F_blk";

comment "Add containers";
player forceAddUniform "U_O_R_Gorka_01_black_F";
player addVest "V_PlateCarrierSpec_blk";
player addBackpack "B_Bergen_dgtl_F";

comment "Add binoculars";
player addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 5 do {player addItemToUniform "FirstAidKit";};
player addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {player addItemToVest "10Rnd_93x64_DMR_05_Mag";};
for "_i" from 1 to 4 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 4 do {player addItemToVest "HandGrenade";};
for "_i" from 1 to 20 do {player addItemToBackpack "10Rnd_93x64_DMR_05_Mag";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁9.3高倍狙击枪套餐，无法使用此功能!"
};