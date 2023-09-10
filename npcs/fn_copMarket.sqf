//[this,'STAND','Pyrgos_APD'] call NPC_fnc_copMarket;
params ["_obj_main","_stance","_dp"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"COP"] call OEC_fnc_ambientAnim;
};

_obj_main addAction ['公安警察物品商店',OEC_fnc_virt_menu,'cop',1.5,false,false,"",'playerSide isEqualTo west',6];
_obj_main addAction ['公安警察服装店',OEC_fnc_clothingMenu,'cop',1.5,false,false,"",'playerSide isEqualTo west',6];
_obj_main addAction ['医疗救助',OEC_fnc_healHospital,"",1.5,false,false,"",'',6];
if !(isNil "_dp") then {
	_obj_main addAction ['递送包裹',OEC_fnc_mdFinish,nil,1.5,false,false,"",'!isNil "oev_md_point" && oev_delivery_in_progress && oev_md_point == _target && playerSide isEqualTo independent',6];
	_obj_main addAction ['获取快递任务',OEC_fnc_getMDMission,_dp,1.5,false,false,"",'isNil "oev_md_point" && !oev_delivery_in_progress && playerSide isEqualTo independent',6];
};