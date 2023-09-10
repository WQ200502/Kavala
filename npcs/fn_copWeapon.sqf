//[this,'SIT_SAD1','Kavala'] call NPC_fnc_copWeapon;
params ["_obj_main","_stance",["_city","",[""]]];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"COP"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ["公安警察武器商店",OEC_fnc_weaponShopMenu,"cop_basic",1.5,false,false,"",'playerSide isEqualTo west',6];
_obj_main addAction ["一键取装（50W）",OEC_fnc_jcyjqz1,"cop_basic",1.5,false,false,"",'playerSide isEqualTo west',6];
_obj_main addAction ["一键取装（50W）",OEC_fnc_jcyjqz3,"cop_basic",1.5,false,false,"",'playerSide isEqualTo west',6];
_obj_main addAction [format['%1 (%2元)',['license_cop_air'] call OEC_fnc_varToStr,[(['cair'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"cair",1.5,false,false,"",'!license_cop_air && playerSide isEqualTo west && _this getVariable "rank" >= 2',6];

if !(_city isEqualTo "") then {
	_obj_main addAction ["<t color='#FF0000'>开始戒严</t>",OEC_fnc_martialLaw,[0,_city],1.5,false,false,"",'playerSide isEqualTo west && _this getVariable "rank" >= 4',6];
	_obj_main addAction ["<t color='#00FF00'>结束戒严</t>",OEC_fnc_martialLaw,[1,_city],1.5,false,false,"",'playerSide isEqualTo west && _this getVariable "rank" >= 4',6];
};

_obj_main addAction ["<t color='#FF0000'>授权致死</t>",OEC_fnc_poLethals,[0],1.5,false,false,"",'playerSide isEqualTo west && _this getVariable "rank" >= 6',6];
_obj_main addAction ["<t color='#00FF00'>取消授权致死</t>",OEC_fnc_poLethals,[1],1.5,false,false,"",'playerSide isEqualTo west && _this getVariable "rank" >= 6',6];

_obj_main addAction ["医疗协助",OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
_obj_main addAction [format['%1 ($%2)',['license_cop_cg'] call OEC_fnc_varToStr,[(['cg'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"cg",1.5,false,false,"",'!license_cop_cg && playerSide isEqualTo west && _this getVariable "rank" >= 1',6];
