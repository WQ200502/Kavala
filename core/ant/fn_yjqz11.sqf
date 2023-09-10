titleText["正在一键获取装备", "PLAIN"];
if (call oev_donator >= 500) then {
_basePrice = 600000;
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

player addWeapon "srifle_DMR_03_woodland_F";
player addPrimaryWeaponItem "muzzle_snds_B_khk_F";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_Arco_ghex_F";
player addPrimaryWeaponItem "20Rnd_762x51_Mag";
player addPrimaryWeaponItem "bipod_01_F_khk";

player forceAddUniform "U_O_V_Soldier_Viper_F";
player addVest "V_PlateCarrierSpec_wdl";
player addBackpack "B_Bergen_dgtl_F";

player addWeapon "Rangefinder";

player addItemToUniform "20Rnd_762x51_Mag";
for "_i" from 1 to 5 do {player addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 3 do {player addItemToVest "20Rnd_762x51_Mag";};
for "_i" from 1 to 25 do {player addItemToBackpack "20Rnd_762x51_Mag";};
for "_i" from 1 to 2 do {player addItemToBackpack "MiniGrenade";};
player addItemToBackpack "IEDUrbanSmall_Remote_Mag";
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

[player,"PersianHead_A3_01","male01gre"] call BIS_fnc_setIdentity;

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";
 
titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "这是-I套餐，你不能用!"
};