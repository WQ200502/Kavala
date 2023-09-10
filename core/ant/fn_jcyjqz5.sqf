titleText["正在一键获取装备", "PLAIN"];
if (84 in life_loot) then {
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

player addWeapon "arifle_RPK12_F";
player addPrimaryWeaponItem "muzzle_snds_B";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_Hamr";
player addPrimaryWeaponItem "75rnd_762x39_AK12_Mag_F";

player forceAddUniform "U_O_R_Gorka_01_black_F";
player addVest "V_PlateCarrierSpec_blk";
player addBackpack "B_ViperLightHarness_blk_F";

player addWeapon "Rangefinder";

for "_i" from 1 to 7 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 10 do {player addItemToBackpack "75rnd_762x39_AK12_Mag_F";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁7.62RPK套餐，无法使用此功能!"
};