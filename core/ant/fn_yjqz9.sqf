titleText["正在一键获取装备", "PLAIN"];
if (call oev_donator >= 500) then {
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

player addWeapon "arifle_AK12_GL_lush_F";
player addPrimaryWeaponItem "muzzle_snds_B";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_ERCO_blk_F";
player addPrimaryWeaponItem "75Rnd_762x39_Mag_F";
player addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";

player forceAddUniform "U_O_V_Soldier_Viper_F";
player addVest "V_PlateCarrierSpec_wdl";
player addBackpack "B_Bergen_dgtl_F";

for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToVest "75Rnd_762x39_Mag_Tracer_F";};
for "_i" from 1 to 3 do {player addItemToVest "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 11 do {player addItemToBackpack "75Rnd_762x39_Mag_Tracer_F";};
for "_i" from 1 to 27 do {player addItemToBackpack "30rnd_762x39_AK12_Lush_Mag_F";};
for "_i" from 1 to 3 do {player addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 3 do {player addItemToBackpack "FirstAidKit";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "这是私人订制套餐，你不能用!"
};