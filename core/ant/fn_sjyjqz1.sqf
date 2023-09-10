titleText["正在一键获取装备", "PLAIN"];
if (13 in life_loot) then {
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

player addWeapon "srifle_DMR_02_F";
player addPrimaryWeaponItem "muzzle_snds_338_black";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_Hamr";
player addPrimaryWeaponItem "10Rnd_338_Mag";
player addPrimaryWeaponItem "bipod_02_F_blk";
player addWeapon "hgun_P07_khk_F";
player addHandgunItem "16Rnd_9x21_Mag";

player forceAddUniform "U_O_V_Soldier_Viper_hex_F";
player addVest "V_PlateCarrierSpec_mtp";
player addBackpack "B_Bergen_dgtl_F";

player addWeapon "Rangefinder";

for "_i" from 1 to 7 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 16 do {player addItemToBackpack "10Rnd_338_Mag";};
player addHeadgear "H_HelmetO_ViperSP_hex_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁B套餐，无法使用此功能!"
};