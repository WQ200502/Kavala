//	File: fn_medMarket.sqf
//  Author: TheCmdrRex
//************************************
//	Texture Types:
//		"EMT"
//		"Paramedic"
//		"SnR"
//		"Diving"
//************************************

params ["_obj_main","_stance","_dp","_texture"];
if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"MEDIC"] call OEC_fnc_ambientAnim;
};
switch (_texture) do {
	case "EMT": {
		_obj_main addHeadgear "H_Cap_blu";
	};
	case "Paramedic": {
		_obj_main addHeadgear "H_Cap_red";
	};
	case "SnR": {
		_obj_main addHeadgear "H_CrewHelmetHeli_O";
	};
	default {
		_obj_main addHeadgear "H_Cap_blu";
	};
};

_obj_main addAction ['医生市场',OEC_fnc_virt_menu,'medic',1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ['医生服装店',OEC_fnc_clothingMenu,'medic',1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
_obj_main addAction ['医生物品商店',OEC_fnc_weaponShopMenu,'med_basic',1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
_obj_main addAction ['医生综合商店',OEC_fnc_weaponShopMenu,'genstore',1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ['递送包裹',OEC_fnc_mdFinish,nil,1.5,false,false,"",'!isNil "oev_md_point" && oev_delivery_in_progress && oev_md_point == _target && playerSide isEqualTo independent',6];
_obj_main addAction ['获取快递任务',OEC_fnc_getMDMission,_dp,1.5,false,false,"",'isNil "oev_md_point" && !oev_delivery_in_progress && playerSide isEqualTo independent',6];