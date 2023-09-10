//[this,'STAND'] call NPC_fnc_civRebelWeapon;
params ["_obj_main","_stance"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["叛军武器商店",OEC_fnc_weaponShopMenu,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["7.62机枪赞助（50W）",OEC_fnc_yjqz1,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["9.3狙击枪赞助（50W）",OEC_fnc_yjqz2,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["6.5机枪赞助（50W）",OEC_fnc_yjqz3,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction [".338狙击枪赞助（50W）",OEC_fnc_yjqz4,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["RPK轻机枪赞助（50W）",OEC_fnc_yjqz5,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["铁血套装赞助（30W）",OEC_fnc_yjqz6,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["私人定制（50W）",OEC_fnc_yjqz7,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["私人定制（50W）",OEC_fnc_yjqz8,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["私人定制（50W）",OEC_fnc_yjqz9,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["私人定制（50W）",OEC_fnc_yjqz10,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["私人定制（50W）",OEC_fnc_yjqz11,"rebel",1.5,false,false,"",'license_civ_rebel && playerSide isEqualTo civilian',6];
_obj_main addAction ["医疗求助",OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
_obj_main addAction[format['%1 (%2元)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'!license_civ_rebel && playerSide isEqualTo civilian',6];