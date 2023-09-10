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

player addWeapon "arifle_MX_GL_khk_F";
player addPrimaryWeaponItem "muzzle_snds_H_snd_F";
player addPrimaryWeaponItem "acc_pointer_IR";
player addPrimaryWeaponItem "optic_Hamr";
player addPrimaryWeaponItem "30Rnd_65x39_caseless_khaki_mag";
player addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";

player forceAddUniform "U_B_PilotCoveralls";
player addVest "V_PlateCarrierSpec_rgr";
player addBackpack "B_Bergen_dgtl_F";

for "_i" from 1 to 4 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToUniform "30Rnd_65x39_caseless_khaki_mag";};
for "_i" from 1 to 2 do {player addItemToUniform "1Rnd_HE_Grenade_shell";};
player addItemToVest "30Rnd_65x39_caseless_khaki_mag";
for "_i" from 1 to 4 do {player addItemToVest "UGL_FlareWhite_F";};
for "_i" from 1 to 4 do {player addItemToVest "UGL_FlareGreen_F";};
for "_i" from 1 to 4 do {player addItemToVest "UGL_FlareRed_F";};
for "_i" from 1 to 4 do {player addItemToVest "UGL_FlareYellow_F";};
for "_i" from 1 to 31 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 5 do {player addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 20 do {player addItemToBackpack "30Rnd_65x39_caseless_khaki_mag";};
player addHeadgear "H_PilotHelmetFighter_B";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁私人定制套餐，无法使用此功能!"
};