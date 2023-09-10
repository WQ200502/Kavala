//[this,'STAND','cocaine'] call NPC_fnc_processors;
params ["_obj_main","_stance",["_type","",[""]]];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance] call OEC_fnc_ambientAnim;
};

if !(playerSide isEqualTo civilian) exitWith {};

switch (_type) do {
	case "moonshine": {_obj_main addAction ['酿造私酒',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_sugar > 0 && life_inv_corn > 0 && life_inv_yeast > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "mushroom": {
		if !((typeOf _obj_main) isEqualTo "Land_Sink_F") then {
			_obj_main addAction ['加工蘑菇',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_mushroom > 0 && !oev_is_processing && isNull objectParent player',6];
			_obj_main addAction ['转化为神奇蘑菇',OEC_fnc_processAction,"mushroomu",1.5,false,false,"",'life_inv_mmushroom > 0 && !oev_is_processing && isNull objectParent player',6];
		} else {
			_obj_main addAction ['加工蘑菇',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_mushroom > 0 && !oev_is_processing && isNull objectParent player && {(bmFourSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		};
	};
	case "cocaine": {
		if !((typeOf _obj_main) isEqualTo "Land_Sink_F") then {
			_obj_main addAction ['加工可卡因',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_coke > 0 && !oev_is_processing && isNull objectParent player',6];
			_obj_main addAction ['转换为裂缝',OEC_fnc_processAction,"crack",1.5,false,false,"",'life_inv_cokep > 0 && !oev_is_processing && isNull objectParent player',6];
			_obj_main addAction [format['%1 ($%2)',["license_civ_coke"] call OEC_fnc_varToStr,[(["cocaine"] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"cocaine",1.5,false,false,"",'!license_civ_coke && playerSide isEqualTo civilian && isNull objectParent player',6];
		} else {
			_obj_main addAction ['加工可卡因',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_coke > 0 && !oev_is_processing && isNull objectParent player &&  {(bmOneSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		};
	};
	case "crystalmeth": {
		_obj_main addAction ['加工冰毒',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_lithium > 0 && life_inv_phosphorous > 0 && life_inv_ephedra > 0 && !oev_is_processing && isNull objectParent player',6];
	};
	case "frog": {
		_obj_main addAction ['加工青蛙迷幻药',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_frog > 0 && !oev_is_processing && isNull objectParent player',6];
		_obj_main addAction ['转化为酸',OEC_fnc_processAction,"acid",1.5,false,false,"",'life_inv_frogp > 0 && !oev_is_processing && isNull objectParent player',6];
	};
	case "silver": {_obj_main addAction ['加工银',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_silver > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "marijuana": {
		if !((typeOf _obj_main) isEqualTo "Land_Sink_F") then {
			_obj_main addAction ['加工大麻',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_cannabis > 0 && !oev_is_processing && isNull objectParent player',6];
			_obj_main addAction ['转换为哈希',OEC_fnc_processAction,"hash",1.5,false,false,"",'life_inv_marijuana > 0 && !oev_is_processing && isNull objectParent player',6];
		} else {
			_obj_main addAction ['加工大麻',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_cannabis > 0 && !oev_is_processing && isNull objectParent player && {(bmTwoSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		};
	};
	case "heroin": {
		if !((typeOf _obj_main) isEqualTo "Land_Sink_F") then {
			_obj_main addAction ['加工海洛因',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_heroinu > 0 && !oev_is_processing && isNull objectParent player',6];
			_obj_main addAction ['升级成纯海洛因',OEC_fnc_processAction,"pheroin",1.5,false,false,"",'life_inv_heroinp > 0 && !oev_is_processing && isNull objectParent player',6];
		} else {
			_obj_main addAction ['加工海洛因',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_heroinu > 0 && !oev_is_processing && isNull objectParent player && {(bmThreeSign getVariable ["owners",-1]) isEqualTo ((player getVariable ["gang_data",[0,"",0]]) select 0)}',6];
		};
	};
	case "iron": {_obj_main addAction ['加工铁',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_ironore > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "diamond": {_obj_main addAction ['加工钻石',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_diamond > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "copper": {_obj_main addAction ['加工铜',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_copperore > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "sand": {_obj_main addAction ['加工砂',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_sand > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "salt": {_obj_main addAction ['加工盐',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_salt > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "cement": {_obj_main addAction ['混合水泥',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_rock > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "oil": {_obj_main addAction ['加工石油',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_oilu > 0 && !oev_is_processing && isNull objectParent player',6];};
	case "platinum": {_obj_main addAction ['加工白金',OEC_fnc_processAction,_type,1.5,false,false,"",'life_inv_platinum > 0 && !oev_is_processing && isNull objectParent player',6];};
};

if ((typeOf _obj_main) isEqualTo "Land_Sink_F") exitWith {};

if !(_type in ["cocaine"]) then {
	_obj_main addAction [format['%1 (%2元)',[format["license_civ_%1",_type]] call OEC_fnc_varToStr,[([_type] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,_type,1.5,false,false,"",format['!license_civ_%1 && playerSide isEqualTo civilian && isNull objectParent player',_type],6];
};