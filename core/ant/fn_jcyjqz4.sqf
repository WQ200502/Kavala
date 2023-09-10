titleText["正在一键获取装备", "PLAIN"];
if (83 in life_loot) then {
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

player addWeapon "srifle_DMR_03_F";
player addPrimaryWeaponItem "muzzle_snds_B";
player addPrimaryWeaponItem "20Rnd_762x51_Mag";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_Hamr";
player addPrimaryWeaponItem "bipod_01_F_blk";

player forceAddUniform "U_O_R_Gorka_01_black_F";
player addVest "V_PlateCarrierSpec_blk";
player addBackpack "B_Bergen_dgtl_F";

player addWeapon "Rangefinder";

for "_i" from 1 to 1 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 1 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 22 do {player addItemToBackpack "20Rnd_762x51_Mag";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";


player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁-i套餐，无法使用此功能!"
};