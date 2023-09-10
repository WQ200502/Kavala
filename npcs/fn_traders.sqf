//[this,'STAND','cocaine'] call NPC_fnc_traders;
params ["_obj_main","_stance",["_type","",[""]]];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance] call OEC_fnc_ambientAnim;
};

switch (_type) do {
	case "platinum": {_obj_main addAction ["白金商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "Wongs": {_obj_main addAction ["王氏龟市",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6]; _obj_main setVariable ["realname","Wong The Dong"]};
	case "redburger": {_obj_main addAction ["红汉堡",OEC_fnc_virt_menu,_type,1.5,false,false,"",'',6];};
	case "diamond": {_obj_main addAction ["钻石商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "silver": {_obj_main addAction ["白银商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "oil": {_obj_main addAction ["石油商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "iron": {_obj_main addAction ["铁铜商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "glass": {_obj_main addAction ["玻璃商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "goldbar": {_obj_main addAction ["金条商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "salvage": {_obj_main addAction ["救助市场",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "housing": {
		_obj_main addAction ["房地产经纪人地图",OEC_fnc_openHouseMarket,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["检查已售出物业资金",OEC_fnc_checkRealtor,[-1,1],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "fishmarket": {_obj_main addAction ["鱼市场",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "cement": {_obj_main addAction ["水泥商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "brew": {_obj_main addAction ["私酒商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "salt": {_obj_main addAction ["盐商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "market": {_obj_main addAction ["市场",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};
	case "heroin": {
		_obj_main addAction ["毒贩",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["询问毒贩",OEC_fnc_questionDealer,nil,1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player',6];
	};
	case "commodity": {_obj_main addAction ["商品商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];};

	case "genstore": {_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,_type,1.5,false,false,"",'isNull objectParent player',6];};
	case "bruce": {_obj_main addAction ["服装店",OEC_fnc_clothingMenu,_type,1.5,false,false,"",'playerSide isEqualTo civilian',6];};
	case "dive": {
		_obj_main addAction [format['%1 (%2元)',['license_civ_dive'] call OEC_fnc_varToStr,[(['dive'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'dive',1.5,false,false,"",'!license_civ_dive && playerSide isEqualTo civilian',6];
		_obj_main addAction ["潜水商店",OEC_fnc_clothingMenu,_type,1.5,false,false,"",'license_civ_dive && playerSide isEqualTo civilian',6];
		_obj_main addAction ["潜水用品店",OEC_fnc_virt_menu,_type,1.5,false,false,"",'license_civ_dive && playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "vigi": {
		_obj_main addAction [format['%1 (%2元)',['license_civ_gun'] call OEC_fnc_varToStr,[(['gun'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'gun',1.5,false,false,"",'!license_civ_gun && playerSide isEqualTo civilian',6];
		_obj_main addAction [format['%1 (%2元)',['license_civ_vigilante'] call OEC_fnc_varToStr,[(['vigilante'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,'vigilante',1.5,false,false,"",'!license_civ_vigilante && playerSide isEqualTo civilian && (O_stats_playtime_civ >= 120)',6];
		_obj_main addAction ["维吉兰特武器商店",OEC_fnc_weaponShopMenu,'vigilante',1.5,false,false,"",'license_civ_vigilante && playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["维吉兰特服装店",OEC_fnc_clothingMenu,'vig',1.5,false,false,"",'license_civ_vigilante && playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["维吉兰特市场",OEC_fnc_virt_menu,'vigilante',1.5,false,false,"",'license_civ_vigilante && playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["<t color='#ADFF2F'>ATM</t>",OEC_fnc_atmMenu,"",1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["<t color='#FF0000'>警戒规则</t>",OEC_fnc_vigiNotify,"",1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ['医疗协助',OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
		_obj_main addAction ["商店逮捕",OEC_fnc_storeVigilanteArrests,0,1.5,false,false,"",'(oev_vigiarrests > 0) && license_civ_vigilante && playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["要求逮捕",OEC_fnc_storeVigilanteArrests,1,1.5,false,false,"",'(oev_vigiarrests_stored > 0) && license_civ_vigilante && playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "art": {
		_obj_main addAction ["绘画商人",OEC_fnc_virt_menu,_type,1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
};
