//[this,['cop_ship_2'],'REPAIR_VEH_KNEEL','ship'] call NPC_fnc_copVehicles;
params ["_obj_main","_spawns","_stance","_type"];

if (_obj_main isKindOf "Man" && !(_stance isEqualTo "NONE")) then {
	if (_type in ["plane","planeBW"]) then {
		[_obj_main,_stance] call OEC_fnc_ambientAnim;
	} else {
		[_obj_main,_stance,"COP"] call OEC_fnc_ambientAnim;
	};
};

switch (_type) do {
	case "car": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo west',6];
		_obj_main addAction ["地面车辆商店",OEC_fnc_vehicleShopMenu,["cop_car",west,_spawns,"cop","APD Land Vehicle Shop"],1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
		/*if ((_obj_main distance2D [17396,13241.9,1]) < 20) then {
			_obj_main addAction ["Teleport to Training Island",OEC_fnc_handleCopIsland,"",1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player',6];
		};*/
	};
	case "heli": {
		_obj_main addAction ["飞机机库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo west && _this getVariable "rank" >= 2',6];
		_obj_main addAction ["直升机商店",OEC_fnc_vehicleShopMenu,["cop_air",west,_spawns,"cop","APD Helicopter Shop"],1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player && _this getVariable "rank" >= 2',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
	};
	case "plane": {
		_obj_main addAction ["飞机车库",{["Plane",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo west && _this getVariable "rank" >= 3',6];
		_obj_main addAction ["飞机商店",OEC_fnc_vehicleShopMenu,["cop_plane",west,_spawns,"cop","APD Plane Shop"],1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player && _this getVariable "rank" >= 3',6];
	};
	case "planeBW": {
		_obj_main addAction ["飞机车库",{["Plane",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((life_bwObj getVariable "robtime") <= time) && playerSide isEqualTo west && _this getVariable "rank" >= 3',6];
		_obj_main addAction ["Plane Shop",OEC_fnc_vehicleShopMenu,["cop_plane",west,_spawns,"cop","APD Plane Shop"],1.5,false,false,"",'playerSide isEqualTo west && ((life_bwObj getVariable "robtime") <= time) && isNull objectParent player && _this getVariable "rank" >= 3',6];
	};
	case "ship": {
		_obj_main addAction ["船码头",{["Ship",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide in [west,independent]',6];
		_obj_main addAction ["船商店",OEC_fnc_vehicleShopMenu,["cop_ship",west,_spawns,"cop","APD Boat Store"],1.5,false,false,"",'playerSide isEqualTo west && isNull objectParent player',6];
		_obj_main addAction ["船商店",OEC_fnc_vehicleShopMenu,["med_ship",independent,_spawns,"med","EMS Boat Store"],1.5,false,false,"",'playerSide isEqualTo independent && isNull objectParent player',6];
		_obj_main addAction ["将车辆存放在车库中",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
	};
};