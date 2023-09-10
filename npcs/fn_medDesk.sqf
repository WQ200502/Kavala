//	File: fn_medDesk.sqf
//  Author: TheCmdrRex
//************************************
//	Texture Types:
//		"EMT"
//		"Paramedic"
//		"SnR"
//		"Diving"
//************************************

params ["_obj_main","_stance","_texture"];
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

_obj_main addAction ['医疗协助',OEC_fnc_healHospital,"",1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ["接受多巴胺",OEC_fnc_giveDopamine,player,1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ["接受肾脏移植",OEC_fnc_replaceKidney,player,1.5,false,false,"",'isNull objectParent player',6];
_obj_main addAction ["重新部署",{[] call medredeploy},nil,1.5,false,false,"","playerSide isEqualTo independent && !oev_inCombat && !oev_newsTeam && isNull objectParent player",6];
