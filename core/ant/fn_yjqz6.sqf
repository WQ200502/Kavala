titleText["正在一键获取装备", "PLAIN"];
if (call oev_donator >= 500) then {
_basePrice = 300000;
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

player addWeapon "";
player addPrimaryWeaponItem "";
player addPrimaryWeaponItem "";
player addPrimaryWeaponItem "";
player addPrimaryWeaponItem "";

player forceAddUniform "U_O_V_Soldier_Viper_F";
player addVest "V_PlateCarrierSpec_wdl";
player addBackpack "B_Bergen_dgtl_F";

for "_i" from 1 to 2 do {player addItemToUniform "";};
for "_i" from 1 to 2 do {player addItemToVest "";};
for "_i" from 1 to 3 do {player addItemToVest "";};
for "_i" from 1 to 11 do {player addItemToBackpack "";};
for "_i" from 1 to 12 do {player addItemToBackpack "";};
player addHeadgear "H_HelmetO_ViperSP_ghex_F";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁F套餐，无法使用此功能!"
};