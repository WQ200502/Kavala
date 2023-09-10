//[this,'STAND'] call NPC_fnc_civBlackMarket;
params ["_obj_main","_stance",["_type","",[""]]];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance] call OEC_fnc_ambientAnim;
};

switch (_type) do {
	case "bmOne": {
		_obj_main addAction ["黑市",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["武器装备",OEC_fnc_weaponShopMenu,"gang",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["服装店",OEC_fnc_clothingMenu,"bruce",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["枪支商店",OEC_fnc_weaponShopMenu, "gun",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["市场",OEC_fnc_virt_menu,"market",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,"genstore",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmOneSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
	};
	case "bmTwo": {
		_obj_main addAction ["黑市",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["武器装备",OEC_fnc_weaponShopMenu,"gang",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["服装店",OEC_fnc_clothingMenu,"bruce",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["枪支商店",OEC_fnc_weaponShopMenu, "gun",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["市场",OEC_fnc_virt_menu,"market",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,"genstore",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmTwoSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
	};
	case "bmThree": {
		_obj_main addAction ["黑市",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["武器装备",OEC_fnc_weaponShopMenu,"gang",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["服装店",OEC_fnc_clothingMenu,"bruce",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["枪支商店",OEC_fnc_weaponShopMenu, "gun",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["市场",OEC_fnc_virt_menu,"market",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,"genstore",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmThreeSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
	};
	case "bmFour": {
		_obj_main addAction ["黑市",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["武器装备",OEC_fnc_weaponShopMenu,"gang",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["服装店",OEC_fnc_clothingMenu,"bruce",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["枪支商店",OEC_fnc_weaponShopMenu, "gun",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["市场",OEC_fnc_virt_menu,"market",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		_obj_main addAction ["一般商店",OEC_fnc_weaponShopMenu,"genstore",1.5,false,false,"",'playerSide isEqualTo civilian && {(bmFourSign getVariable ["owners",-1]) != ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
	};
};
_obj_main addAction ["医疗求助",OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
