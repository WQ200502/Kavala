//[this] call NPC_fnc_civGun;
params ["_obj_main"];
_obj_main enableSimulation false;
removeAllWeapons _obj_main;

_obj_main addAction ["枪支商店",OEC_fnc_weaponShopMenu,"gun",1.5,false,false,"",'license_civ_gun && !license_civ_wpl && playerSide isEqualTo civilian',6];
_obj_main addAction ["普通民众保护商店",OEC_fnc_weaponShopMenu,"wplgun",1.5,false,false,"",'license_civ_gun && license_civ_wpl && playerSide isEqualTo civilian',6];
_obj_main addAction[format['%1 ($%2)',['license_civ_gun'] call OEC_fnc_varToStr,[(['gun'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"gun",2,false,false,"",' !license_civ_gun && playerSide isEqualTo civilian',6];
_obj_main addAction[format['%1 ($%2)',['license_civ_wpl'] call OEC_fnc_varToStr,[(["wpl"] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"wpl",1.5,false,false,"",'license_civ_gun && !license_civ_wpl && playerSide isEqualTo civilian',6];