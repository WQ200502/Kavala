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

player addWeapon "LMG_Zafir_F";
player addPrimaryWeaponItem "optic_ACO_grn_smg";
player addPrimaryWeaponItem "150Rnd_762x54_Box";

player forceAddUniform "U_O_PilotCoveralls";
player addVest "V_PlateCarrierSpec_mtp";
player addBackpack "B_Bergen_dgtl_F";


for "_i" from 1 to 2 do {player addItemToVest "irstAidKit";};
for "_i" from 1 to 2 do {player addItemToVest "150Rnd_762x54_Box";};
for "_i" from 1 to 4 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 5 do {player addItemToBackpack "150Rnd_762x54_Box";};
player addHeadgear "H_PilotHelmetFighter_O";

player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

titleText["一键获取装备成功", "PLAIN"];
} else {
    hint "你没有解锁私人套餐，无法使用此功能!"
};