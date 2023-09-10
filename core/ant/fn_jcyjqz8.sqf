titleText["正在一键获取装备", "PLAIN"];
if ((87 in life_loot)|| (call oev_donator == 40000)) then {
_basePrice = 10000;
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
player addPrimaryWeaponItem "10Rnd_338_Mag";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_AMS";
player addPrimaryWeaponItem "bipod_01_F_blk";

player forceAddUniform "U_O_R_Gorka_01_black_F";
player addVest "V_PlateCarrierSpec_blk";
player addBackpack "B_ViperLightHarness_blk_F";

player addWeapon "Rangefinder";

for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 15 do {player addItemToBackpack "10Rnd_338_Mag";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁.338高倍狙击枪套餐，无法使用此功能!"
};