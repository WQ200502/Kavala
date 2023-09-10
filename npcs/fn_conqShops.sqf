// File: fn_conqShops.sqf
params ["_obj_main","_type","_stance","_spawns"];

if (_obj_main isKindOf "Man") then {
	[_obj_main,_stance,"REBEL"] call OEC_fnc_ambientAnim;
};

switch (_type) do {
	case "weapon": {
		_obj_main addAction ["叛军武器商店",OEC_fnc_weaponShopMenu,"rebel",1.5,false,false,"",'oev_conquestData select 0 && license_civ_rebel && playerSide isEqualTo civilian',6];
		_obj_main addAction ["医疗求助",OEC_fnc_healHospital,"",1.5,false,false,"",'oev_conquestData select 0',6];
		_obj_main addAction [format['%1 ($%2)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'oev_conquestData select 0 && !license_civ_rebel && playerSide isEqualTo civilian',6];
	};
	case "market": {
		_obj_main addAction ["叛军市场",OEC_fnc_virt_menu,"rebel",1.5,false,false,"",'oev_conquestData select 0 && license_civ_rebel && playerSide isEqualTo civilian',6];
		_obj_main addAction ["医疗求助",OEC_fnc_healHospital,"",1.5,false,false,"",'oev_conquestData select 0',6];
		_obj_main addAction [format['%1 ($%2)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'oev_conquestData select 0 && !license_civ_rebel && playerSide isEqualTo civilian',6];
	};
	case "war": {
		_obj_main addAction ["战争点商店",OEC_fnc_weaponShopMenu,"war_market",1.5,false,false,"",'oev_conquestData select 0 && playerSide isEqualTo civilian',6];
	};
	case "clothing": {
		_obj_main addAction ["叛军服装店",OEC_fnc_clothingMenu,"reb",1.5,false,false,"",'oev_conquestData select 0 && license_civ_rebel && playerSide isEqualTo civilian',6];
		_obj_main addAction ["战争点服装店",OEC_fnc_clothingMenu,"war",1.5,false,false,"",'oev_conquestData select 0 && playerSide isEqualTo civilian',6];
		_obj_main addAction ["医疗求助",OEC_fnc_healHospital,"",1.5,false,false,"",'oev_conquestData select 0',6];
		_obj_main addAction [format['%1 ($%2)',['license_civ_rebel'] call OEC_fnc_varToStr,[(['rebel'] call OEC_fnc_licensePrice)] call OEC_fnc_numberText],OEC_fnc_buyLicense,"rebel",2,false,false,"",'oev_conquestData select 0 && !license_civ_rebel && playerSide isEqualTo civilian',6];
	};
	case "vehicle": {
		_obj_main addAction ["汽车商店",OEC_fnc_vehicleShopMenu,['reb_v',civilian,_spawns,'reb',"Olympus Rebel Vehicles"],1.5,false,false,"",'oev_conquestData select 0 && license_civ_rebel && isNull objectParent player',6];
		_obj_main addAction ["战争点汽车商店",OEC_fnc_vehicleShopMenu,['war_v',civilian,_spawns,'reb',"Olympus Warpoint Vehicles"],1.5,false,false,"",'oev_conquestData select 0 && license_civ_rebel && isNull objectParent player',6];
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'oev_conquestData select 0 && isNull objectParent player',6];
		_obj_main addAction ["空中车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'oev_conquestData select 0 && isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'oev_conquestData select 0 && isNull objectParent player && ((count oev_gang_data) > 0)',6];
		_obj_main addAction ["把载具存入车库",OEC_fnc_storeVehicle,30,1.5,false,false,"",'oev_conquestData select 0 && !oev_garage_store && isNull objectParent player',6];
	};
};