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

player addWeapon "arifle_CTAR_GL_ghex_F";
player addPrimaryWeaponItem "muzzle_snds_58_ghex_F";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_ERCO_khk_F";
player addPrimaryWeaponItem "30Rnd_580x42_Mag_F";
player addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
player addWeapon "hgun_Rook40_F";
player addHandgunItem "muzzle_snds_L";
player addHandgunItem "16Rnd_9x21_Mag";

player forceAddUniform "U_O_T_Sniper_F";
player addVest "V_PlateCarrierSpec_wdl";
player addBackpack "B_Bergen_dgtl_F";

player addWeapon "Rangefinder";

for "_i" from 1 to 3 do {player addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 5 do {player addItemToVest "30Rnd_9x21_Mag";};
for "_i" from 1 to 4 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToBackpack "ToolKit";};
for "_i" from 1 to 2 do {player addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShell";};
for "_i" from 1 to 29 do {player addItemToBackpack "30Rnd_580x42_Mag_F";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";
player addGoggles "G_Respirator_yellow_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";
 
titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "这是私人订制套餐，你不能用!"
};