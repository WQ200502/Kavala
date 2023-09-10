//[this,['civ_air_3'],'STAND','heli'] call NPC_fnc_civGarages;
params ["_obj_main","_spawns","_stance","_type"];

if (_obj_main isKindOf "Man") then {
	if !(_type in ["planeShop","planeShopBW"]) then {
		[_obj_main,_stance] call OEC_fnc_ambientAnim;
	};
};

switch (_type) do {
	case "carShop": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["地面车辆商店",OEC_fnc_vehicleShopMenu,["civ_car",civilian,_spawns,"civ","Olympus Autos"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "heli": {
		_obj_main addAction ["飞机车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
	};
	case "heliShop": {
		_obj_main addAction ["飞机车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["直升机商店",OEC_fnc_vehicleShopMenu,["civ_air",civilian,_spawns,"civ","Olympus Air"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "heliShopBW": {
		_obj_main addAction ["飞机车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["直升机商店",OEC_fnc_vehicleShopMenu,["civ_air",civilian,_spawns,"civ","Olympus Air"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "ship": {
		_obj_main addAction ["船码头",{["Ship",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["船商店",OEC_fnc_vehicleShopMenu,["civ_ship",civilian,_spawns,"civ","Olympus Boat Marina"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "truck": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["卡车商店",OEC_fnc_vehicleShopMenu,["civ_truck",civilian,_spawns,"civ","Olympus Truck"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "groundGarage": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "groundGarageBW": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "prisonGarage": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((jailwall getVariable "robtime") <= time)',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "bmGarage": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["飞机车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
	case "rebBoat": {
		_obj_main addAction ["船码头",{["Ship",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["船商店",OEC_fnc_vehicleShopMenu,["reb_boat",civilian,_spawns,"reb","Rebel Boat Shop"],1.5,false,false,"",'playerSide isEqualTo civilian && license_civ_rebel && isNull objectParent player',6];
		//_obj_main addVest "V_RebreatherIR";
		//_obj_main addUniform "U_O_Wetsuit";
	};
	case "planeShop": {
		_obj_main addAction ["飞机车库",{["Plane",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo civilian',6];
		_obj_main addAction ["飞机修理厂",OEC_fnc_vehicleShopMenu,["civ_plane",civilian,_spawns,"civ","Olympus Plane Shop"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "planeShopBW": {
		_obj_main addAction ["飞机车库",{["Plane",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && playerSide isEqualTo civilian',6];
		_obj_main addAction ["飞机修理厂",OEC_fnc_vehicleShopMenu,["civ_plane",civilian,_spawns,"civ","Olympus Plane Shop"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player',6];
	};
	case "vigiShop": {
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["地面车辆商店",OEC_fnc_vehicleShopMenu,["vigi_car",civilian,_spawns,"civ","Olympus Autos"],1.5,false,false,"",'playerSide isEqualTo civilian && isNull objectParent player && license_civ_vigilante',6];
	};
	case "airground": {
		_obj_main addAction ["飞机车库",{["Air",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["地面车库",{["Car",_this select 3] call OEC_fnc_handleVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player',6];
		_obj_main addAction ["帮派车库",{["Car",_this select 3] call OEC_fnc_handleGangVehicles;},_spawns,1.5,false,false,"",'isNull objectParent player && ((count oev_gang_data) > 0)',6];
	};
};

if !(_type isEqualTo "bmGarage") then {
	_obj_main addAction ["把载具存入车库",OEC_fnc_storeVehicle,30,1.5,false,false,"",'!oev_garage_store && isNull objectParent player',6];
};