//	File: fn_medVehicles.sqf
//	Author: TheCmdrRex
//************************************
//	Texture Types:
//		"EMT"
//		"Paramedic"
//		"SnR"
//		"Diving"
//
//	Spawn Types:
//		"car"
//		"heli"
//		"ship"
//************************************
params ["_obj_main","_spawns","_stance","_type","_texture"];
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
	default {};
};

switch (_type) do {
	case "car": {
		_obj_main addAction ["地面车辆商店",OEC_fnc_vehicleShopMenu,["med_shop",independent,_spawns,"med","R&R Ground Vehicle Shop"],1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
		_obj_main addAction ["地面车库", {["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo independent',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
			};

	case "heli": {
		_obj_main addAction [format["%1 (%2元)",["license_med_air"] call OEC_fnc_varToStr,[(["mair"] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"mair",1.5,false,false,"",' !license_med_air && playerSide isEqualTo independent && isNull objectParent player',6];
		_obj_main addAction ["直升机商店",OEC_fnc_vehicleShopMenu,["med_air_hs",independent,_spawns,"med","R&R Helicopter Shop"],1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player && _this getVariable "rank" >= 3',6];
		_obj_main addAction ["飞机机库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo independent && _this getVariable "rank" >= 3',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
		_obj_main addAction ["购买多巴胺板条箱",OEC_fnc_buyDopamineCrate,nil,5,true,true,"",'playerSide isEqualTo independent && !oev_newsTeam && isNull objectParent player',6];
	};

	case "ship": {
		_obj_main addAction [format["%1 (%2元)",["license_med_cg"] call OEC_fnc_varToStr,[(["mcg"] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"mcg",1.5,false,false,"",' !license_med_cg && playerSide isEqualTo independent',6];
		_obj_main addAction ["医生服装店",OEC_fnc_clothingMenu,"medic",1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
		_obj_main addAction ["医生船商店",OEC_fnc_vehicleShopMenu,["med_ship",independent,_spawns,"med","EMS Boat Store"],1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
		_obj_main addAction ["医生船码头",{["Ship",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo independent',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
	};
};